import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rana_hna/Themes/colors.dart';
import 'package:rana_hna/view/driver_view/add_trip.dart';
import 'package:rana_hna/view/driver_view/help_driver.dart';
import 'package:rana_hna/view/profil.dart';

import '../../controller/driver_home_screen_controller.dart';
import '../widgets.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DriverHomeScreenController homeScreenController = Get.find();

    List<BottomNavigationBarItem> bottomNavigationBarItemList = [
      const BottomNavigationBarItem(
        label: "",
        icon: Icon(Icons.home),
        activeIcon: ActiveBottomBarIcon(
          widgetIcon: Icon(Icons.home),
        ),
      ),
      const BottomNavigationBarItem(
        label: "",
        icon: Icon(Icons.help),
        activeIcon: ActiveBottomBarIcon(
          widgetIcon: Icon(Icons.help),
        ),
      ),
      const BottomNavigationBarItem(
        label: "",
        icon: Icon(Icons.person),
        activeIcon: ActiveBottomBarIcon(
          widgetIcon: Icon(Icons.person),
        ),
      ),
    ];

    const List<Widget> bottomNavigationBarScreensList = [
      AddTrip(),
      HelpDriver(),
      Profil()
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar:
          GetBuilder<DriverHomeScreenController>(builder: (context) {
        return BottomNavigationBar(
          //  backgroundColor: backgroundColor,
          items: bottomNavigationBarItemList,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: whiteColor,
          elevation: 0,
          currentIndex: homeScreenController.currentBottomBarIndex(),
          onTap: (index) {
            homeScreenController.switchBetweenScreens(index);
          },
        );
      }),
      body: GetBuilder<DriverHomeScreenController>(builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            const BackgroundImage(),
            bottomNavigationBarScreensList[
                homeScreenController.currentBottomBarIndex()],
          ],
        );
      }),
    );
  }
}
