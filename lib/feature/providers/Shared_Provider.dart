import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../networks/dioHelper.dart';
import 'package:flutter/material.dart';

class Shared_Provider extends ChangeNotifier {
  bool isClickResetPasswordButton = false;
  void changeClickLoginButton({required bool newValue}) {
    isClickResetPasswordButton = newValue;
    notifyListeners();
  }

  Future<Response> getAllNotifications(
      {required String token, required String apiName}) async {
    return await DioHelper.getMethod(
      apiName: apiName,
      headers: {
        "authorization": "Bearer " + token,
      },
    );
  }

  Future<Response> forgetPassword({
    required String email,
  }) async {
    return await DioHelper.postMethod(
      apiName: "subscriber/forget-password",
      body: {
        "email": email,
      },
    );
  }

  // genral logic
  String defaultLang = "ar";
  changeDefaultLang(String newLang) {
    defaultLang = newLang;
    notifyListeners();
  }

// subscriber logic

  List<dynamic> offers = [];
  void getAllOffers() {
    offers.clear();
    DioHelper.getMethod(apiName: "subscribers/showOffers", headers: {})
        .then((value) {
      this.offers = value.data["offers"] as List;
      notifyListeners();
    }).catchError((onError) {});
  }

  int indexBottomNavigationBar_Subscriber = 2;
  void changeIndexBottomNavigationBar(int newIndex) {
    indexBottomNavigationBar_Subscriber = newIndex;
    if (indexBottomNavigationBar_Subscriber == 1) {
      this.getAllOffers();
    }
    notifyListeners();
  }

  // Trainer logic
  int indexBottomNavigationBar_Trainer = 2;
  void changeIndexBottomNavigationBar_Trainer(int newIndex) {
    indexBottomNavigationBar_Trainer = newIndex;
    notifyListeners();
  }



  String getDayName({required String dateString}){
    String dayEng=DateFormat("EEEE").format(DateTime.parse(dateString));
    switch (dayEng){
      case "Saturday":
        return "السبت";
      case "Sunday":
        return "الأحد";
      case "Monday":
        return "الأثنين";
      case "Tuesday":
        return "الثلاثاء";
      case "Wednesday":
        return "الاربعاء";
      case "Thursday":
        return "الخميس";
      case "Friday":
        return "الجمعة";
    }
    return dayEng;
  }

}
