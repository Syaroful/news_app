import 'package:flutter/material.dart';
import 'package:news_app/element/news_list.dart';
import 'package:news_app/element/populer_news_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(8, 48, 8, 8),
          child: Expanded(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                      'https://akcdn.detik.net.id/visual/2024/07/24/minji-newjeans-1_169.jpeg?w=650'),
                ),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Selamat Pagi!',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Minji Newjeans',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                ClipOval(
                  child: Material(
                    color: Colors.grey[200],
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          "assets/images/ic_notification.png",
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text(
            "Berita Terbaru",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const PopulerNewsSlider(),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text(
            "Rekomendasi Untuk Anda",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
