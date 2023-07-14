import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym_manager/networks/dioHelper.dart';

class Trainer_Operations extends ChangeNotifier {
  bool circleProg = false;
  void changeCircleProg({required bool circleProg}) {
    this.circleProg = circleProg;
    notifyListeners();
  }

  Future<Response> getAllRating({
    required String token,
    required String trainerId,
  }) async {
    return await DioHelper.postMethod(
      apiName: "trainer/ratings",
      body: {
        "trainer_id": trainerId,
      },
      headers: {
        "authorization": "Bearer " + token,
      },
    );
  }

  Future<Response> getAllAttendance({
    required String token,
    required String trainerId,
  }) async {
    return await DioHelper.postMethod(
      apiName: "trainer/attendances/index",
      body: {
        "trainer_id": trainerId,
      },
      headers: {
        "authorization": "Bearer " + token,
      },
    );
  }

  Future<Response> attendance(
      {required String token, required String trainerId}) async {
    String date = DateTime.now().toLocal().toIso8601String().split('T')[0];
    print(date);
    return await DioHelper.postMethod(
        apiName: "trainer/attendances_store",
        body: {"date": date, "trainer_id": trainerId},
        headers: {"authorization": "Bearer " + token});
  }

  Future<Response> departure(
      {required String token, required String trainerId}) async {
    String date = DateTime.now().toLocal().toIso8601String().split('T')[0];
    print(date);
    return await DioHelper.postMethod(
      apiName: "trainer/departure",
      body: {
        "date": date,
        "trainer_id": trainerId,
      },
      headers: {
        "authorization": "Bearer " + token,
      },
    );
  }

  Future<Response> addComplaint(
      {required String token, required String message}) async {
    return await DioHelper.postMethod(
      apiName: "trainer/complaints/store",
      body: {
        "message": message,
      },
      headers: {
        "authorization": "Bearer " + token,
      },
    );
  }

  Future<Response> changePassword(
      {required String token,
      required String trainerId,
      required String oldPassword,
      required String newPassword,
      required String confirmNewPassword}) async {
    return await DioHelper.putMethod(apiName: "trainer/changePassword", data: {
      "old_password": oldPassword,
      "password": newPassword,
      "confirm_password": confirmNewPassword,
      "trainer_id": trainerId,
    }, headers: {
      "authorization": "Bearer " + token
    });
  }
}
