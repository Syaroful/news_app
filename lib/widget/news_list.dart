import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/Utils/date_formater.dart';
import 'package:news_app/model/news.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key, this.category});

  final String? category;

  @override
  State<NewsList> createState() => _HomePageState();
}

class _HomePageState extends State<NewsList> {
  Future<News> newsFuture = getNews('');

  @override
  void initState() {
    super.initState();
    String category = widget.category ?? 'terbaru';
    newsFuture = getNews(category);
  }

  static Future<News> getNews(String category) async {
    var url =
        Uri.parse('https://api-berita-indonesia.vercel.app/cnn/$category');
    final response = await http.get(url);
    final Map<String, dynamic> json = jsonDecode(response.body);
    return News.fromJson(json);
  }

  _launchUrl(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<News>(
      future: newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => const NewsCardSkeleton(),
            itemCount: 8,
          );
        } else if (snapshot.hasData) {
          final newses = snapshot.data!;
          return buildNews(newses.data!.posts!);
        } else {
          return const Text('Error');
        }
      },
    );
  }

  Widget buildNews(List<Posts> newses) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: newses.length,
      itemBuilder: (context, index) {
        final news = newses[index];
        return Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(news.thumbnail!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatDateIndonesian(news.pubDate!),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                      child: Text(
                        'Terbaru',
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class NewsCardSkeleton extends StatelessWidget {
  const NewsCardSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingSkeleton(
            height: 90,
            width: 90,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingSkeleton(height: 12),
                SizedBox(height: 8),
                LoadingSkeleton(height: 12),
                SizedBox(height: 16),
                LoadingSkeleton(height: 10),
                SizedBox(height: 16),
                LoadingSkeleton(height: 10, width: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({
    super.key,
    this.height,
    this.width,
  });

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
