import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/feature/GlobalWidgets/ResponseDialog.dart';
import 'package:gym_manager/feature/providers/Shared_Provider.dart';
import 'package:gym_manager/feature/view/screens_trainer/Attendance_absence_Screen_Trainer/Widgets/CardData_Attendance.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../../core/colorsManager.dart';
import '../../../providers/Auth_Provider.dart';
import '../../../providers/Trainer_Operations.dart';
import '../../../GlobalWidgets/dialogInternet.dart';

class Attendance_AbsenceScreen_Trainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth_Provider>(context);
    var trainerOperations = Provider.of<Trainer_Operations>(context);
    var shared_provider = Provider.of<Shared_Provider>(context);

    return Container(
      padding: EdgeInsetsDirectional.only(top: 100),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("Assets/images/backgroundAppImage.png"),
            fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Conditional.single(
                context: context,
                conditionBuilder: (context) {
                  return trainerOperations.circleProg == false;
                },
                widgetBuilder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      final bool isConnected =
                          await InternetConnectionChecker().hasConnection;
                      if (isConnected) {
                        trainerOperations.changeCircleProg(circleProg: true);
                        trainerOperations
                            .attendance(
                                token: authProvider.trainerToken,
                                trainerId:
                                    authProvider.trainerData.id.toString())
                            .then((value) {
                          trainerOperations.changeCircleProg(circleProg: false);
                          showDialog(
                            context: context,
                            builder: (context) {
                              if (value.data["status"]) {
                                return ResponseDialog(
                                  isSuccess: true,
                                  isTransparent: false,
                                  message: value.data["message"],
                                );
                              } else {
                                return ResponseDialog(
                                  isSuccess: false,
                                  isTransparent: false,
                                  message: value.data["message"],
                                );
                              }
                            },
                          );
                        });
                      } else {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return DialogInternet();
                            });
                      }
                    },
                    child: Text(
                      "تسجيل حضور",
                      style: GoogleFonts.cairo(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: ColorsManager.primaryColor, // Background color
                      onPrimary: ColorsManager
                          .blackColor, // Text Color (Foreground color)
                    ),
                  );
                },
                fallbackBuilder: (context) {
                  return LoadingAnimationWidget.hexagonDots(
                    color: ColorsManager.primaryColor,
                    size: 50,
                  );
                },
              ),
              Conditional.single(
                context: context,
                conditionBuilder: (context) {
                  return trainerOperations.circleProg == false;
                },
                widgetBuilder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      final bool isConnected =
                          await InternetConnectionChecker().hasConnection;
                      if (isConnected) {
                        trainerOperations.changeCircleProg(circleProg: true);
                        trainerOperations
                            .departure(
                                token: authProvider.trainerToken,
                                trainerId:
                                    authProvider.trainerData.id.toString())
                            .then((value) {
                              trainerOperations.changeCircleProg(circleProg: false);
                          showDialog(
                            context: context,
                            builder: (context) {
                              if (value.data["status"]) {
                                return ResponseDialog(
                                  isSuccess: true,
                                  isTransparent: false,
                                  message: value.data["message"],
                                );
                              } else {
                                return ResponseDialog(
                                  isSuccess: false,
                                  isTransparent: false,
                                  message: value.data["message"],
                                );
                              }
                            },
                          );
                        });
                      } else {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return DialogInternet();
                            });
                      }
                    },
                    child: Text(
                      "تسجيل إنصراف",
                      style: GoogleFonts.cairo(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: ColorsManager.primaryColor, // Background color
                      onPrimary: ColorsManager
                          .blackColor, // Text Color (Foreground color)
                    ),
                  );
                },
                fallbackBuilder: (context) {
                  return LoadingAnimationWidget.hexagonDots(
                    color: ColorsManager.primaryColor,
                    size: 50,
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: trainerOperations.getAllAttendance(
                  token: authProvider.trainerToken,
                  trainerId: authProvider.trainerData.id.toString()),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      color: ColorsManager.primaryColor,
                      size: 50,
                    ),
                  );
                } else if (snapshot.hasData) {
                  dynamic snapshotData = jsonDecode(snapshot.data.toString());
                  if (snapshotData["status"]) {
                    List<dynamic> attendances = snapshotData["attendances"];
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: attendances.length,
                      itemBuilder: (context, index) {
                        return CardData_Attendance(
                          day: shared_provider.getDayName(dateString: attendances[index]["date"]),
                          date: "${attendances[index]["date"]}",
                          order_status:
                              attendances[index]["order_status"] == null
                                  ? 0
                                  : 1,
                          attendance_time:
                              attendances[index]["order_status"] != null
                                  ? attendances[index]["attendance_time"]
                                  : "",
                          leave_time: attendances[index]["order_status"] != null
                              ? attendances[index]["leave_time"]
                              : "",
                          duration_time:
                              attendances[index]["order_status"] != null
                                  ? attendances[index]["duration_time"]
                                  : "",
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
                    ));
                  }
                } else {
                  return Center(
                    child: Text(
                      "Some Error",
                      style: TextStyle(color: Colors.orange, fontSize: 25),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
