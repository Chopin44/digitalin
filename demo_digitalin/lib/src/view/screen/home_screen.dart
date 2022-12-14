import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_digitalin/core/app_color.dart';
import 'package:demo_digitalin/core/app_data.dart';
import 'package:demo_digitalin/src/view/screen/cart_screen.dart';
import 'package:demo_digitalin/src/view/screen/favorite_screen.dart';
import 'package:demo_digitalin/src/view/screen/subcription_list_screen.dart';
import 'package:demo_digitalin/src/view/screen/profile_screen.dart';
import '../../controller/subscription_controller.dart';
import 'checkout_screen.dart';

final OfficeFurnitureController controller =
    Get.put(OfficeFurnitureController());

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final List<Widget> screens = const [
    OfficeFurnitureListScreen(),
    CartScreen(),
    FavoriteScreen(),
    Checkout(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            currentIndex: controller.currentBottomNavItemIndex.value,
            showUnselectedLabels: true,
            onTap: controller.switchBetweenBottomNavigationItems,
            fixedColor: AppColor.lightBlack,
            items: AppData.bottomNavigationItems
                .map(
                  (element) => BottomNavigationBarItem(
                      icon: element.icon, label: element.label),
                )
                .toList(),
          );
        },
      ),
      body: Obx(() => screens[controller.currentBottomNavItemIndex.value]),
    );
  }
}
