import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app_riverpod/features_trip/presentation/pages/add_trip_screen.dart';
import 'package:travel_app_riverpod/features_trip/presentation/pages/my_trip_screen.dart';
import 'package:travel_app_riverpod/features_trip/presentation/providers/trip_provider.dart';

class MainScreen extends ConsumerWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tripListNotifierProvider.notifier).loadTrip();
    _pageController.addListener(() {
      _currentPage.value = _pageController.page!.round();
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello Fabrice",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                "Travelling Today ?",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: [
            MyTripScreen(),
            AddTripScreen(),
            Text('3'),
          ],
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, pageIndex, child) {
            return BottomNavigationBar(
              currentIndex: pageIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: "My trips"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add), label: "Add trips"),
                BottomNavigationBarItem(icon: Icon(Icons.map), label: "Maps"),
              ],
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
            );
          },
        ),
      ),
    );
  }
}
