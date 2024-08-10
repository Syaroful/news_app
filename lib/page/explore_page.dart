import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/widget/news_list.dart';
import 'package:news_app/model/category.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int selectedCategoryIndex = 0;
  List<NewsCategory> categories = [
    NewsCategory(
        name: 'Nasional',
        endPoint: 'nasional/',
        image: 'assets/images/indonesia.png'),
    NewsCategory(
        name: 'Internasional',
        endPoint: 'internasional/',
        image: 'assets/images/indonesia.png'),
    NewsCategory(
        name: 'Ekonomi',
        endPoint: 'ekonomi/',
        image: 'assets/images/indonesia.png'),
    NewsCategory(
        name: 'Olahraga',
        endPoint: 'olahraga/',
        image: 'assets/images/indonesia.png'),
    NewsCategory(
        name: 'Teknologi',
        endPoint: 'teknologi/',
        image: 'assets/images/indonesia.png'),
    NewsCategory(
        name: 'Hiburan',
        endPoint: 'hiburan/',
        image: 'assets/images/indonesia.png'),
    NewsCategory(
        name: 'Gaya Hidup',
        endPoint: 'gayaHidup/',
        image: 'assets/images/indonesia.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 48),
          Container(
            padding: const EdgeInsets.only(left: 16),
            height: 40,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    decoration: BoxDecoration(
                        color: selectedCategoryIndex == index
                            ? Colors.indigo
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(categories[index].image),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          categories[index].name,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: selectedCategoryIndex == index
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                itemCount: categories.length),
          )
        ],
      ),
    );
  }
}
