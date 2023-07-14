import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/feature/GlobalWidgets/ResponseDialog.dart';
import 'package:gym_manager/feature/GlobalWidgets/dialogInternet.dart';
import 'package:gym_manager/feature/providers/Auth_Provider.dart';
import 'package:gym_manager/feature/providers/Shared_Provider.dart';
import 'package:gym_manager/feature/providers/SubscriberOperations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/colorsManager.dart';
import '../../../../models/offersApi.dart';
import 'OffersWidgets/cardOffers.dart';
import 'OffersWidgets/offersButton.dart';
import '../ProductsScreens/ProductScreen.dart';

class OffersScreen extends StatelessWidget {
  PageController _pageController = PageController(viewportFraction: 0.8);

  OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var subscriber_operations = Provider.of<SubscriberOperations>(context);
    var shared_Provider = Provider.of<Shared_Provider>(context);
    var auth_provider = Provider.of<Auth_Provider>(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("Assets/images/backgroundAppImage.png"),
            fit: BoxFit.cover),
      ),
      child: Container(
        color: ColorsManager.blackColor.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 100),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Conditional.single(
                context: context,
                conditionBuilder: (context) {
                  if (shared_Provider.offers.length > 0) {
                    return true;
                  } else {
                    return false;
                  }
                },
                widgetBuilder: (context) {
                  return SizedBox(
                    height: 270,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      padEnds: false,
                      itemCount: shared_Provider.offers.length,
                      pageSnapping: true,
                      controller: _pageController,
                      onPageChanged: (index) {
                        subscriber_operations.changeCurrentPageView(index);
                      },
                      itemBuilder: (context, index) {
                        OfferApi offer = new OfferApi.fromJson(
                            shared_Provider.offers[index]);
                        return CardOffers(offersApi: offer);
                      },
                    ),
                  );
                },
                fallbackBuilder: (context) {
                  return Center(
                      child: Text(
                    "لا يوجد عروض لعرضها في الوقت الحالي",
                    style: GoogleFonts.cairo(
                      color: ColorsManager.primaryColor,
                    ),
                  ));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: shared_Provider.offers.length,
                effect: ScrollingDotsEffect(
                  activeStrokeWidth: 2.5,
                  activeDotScale: 1.2,
                  maxVisibleDots: 5,
                  spacing: 4,
                  radius: 8,
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: ColorsManager.grayColor,
                  activeDotColor: ColorsManager.primaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Conditional.single(
                context: context,
                conditionBuilder: (context) {
                  return subscriber_operations.bookingVar == false;
                },
                widgetBuilder: (context) {
                  return offerButton(
                    buttonTitle: "حجز الساونا",
                    buttonFunction: () async {
                      final bool isConnected =
                          await InternetConnectionChecker().hasConnection;
                      if (isConnected) {
                        DateTime nextMonth = DateTime(
                            DateTime.now().year, DateTime.now().month + 1);
                        showDatePicker(
                                helpText: "الساونا",
                                context: context,
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: ColorsManager
                                            .primaryColor, // bar color
                                        onPrimary: ColorsManager
                                            .blackColor, // text bar color
                                        onSurface: ColorsManager
                                            .blackColor, // text body color
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: ColorsManager
                                              .primaryColor, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: nextMonth)
                            .then((dateTimeValue) {
                          if (dateTimeValue != null) {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((time) {
                              subscriber_operations.changeBookingVar(true);
                              String hour;
                              if (time!.hour > 12) {
                                hour = (time.hour - 12).toString();
                              } else {
                                hour = time.hour.toString();
                              }
                              String minute = time.minute.toString();
                              subscriber_operations.reservationSauna(
                                  subscriber_id: auth_provider.subscriberData.id
                                      .toString(),
                                  booking_date:
                                      dateTimeValue.toString().substring(0, 10),
                                  start_time: "${hour}:${minute}:00",
                                  token: auth_provider.subscriberToken,
                                  ctx: context);
                            }).catchError((onError) {
                              subscriber_operations.changeBookingVar(false);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ResponseDialog(
                                    isTransparent: false,
                                    isSuccess: false,
                                    message: "تم إلغاء العملية بنجاح",
                                  );
                                },
                              );
                            });
                          }
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogInternet();
                          },
                        );
                      }
                    },
                  );
                },
                fallbackBuilder: (context) {
                  return Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      color: ColorsManager.primaryColor,
                      size: 50,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 4,
              ),
              offerButton(
                buttonTitle: "عرض تفاصيل حجز الساونا",
                buttonFunction: () async {
                  final bool isConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (isConnected) {
                    subscriber_operations
                        .getReservationSauna(
                            subscriber_id:
                                auth_provider.subscriberData.id.toString(),
                            token: auth_provider.subscriberToken)
                        .then((value) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          if (value.data["status"]) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image(
                                      image: AssetImage(
                                          "Assets/images/sauna.jpeg")),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SaunaTextCard(
                                          data:
                                              "اليوم : ${shared_Provider.getDayName(dateString: value.data["saunaReservations"]["booking_date"])}"),
                                      SaunaTextCard(
                                          data:
                                              "التاريخ : ${value.data["saunaReservations"]["booking_date"]}"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SaunaTextCard(
                                          data:
                                              "بداية الحجز : ${value.data["saunaReservations"]["start_time"].toString().substring(0, 5)}"),
                                      SaunaTextCard(
                                          data:
                                              "نهاية الحجز : ${value.data["saunaReservations"]["end_time"].toString().substring(0, 5)}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  FloatingActionButton(
                                    onPressed: () async {
                                      final bool isConnected =
                                          await InternetConnectionChecker()
                                              .hasConnection;
                                      if (isConnected) {
                                        subscriber_operations
                                            .deleteReservationSauna(
                                                subscriber_id: auth_provider
                                                    .subscriberData.id
                                                    .toString(),
                                                reservation_id: value
                                                    .data["saunaReservations"]
                                                        ["id"]
                                                    .toString(),
                                                token: auth_provider
                                                    .subscriberToken)
                                            .then((value) {
                                              Navigator.pop(context);
                                          if (value.data["status"]) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ResponseDialog(
                                                  isSuccess: true,
                                                  message:
                                                      value.data["message"],
                                                );
                                              },
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ResponseDialog(
                                                  isSuccess: false,
                                                  message:
                                                  value.data["message"],
                                                );
                                              },
                                            );
                                          }
                                        });
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialogInternet();
                                          },
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: ColorsManager.whiteColor,
                                      size: 32,
                                    ),
                                    backgroundColor: ColorsManager.primaryColor,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return AlertDialog(
                              content: Text(
                                value.data["message"],
                                style: GoogleFonts.cairo(
                                  color: ColorsManager.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        },
                      );
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogInternet();
                      },
                    );
                  }
                },
              ),
              Text(
                "الفئات التي يتم بيعها في النادي",
                style: GoogleFonts.cairo(
                  color: ColorsManager.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: FutureBuilder(
                  future: subscriber_operations.getAllCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.hexagonDots(
                          color: ColorsManager.primaryColor,
                          size: 50,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      dynamic snapshotData =
                          jsonDecode(snapshot.data.toString());
                      if (snapshotData["status"]) {
                        List<dynamic> categories = snapshotData["categories"];
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return offerButton(
                              buttonTitle: "${categories[index]["name"]}",
                              buttonFunction: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProductScreen(
                                          category_id: categories[index]["id"]
                                              .toString(),
                                        category_name: categories[index]["name"]
                                            .toString(),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text(
                            "${snapshotData["message"]}",
                            style: GoogleFonts.cairo(
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: Text(
                          "حدثت مشكلة , ربما بسبب انقطاع الإتصال بالانترنت",
                          style: GoogleFonts.cairo(
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text SaunaTextCard({required String data}) {
    return Text(
      data,
      style: GoogleFonts.cairo(
        color: ColorsManager.grayColor,
        fontSize: 13,
      ),
      textAlign: TextAlign.center,
    );
  }
}
