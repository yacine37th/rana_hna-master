import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:rana_hna/main.dart';

import '../../Themes/colors.dart';
import '../../controller/something_controller.dart';
import '../widgets.dart';
import 'something_searched_trips.dart';
import 'transmitter_type.dart';

class SomethingSearchTrip extends StatelessWidget {
  const SomethingSearchTrip({super.key});

  @override
  Widget build(BuildContext context) {
    final SomethingController somethingController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundImage(),
          const Positioned(
            top: 20,
            child: BackIconButton(),
          ),
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
                    key: somethingController.formKey,
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
                            somethingController.inputDeparture(departure);
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.trip_origin),
                            hintText: 'Departure',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter an information";
                            }

                            return null;
                          },
                          onChanged: (destination) {
                            somethingController.inputDestination(destination);
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.circle),
                            hintText: 'Destination',
                          ),
                        ),
                        const SizedBox(height: 10),
                        GetBuilder<SomethingController>(builder: (contexxt) {
                          return TextFormField(
                              readOnly: true,
                              validator: (value) {
                                if (somethingController.tripDate == null) {
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
                                    helpText: "Select a date",
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          textButtonTheme:
                                              const TextButtonThemeData(),
                                        ),
                                        child: child!,
                                      );
                                    }).then((value) {
                                  if (value != null) {
                                    somethingController.inputDate(value);
                                  }
                                });
                              },
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                  prefixIcon: const ImageIcon(
                                      Svg("assets/icons/calendar_icon.svg")),
                                  hintText: somethingController.tripDate ??
                                      MainFunctions.dateFormat
                                          .format(DateTime.now())));
                        }),
                                                const SizedBox(height: 10),

                        TextButton.icon(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(tealColor),
                                backgroundColor:
                                    MaterialStateProperty.all(transparentColor),
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: tealColor))),
                            onPressed: () {
                              Get.to(() => const TransmitterType());
                            },
                            label: const Icon(Icons.navigate_next),
                            icon: GetBuilder<SomethingController>(
                                builder: (context) {
                              return Text(somethingController
                                      .choosedTransmitterType?.mainText ??
                                  "Transmitter type");
                            })),
                        const SizedBox(height: 15),
                        TextButton(
                            onPressed: () {
                              if (somethingController.formKey.currentState!
                                  .validate()) {
                                if (somethingController
                                        .choosedTransmitterType !=
                                    null) {
                                  somethingController.formKey.currentState!
                                      .save();
                                  Get.to(() => const SomethingSearchedTrips());
                                } else {
                                  MainFunctions.somethingWentWrongSnackBar(
                                      "Please choose a transmitter type");
                                }
                              }
                            },
                            child: const Text("Search for a trip")),
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
