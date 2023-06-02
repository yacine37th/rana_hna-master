import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../../Themes/colors.dart';
import '../../controller/add_trip_controller.dart';
import '../../main.dart';
import '../widgets.dart';

class AddTrip extends StatelessWidget {
  const AddTrip({super.key});

  @override
  Widget build(BuildContext context) {
    MainFunctions.checkInternetConnection();
    final AddTripController addTripController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: tealColor)),
                child: Form(
                    key: addTripController.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Please fill in the following form",
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter an information";
                            }

                            return null;
                          },
                          onChanged: (departure) {
                            addTripController.inputDeparture(departure);
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.trip_origin),
                            hintText: 'Departure',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter an information";
                            }

                            return null;
                          },
                          onChanged: (destination) {
                            addTripController.inputDestination(destination);
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.circle),
                            hintText: 'Destination',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter a price";
                            }
                            if (!RegExp(r"^([0-9])*$").hasMatch(val)) {
                              return "Please enter a valid price";
                            }
                            return null;
                          },
                          onChanged: (price) {
                            int intPrice = int.parse(price);
                            addTripController.inputPrice(intPrice);
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.monetization_on),
                            hintText: 'Price',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          onChanged: (condition) {
                            addTripController.inputCondition(condition);
                          },
                          maxLength: 50,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.edit_document),
                            hintText: 'Condition',
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                  color: lightBlueColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  transparentColor),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  tealColor),
                                        ),
                                        onPressed: () {
                                          Get.defaultDialog(
                                              title:
                                                  "Please choose available seats",
                                              content: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                        iconSize: 30,
                                                        onPressed: () {
                                                          addTripController
                                                              .minusAnAvailSeat();
                                                        },
                                                        icon: const Icon(
                                                          Icons.remove_circle,
                                                          color: tealColor,
                                                        ),
                                                      ),
                                                      GetBuilder<
                                                              AddTripController>(
                                                          builder: (context) {
                                                        return Text(
                                                          "${addTripController.avaliableSeats}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 25),
                                                        );
                                                      }),
                                                      const SizedBox(
                                                          height: 10),
                                                      IconButton(
                                                        iconSize: 30,
                                                        onPressed: () {
                                                          addTripController
                                                              .addAnAvailSeat();
                                                        },
                                                        icon: const Icon(
                                                            Icons.add_circle,
                                                            color: tealColor),
                                                      ),
                                                    ],
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: const Text("Ok"))
                                                ],
                                              ));
                                        },
                                        icon: const ImageIcon(
                                          Svg("assets/icons/multiple_users.svg"),
                                          color: tealColor,
                                        )),
                                    
                                    GetBuilder<AddTripController>(
                                        builder: (context) {
                                      return Text(addTripController
                                          .avaliableSeats
                                          .toString());
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: GetBuilder<AddTripController>(
                                  builder: (contexxt) {
                                return SizedBox(
                                  child: TextFormField(
                                      readOnly: true,
                                      validator: (value) {
                                        if (addTripController.tripDate ==
                                            null) {
                                          return "Please enter a date";
                                        }

                                        return null;
                                      },
                                      onTap: () {
                                        showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.utc(2024),
                                             
                                            builder: (context, child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  textButtonTheme:
                                                      const TextButtonThemeData(),
                                                ),
                                                child: child!,
                                              );
                                            }).then((value) {
                                          if (value != null) {
                                            addTripController.inputDate(value);
                                          }
                                        });
                                      },
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                          prefixIcon: const ImageIcon(Svg(
                                              "assets/icons/calendar_icon.svg")),
                                          hintStyle:const TextStyle(fontSize: 16),
                                          hintText:
                                              addTripController.tripDate ??
                                                  MainFunctions.dateFormat
                                                      .format(DateTime.now()))),
                                );
                              }),
                            ),
                          ],
                        ),

////
                        const SizedBox(height: 20),
                        TextButton(
                            onPressed: () {
                              if (addTripController.formKey.currentState!
                                  .validate()) {
                                addTripController.formKey.currentState!.save();
                                addTripController.addATrip();
                              }
                            },
                            child: const Text("Add a trip")),
                        const SizedBox(height: 20),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
