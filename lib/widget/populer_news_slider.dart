import 'dart:convert';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Utils/date_formater.dart';
import 'package:news_app/model/news.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PopulerNewsSlider extends StatefulWidget {
  const PopulerNewsSlider({super.key});

  @override
  State<PopulerNewsSlider> createState() => _PopulerNewsSliderState();
}

class _PopulerNewsSliderState extends State<PopulerNewsSlider> {
  Future<News> newsFuture = getNews();

  static Future<News> getNews() async {
    var url =
        Uri.parse('https://api-berita-indonesia.vercel.app/cnn/internasional/');
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
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingSkeleton(height: 200),
                SizedBox(height: 8),
                LoadingSkeleton(height: 10),
                SizedBox(height: 4),
                LoadingSkeleton(height: 10, width: 50),
              ],
            );
          } else if (snapshot.hasData) {
            final newses = snapshot.data!;
            return buildNews(newses.data!.posts!);
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 100),
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }

  Widget buildNews(List<Posts> newses) {
    return CarouselSlider(
      items: newses
          .take(5)
          .map(
            (news) => Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(news.thumbnail!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatDateIndonesian(news.pubDate!),
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      news.title!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      news.description!,
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                  ],
                )),
          )
          .toList(),
      options: CarouselOptions(
        height: 320,
        viewportFraction: 1,
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
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
