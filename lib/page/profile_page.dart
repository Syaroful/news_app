import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 48),
      const Center(
        child: Text(
          'Profile Page',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16),
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
                  'Minji Newjeans',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Online',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
                style: ButtonStyle(
                  elevation: WidgetStateProperty.all(0),
                  backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
                ),
                onPressed: () {},
                child: Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ))
          ],
        ),
      ),
      const SettingItem(
        title: "newjeans.minji@gmail.com",
        imageSource: "assets/icons/ic_mail.png",
      ),
      const SettingItem(
        title: "+62 813-1234-5678",
        imageSource: "assets/icons/ic_phone.png",
      ),
      const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Akun",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      const SettingItem(
        title: "Account",
        imageSource: "assets/icons/ic_account.png",
      ),
      const SettingItem(
        title: "Call Center",
        imageSource: "assets/icons/ic_call.png",
      ),
      const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Lainnya",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      const SettingItem(
        title: "Notification",
        imageSource: "assets/images/ic_notification.png",
      ),
      const SettingItem(
        title: "Terms of Service",
        imageSource: "assets/icons/ic_document.png",
      ),
      const SettingItem(
        title: "Privacy and Security",
        imageSource: "assets/icons/ic_security.png",
      ),
      const SettingItem(
        title: "Logout",
        imageSource: "assets/icons/ic_logout.png",
        color: Colors.red,
      ),
    ]);
  }
}

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    required this.imageSource,
    this.onTap,
    this.color,
  });

  final String title;
  final String imageSource;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  imageSource,
                  width: 20,
                  color: color ?? Colors.black,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: color ?? Colors.black),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}
