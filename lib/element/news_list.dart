import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/Utils/date_formater.dart';
import 'package:news_app/model/news.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _HomePageState();
}

class _HomePageState extends State<NewsList> {
  Future<News> newsFuture = getNews();

  static Future<News> getNews() async {
    var url = Uri.parse(
        'https://newsdata.io/api/1/news?apikey=pub_45631745044b656feaf52d60fd622d1cc2df1&country=id&language=id');
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
    return Center(
      child: FutureBuilder<News>(
        future: newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemBuilder: (context, index) => const NewsCardSkeleton(),
              itemCount: 8,
            );
          } else if (snapshot.hasData) {
            final newses = snapshot.data!;
            return buildNews(newses.results!);
          } else {
            return const Text('Error');
          }
        },
      ),
    );
  }

  Widget buildNews(List<Results> newses) {
    return ListView.builder(
      itemCount: newses.length,
      itemBuilder: (context, index) {
        final news = newses[index];
        return GestureDetector(
          onTap: () => _launchUrl(news.link!),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(news.imageUrl ??
                          'https://seotest.guwahatiplus.com/public/web/images/default-news.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        news.description!,
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            news.sourceName!,
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            " • ",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            formatDateIndonesian(news.pubDate!),
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
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
      margin: const EdgeInsets.all(16),
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
