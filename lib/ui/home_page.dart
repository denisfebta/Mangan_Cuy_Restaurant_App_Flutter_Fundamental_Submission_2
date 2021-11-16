import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_denis/common/style.dart';
import 'package:restaurant_denis/data/api/api_service.dart';
import 'package:restaurant_denis/provider/restaurant_provider.dart';
import 'package:restaurant_denis/provider/restaurant_search_provider.dart';
import 'package:restaurant_denis/ui/search_page.dart';
import 'package:restaurant_denis/ui/settings_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'list_app_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexBottomNav = 1;
  List<Widget> widgetOptions = [
    ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: ListAppPage(),
    ),
    ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(apiService: ApiService()),
      child: SearchPage(),
    ),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(indexBottomNav),
      bottomNavigationBar: SalomonBottomBar(
          onTap: (index) {
            setState(() {
              indexBottomNav = index;
            });
          },
          currentIndex: indexBottomNav,
          items: [
            SalomonBottomBarItem(
                icon: Icon(Icons.list),
                title: Text("List"),
                selectedColor: mainColor),
            SalomonBottomBarItem(
                icon: Icon(Icons.fastfood),
                title: Text("Welcome"),
                selectedColor: mainColor),
            SalomonBottomBarItem(
                icon: Icon(Icons.settings),
                title: Text("Preference"),
                selectedColor: mainColor),
          ]),
    );
  }
}
