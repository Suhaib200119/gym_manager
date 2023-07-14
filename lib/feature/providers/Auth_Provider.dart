import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gym_manager/feature/GlobalWidgets/ResponseDialog.dart';
import 'package:gym_manager/feature/models/SubscriberApi.dart';
import 'package:gym_manager/feature/models/TrainerApi.dart';
import 'package:gym_manager/networks/dioHelper.dart';

import '../models/TrainerDropMenu.dart';
import '../view/screens_trainer/Layout_Screen_Trainer/LayoutScreenTrainer.dart';
import '../view/screens_subscriber/Layout_Screen_Subscriber/LayoutScreenSubscriber.dart';

class Auth_Provider extends ChangeNotifier {
  bool isClickLoginButton = false;
  void changeClickLoginButton({required bool newValue}) {
    isClickLoginButton = newValue;
    notifyListeners();
  }

  String typeUser = "Trainer";
  changeTypeUser(String newValue) {
    typeUser = newValue;
    notifyListeners();
  }

  late TrainerApi trainerData;
  changeTrainerData(TrainerApi trainerData) {
    this.trainerData = trainerData;
    notifyListeners();
  }

   late String trainerToken;
  changeTrainerToken(String trainerToken) {
    this.trainerToken = trainerToken;
    notifyListeners();
  }

  late SubscriberApi subscriberData;
  changeSubscriberData(SubscriberApi subscriberData) {
    this.subscriberData = subscriberData;
    notifyListeners();
  }

   late String subscriberToken;
  changeSubscriberToken(String subscriberToken) {
    this.subscriberToken = subscriberToken;
    notifyListeners();
  }

  List<TrainerDropMenu> trainersList = [];
  Future<Response> getAllTrainers() async {
    return await DioHelper.getMethod(
        apiName: "subscribers/trainers", headers: {});
  }

  void loginUser({
    required BuildContext ctx,
    required String phoneNumber,
    required String password,
  }) {
    generateToken()
        .then((value) => {
              DioHelper.postMethod(apiName: "login", body: {
                "phone": phoneNumber,
                "password": password,
                "fcm_token": value.toString()
              }, headers: {
                "Accept": "application/json",
              }).then((response) {
                changeClickLoginButton(newValue: false);
                if (response.statusCode == 200) {
                  if (response.data["status"] == true &&
                      response.data["type"] == "trainer") {
                    changeTypeUser("Trainer");
                    changeTrainerData(
                        TrainerApi.fromJson(response.data["trainer"]));
                    changeTrainerToken(response.data["token"]);
                    Navigator.pushReplacement(ctx, MaterialPageRoute(
                      builder: (context) {
                        return LayoutScreen_Trainer();
                      },
                    ));
                  } else if (response.data["status"] == true &&
                      response.data["type"] == "subscriber") {
                    changeTypeUser("Subscriber");
                    changeSubscriberData(
                        SubscriberApi.fromJson(response.data["subscriber"]));
                    changeSubscriberToken(response.data["token"]);
                    trainersList.clear();
                    getAllTrainers().then((value) {
                      List trainers = value.data["trainers"] as List;
                      trainers.forEach((element) {
                        this
                            .trainersList
                            .add( TrainerDropMenu.fromJson(element));
                        // print("element : ===============> ${element}");
                      });

                    });

                    Navigator.pushReplacement(
                      ctx,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return LayoutScreen_Subscriber();
                        },
                      ),
                    );
                  } else if (response.data["status"] == false) {
                    showDialog(
                      context: ctx,
                      builder: (context) {
                        return ResponseDialog(
                          isTransparent: false,
                          isSuccess: false,
                          message: response.data["message"],
                        );
                      },
                    );
                  }
                } else if (response.statusCode == 400) {

                  showDialog(
                    context: ctx,
                    builder: (context) {
                      return ResponseDialog(
                        isTransparent: false,
                        isSuccess: false,
                        message: "يوجد مشكلة حاول مرة أخرى لاحقا",
                      );
                    },
                  );
                }
              })
            })
        .catchError((onError) => {print(onError.toString())});
  }

  // generate token function
  Future<String?> generateToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    print("token : ${token}");
    return token;
  }

}
