import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:torani/app/env/colors.dart';
import 'package:torani/app/modules/home/views/home_view.dart';
import 'package:torani/app/modules/profile/views/profile_view.dart';
import 'package:torani/app/modules/stock/views/stock_view.dart';

import '../controllers/tab_decider_controller.dart';

class TabDeciderView extends GetView<TabDeciderController> {
  TabDeciderController tabDeciderController = Get.put(TabDeciderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // #000000 Opacity 10%
              offset: Offset(4, 8), // X: 4, Y: 8
              blurRadius: 24, // Blur: 24
              spreadRadius: 0, // Spread: 0
            ),
          ], borderRadius: BorderRadius.circular(12), color: Color(0xFFFFFFFF)),
          child: SalomonBottomBar(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 8, top: 8),
            currentIndex: tabDeciderController.currentIndex.value,
            onTap: (i) {
              tabDeciderController.currentIndex.value = i;
              tabDeciderController.tabController.index = i;
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Beranda"),
                  selectedColor: primaryColor,
                  unselectedColor: Colors.black.withOpacity(0.3)),

              /// Likes
              SalomonBottomBarItem(
                  icon: Icon(Icons.food_bank),
                  title: Text("Produk"),
                  selectedColor: primaryColor,
                  unselectedColor: Colors.black.withOpacity(0.3)),

              SalomonBottomBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Profile"),
                  selectedColor: primaryColor,
                  unselectedColor: Colors.black.withOpacity(0.3)),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabDeciderController.tabController,
        children: [HomeView(), StockView(), ProfileView()],
      ),
    );
  }
}
