import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:rana_hna/Themes/colors.dart';
import 'package:rana_hna/view/widgets.dart';

import '../../controller/something_controller.dart';
import '../../main.dart';

class SomethingSearchedTrips extends StatelessWidget {
  const SomethingSearchedTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final SomethingController somethingController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                  title: "Filter by : ",
                  content: Column(
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            somethingController.filterByPrice();
                            navigator?.pop();
                          },
                          icon: const Text("Price"),
                          label: const Icon(
                            Icons.monetization_on,
                            size: 25,
                            color: Colors.amber,
                          )),
                      const SizedBox(height: 10),
                      TextButton.icon(
                          onPressed: () {
                            somethingController.filterBySeatsLeft();
                            navigator?.pop();
                          },
                          icon: const Text("Seats left"),
                          label: const Icon(
                            Icons.chair_alt_rounded,
                            size: 25,
                            color: Colors.white,
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
      body: FutureBuilder(
        future: somethingController.searchTrip(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (somethingController.tripsList.isEmpty) {
              return const Center(
                child: Text("No available trips"),
              );
            } else {
              return GetBuilder<SomethingController>(builder: (context) {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  shrinkWrap: true,
                  itemCount: somethingController.tripsList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: "Do you want to take this trip ?",
                            content: Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      somethingController
                                          .takeTransmitter(index);
                                    },
                                    child: const Text("Confirm")),
                                const SizedBox(height: 10),
                                TextButton(
                                    onPressed: () {
                                      navigator!.pop();
                                    },
                                    child: const Text("Cancel")),
                              ],
                            ));
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: whiteColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0,
                                      2.0), // shadow direction: bottom right
                                )
                              ]),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: ClipOval(
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: MainFunctions
                                                .generatePresizedColor(
                                                    somethingController
                                                        .tripsList[index]
                                                        .driverUserName!
                                                        .length),
                                            child: Text(
                                              somethingController
                                                  .tripsList[index]
                                                  .driverUserName![0]
                                                  .toUpperCase(),
                                              style:
                                                  const TextStyle(fontSize: 19),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(somethingController
                                          .tripsList[index].driverUserName!)
                                    ],
                                  ),
                                  Text(
                                    somethingController
                                        .tripsList[index].tripDate!,
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              const Divider(thickness: 3),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(somethingController
                                          .tripsList[index].departure!),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                for (int i = 0; i < 2; i++)
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 10.0,
                                                    width: 10.0,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: bluePurpleColor),
                                                  )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(somethingController
                                          .tripsList[index].destination!),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              "${somethingController.tripsList[index].price} DA")
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
                                              "${somethingController.tripsList[index].allSeats}")
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
                                              "${somethingController.tripsList[index].seatsLeft}")
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Builder(
                                builder: (context) {
                                  if (somethingController
                                          .tripsList[index].condition !=
                                      "") {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(thickness: 3),
                                        Text(
                                          "Condition : ${somethingController.tripsList[index].condition}",
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
                          )),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                );
              });
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(
              child: Text("No available trips"),
            );
          }
        },
      ),
    );
  }
}
