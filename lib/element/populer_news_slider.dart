import 'dart:convert';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Utils/date_formater.dart';
import 'package:news_app/model/news.dart';
import 'package:http/http.dart' as http;

class PopulerNewsSlider extends StatefulWidget {
  const PopulerNewsSlider({super.key});

  @override
  State<PopulerNewsSlider> createState() => _PopulerNewsSliderState();
}

class _PopulerNewsSliderState extends State<PopulerNewsSlider> {
  Future<News> newsFuture = getNews();

  static Future<News> getNews() async {
    var url = Uri.parse(
        'https://newsdata.io/api/1/news?apikey=pub_45631745044b656feaf52d60fd622d1cc2df1&q=gizi&country=id&language=id&category=top');
    final response = await http.get(url);
    final Map<String, dynamic> json = jsonDecode(response.body);
    return News.fromJson(json);
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
            return buildNews(newses.results!);
          } else {
            return const Text('Error');
          }
        },
      ),
    );
  }

  Widget buildNews(List<Results> newses) {
    return CarouselSlider(
      items: newses
          .take(5) // Take only the first 5 news
          .map(
            (news) => Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.fromLTRB(12, 160, 12, 12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                image: DecorationImage(
                  image: NetworkImage(news.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.9),
                        ],
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news.sourceName!,
                                  style: const TextStyle(fontSize: 12),
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
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/images/ic_send.png",
                                width: 24,
                                color: Colors.blue[400],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: 300.0,
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
