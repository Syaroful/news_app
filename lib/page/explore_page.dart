import 'package:flutter/material.dart';
import 'package:news_app/element/news_list.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: NewsList(),
    );
  }
}
