import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rana_hna/Themes/colors.dart';
import 'package:rana_hna/view/widgets.dart';

import '../../controller/something_controller.dart';

class TransmitterType extends StatelessWidget {
  const TransmitterType({super.key});

  @override
  Widget build(BuildContext context) {
    final SomethingController somethingController = Get.find();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          leading: const BackIconButton(),
          actions: [
            IconButton(
                onPressed: () {
                  somethingController.inputSearch("");
                  somethingController.searchType("");
                },
                icon: const Icon(Icons.clear)),
            const SizedBox(width: 10)
          ],
          title: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search here",
            ),
            onChanged: (input) {
              somethingController.inputSearch(input);
              somethingController.searchType(input);
            },
          ),
        ),
        body: GetBuilder<SomethingController>(builder: (context) {
          return ListView.separated(
            itemCount: somethingController.transmitterTypeList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset(
                    somethingController.transmitterTypeList[index].image!),
                title: Text(
                  somethingController.transmitterTypeList[index].mainText!,
                  style: const TextStyle(
                      color: blackColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  somethingController.transmitterTypeList[index].subText!,
                  style: TextStyle(color: greyColor, fontSize: 15),
                ),
                onTap: () {
                  somethingController.chooseType(index);
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        }));
  }
}
