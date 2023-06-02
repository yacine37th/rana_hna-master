import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:rana_hna/Themes/colors.dart';
import 'package:rana_hna/main.dart';
import 'package:rana_hna/view/widgets.dart';

class MyTransmitterTrips extends StatelessWidget {
  const MyTransmitterTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackIconButton(),
          title: const Text("My transmitter trips"),
          actions: [
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "Filter by : ",
                    content: Column(
                      children: [
                        TextButton.icon(
                            onPressed: () async {
                              currentUserInfos.currentUserTransmitterTrips
                                  ?.sort(
                                (a, b) {
                                  DateTime dateA = DateTime.parse(a.tripDate!);
                                  DateTime dateB = DateTime.parse(b.tripDate!);

                                  return dateA.compareTo(dateB);
                                },
                              );
                              await Get.forceAppUpdate();

                              navigator?.pop();
                            },
                            icon: const Text("Date"),
                            label: const Icon(
                              Icons.date_range,
                              size: 25,
                              color: Colors.white,
                            )),
                        const SizedBox(height: 10),
                        TextButton.icon(
                            onPressed: () async {
                              currentUserInfos.currentUserTransmitterTrips
                                  ?.sort(
                                (a, b) {
                                  return a.price!.compareTo(b.price as num);
                                },
                              );
                              await Get.forceAppUpdate();

                              navigator?.pop();
                            },
                            icon: const Text("Price"),
                            label: const Icon(
                              Icons.monetization_on,
                              size: 25,
                              color: Colors.amber,
                            )),
                      ],
                    ));
              },
              icon: const Icon(
                Icons.filter_list_rounded,
                color: tealColor,
              ),
              iconSize: 30,
            )
          ],
        ),
        body: Builder(builder: (context) {
          MainFunctions.checkInternetConnection();
          if (currentUserInfos.currentUserTransmitterTrips!.isEmpty) {
            return const Center(
              child: Text("No results"),
            );
          } else {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              shrinkWrap: true,
              itemCount: currentUserInfos.currentUserTransmitterTrips!.length,
              itemBuilder: (context, index) {
                return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                0.0, 2.0), // shadow direction: bottom right
                          )
                        ]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ClipOval(
                                    child: Container(
                                      alignment: Alignment.center,
                                      color:
                                          MainFunctions.generatePresizedColor(
                                              currentUserInfos
                                                  .currentUserTransmitterTrips![
                                                      index]
                                                  .driverUserName!
                                                  .length),
                                      child: Text(
                                        currentUserInfos
                                            .currentUserTransmitterTrips![index]
                                            .driverUserName![0]
                                            .toUpperCase(),
                                        style: const TextStyle(fontSize: 19),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(currentUserInfos
                                    .currentUserTransmitterTrips![index]
                                    .driverUserName!)
                              ],
                            ),
                            Text(
                              currentUserInfos
                                  .currentUserTransmitterTrips![index]
                                  .tripDate!,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        const Divider(thickness: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(currentUserInfos
                                    .currentUserTransmitterTrips![index]
                                    .departure!),
                                SizedBox(
                                  height: 60,
                                  width: 40,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: const VerticalDivider(
                                          color: Colors.grey,
                                          thickness: 2,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          for (int i = 0; i < 2; i++)
                                            Container(
                                              alignment: Alignment.center,
                                              height: 10.0,
                                              width: 10.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: bluePurpleColor),
                                            )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Text(currentUserInfos
                                    .currentUserTransmitterTrips![index]
                                    .destination!),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.monetization_on,
                                      size: 25,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                        "${currentUserInfos.currentUserTransmitterTrips![index].price} DA")
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const ImageIcon(
                                      Svg("assets/icons/multiple_users.svg"),
                                    ),
                                    Text(
                                        "${currentUserInfos.currentUserTransmitterTrips![index].allSeats}")
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.chair_alt,
                                      size: 25,
                                      color: Colors.teal,
                                    ),
                                    Text(
                                        "${currentUserInfos.currentUserTransmitterTrips![index].seatsLeft}")
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Builder(
                          builder: (context) {
                            if (currentUserInfos
                                    .currentUserTransmitterTrips![index]
                                    .condition !=
                                "") {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(thickness: 3),
                                  Text(
                                    "Condition : ${currentUserInfos.currentUserTransmitterTrips![index].condition}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        )
                      ],
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          }
        }));
  }
}
