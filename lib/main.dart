import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/page/bookmark_page.dart';
import 'package:news_app/page/explore_page.dart';
import 'package:news_app/page/home_page.dart';
import 'package:news_app/page/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade900),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    HomePage(),
    ExplorePage(),
    BookmarkPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          bottomNavBarItem("assets/images/ic_home.png",
              "assets/images/ic_home_active.png", "Home"),
          bottomNavBarItem("assets/images/ic_search.png",
              "assets/images/ic_search_active.png", "Explore"),
          bottomNavBarItem("assets/images/ic_bookmark.png",
              "assets/images/ic_bookmark_active.png", "Bookmark"),
          bottomNavBarItem("assets/images/ic_profile.png",
              "assets/images/ic_profile_active.png", "Profile"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey[900],
        onTap: _onItemTapped,
      ),
    );
  }

  BottomNavigationBarItem bottomNavBarItem(
      String icon, String activeIcon, String label) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          icon,
          width: 24,
          color: Colors.grey[400],
        ),
        activeIcon: Image.asset(
          activeIcon,
          width: 24,
          color: Colors.grey[900],
        ),
        label: label);
  }
}
