import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rana_hna/Themes/colors.dart';

import '../../controller/customer_home_screen_controller.dart';
import '../../main.dart';
import '../profil.dart';
import '../widgets.dart';
import 'help_customer.dart';
import 'people_or_something.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainFunctions.checkInternetConnection();
    final CustomerHomeScreenController homeScreenController = Get.find();

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
      PeopleOrSomething(),
      HelpCustomer(),
      Profil()
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar:
          GetBuilder<CustomerHomeScreenController>(builder: (context) {
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
      body: GetBuilder<CustomerHomeScreenController>(builder: (context) {
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
