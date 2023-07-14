import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym_manager/feature/GlobalWidgets/ResponseDialog.dart';
import 'package:gym_manager/networks/dioHelper.dart';

class SubscriberOperations extends ChangeNotifier {
  bool circleProg = false;
  void changeCircleProg({required bool circleProg}) {
    this.circleProg = circleProg;
    notifyListeners();
  }

  int currentPageView = 0;
  void changeCurrentPageView(int newValue) {
    currentPageView = newValue;
    notifyListeners();
  }

  int rating = 0;

  void changeRating(int rating) {
    this.rating = rating;
    notifyListeners();
  }

  double percentage = 0;

  void changePercentage(double percentage) {
    this.percentage = percentage;
    notifyListeners();
  }

  Future<Response> trainerRating({
    required int trainer_id,
    required int subscriber_id,
    required int rating,
    required String token,
  }) async {
    return await DioHelper.postMethod(
      apiName: "subscribers/ratingStore",
      body: {
        "trainer_id": trainer_id,
        "subscriber_id": subscriber_id,
        "rating": rating,
      },
      headers: {
        "authorization": "Bearer " + token,
      },
    );
  }

  Future<Response> changePassword(
      {required String token,
      required String subscriber_id,
      required String oldPassword,
      required String newPassword,
      required String confirmNewPassword}) async {
    return await DioHelper.putMethod(
        apiName: "subscribers/changePassword",
        data: {
          "old_password": oldPassword,
          "password": newPassword,
          "confirm_password": confirmNewPassword,
          "subscriber_id": subscriber_id,
        },
        headers: {
          "authorization": "Bearer " + token
        });
  }

  int new_trainer_id = 1;

  void changeNewTrainer_ID(int new_trainer_id) {
    this.new_trainer_id = new_trainer_id;
    notifyListeners();
  }

  void changeTrainer(
      {required int subscriber_id,
      required String token,
      required BuildContext context}) {
    DioHelper.putMethod(apiName: "subscribers/changeTrainers", data: {
      "trainer_id": this.new_trainer_id,
      "subscriber_id": subscriber_id,
    }, headers: {
      "authorization": "Bearer " + token
    }).then((value) {
      changeCircleProg(circleProg: false);
      showDialog(
        context: context,
        builder: (context) {
          if (value.data["status"]) {
            return ResponseDialog(
              isTransparent: false,
              isSuccess: true,
              message: value.data["message"],
            );
          } else {
            return ResponseDialog(
              isTransparent: false,
              isSuccess: false,
              message: value.data["message"],
            );
          }
        },
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) {
          return ResponseDialog(
            isTransparent: false,
            isSuccess: false,
            message: error.toString(),
          );
        },
      );
    });
  }

  String? complaintType;
  void changeComplaintType({required String complaintType}) {
    this.complaintType = complaintType;
    notifyListeners();
  }

  Future<Response> addComplaint(
      {required String token,
      required String complaint,
      required int subscriber_id}) async {
    return await DioHelper.postMethod(
      apiName: "complaints/store",
      body: {
        "complaint": complaint,
        "subscriber_id": subscriber_id,
        "complaint_type": this.complaintType,
      },
      headers: {
        "authorization": "Bearer " + token,
      },
    );
  }

  Future<Response> getAllCategories() async {
    return await DioHelper.getMethod(
      apiName: "subscribers/categories",
      headers: {},
    );
  }

  Future<Response> getAllProducts({required String category_id}) async {
    return await DioHelper.postMethod(
      apiName: "subscribers/products",
      body: {"category_id": category_id},
    );
  }

  void addOrder(
      {required String subscriber_id,
      required String product_id,
      required String token,
      required BuildContext ctx}) {
    DioHelper.postMethod(apiName: "subscribers/order", body: {
      "subscriber_id": subscriber_id,
      "product_id": product_id
    }, headers: {
      "authorization": "Bearer " + token,
    }).then((value) {
      changeCircleProg(circleProg: false);
      showDialog(
        context: ctx,
        builder: (context) {
          if (value.data["status"]) {
            return ResponseDialog(
              isTransparent: false,
              isSuccess: true,
              message: value.data["message"],
            );
          } else {
            return ResponseDialog(
              isTransparent: false,
              isSuccess: false,
              message: value.data["message"],
            );
          }
        },
      );
    }).catchError((onError) {
      showDialog(
        context: ctx,
        builder: (context) {
          return ResponseDialog(
            isTransparent: false,
            isSuccess: false,
            message: onError.toString(),
          );
        },
      );
    });
  }

  Future<Response> getAllMyOrders(
      {required String subscriber_id, required String token}) async {
    return await DioHelper.postMethod(
      apiName: "subscribers/myOrders",
      body: {
        "subscriber_id": subscriber_id,
      },
      headers: {
        "authorization": "Bearer " + token,
      },
    );
  }

  void removeOrder(
      {required String subscriber_id,
      required String pivot_id,
      required String token,
      required BuildContext ctx}) {
    DioHelper.postMethod(apiName: "subscribers/removeOrder", body: {
      "subscriber_id": subscriber_id,
      "pivot_id": pivot_id
    }, headers: {
      "authorization": "Bearer " + token,
    }).then((value) {
      changeCircleProg(circleProg: false);
    }).catchError((onError) {
      showDialog(
        context: ctx,
        builder: (context) {
          return ResponseDialog(
            isTransparent: false,
            isSuccess: false,
            message: onError.toString(),
          );
        },
      );
    });
  }

  bool bookingVar = false;
  void changeBookingVar(bool bookingVar) {
    this.bookingVar = bookingVar;
    notifyListeners();
  }

  void reservationSauna(
      {required String subscriber_id,
      required String booking_date,
      required String start_time,
      required String token,
      required BuildContext ctx}) {
    DioHelper.postMethod(
      apiName: "subscribers/reservation",
      body: {
        "subscriber_id": subscriber_id,
        "booking_date": booking_date,
        "start_time": start_time,
      },
      headers: {
        "authorization": "Bearer " + token,
      },
    ).then((value) {
      changeBookingVar(false);
      showDialog(
        context: ctx,
        builder: (context) {
          return ResponseDialog(
            isTransparent: false,
            isSuccess: true,
            message: value.data["message"],
          );
        },
      );
    }).catchError((onError) {
      showDialog(
        context: ctx,
        builder: (context) {
          return ResponseDialog(
            isTransparent: false,
            isSuccess: false,
            message: "يوجد خطا حاول مرة أخرى",
          );
        },
      );
    });
  }

  Future<Response> getReservationSauna({
    required String subscriber_id,
    required String token,
  }) async {
    return await DioHelper.postMethod(
      apiName: "subscribers/showReservations",
      body: {
        "subscriber_id": subscriber_id,
      },
      headers: {
        "authorization": "Bearer " + token,
      },
    );
  }

  Future<Response> deleteReservationSauna({
    required String subscriber_id,
    required String reservation_id,
    required String token,
  }) async {
    return await DioHelper.postMethod(
      apiName: "subscribers/cancellationReservation",
      body: {
        "subscriber_id": subscriber_id,
        "reservation_id":reservation_id,
      },
      headers: {
        "authorization": "Bearer " + token,
      },
    );
  }


  void updatePhone({
    required String subscriber_id,
    required String new_phone,
    required String token,
    required BuildContext ctx,
  }) {
    DioHelper.putMethod(apiName: "subscribers/updatePhone", data: {
      "subscriber_id": subscriber_id,
      "new_phone": new_phone,
      "token": new_phone,
    }, headers: {
      "authorization": "Bearer " + token,
    }).then((value) {
      changeCircleProg(circleProg: false);
      if (value.data["status"]) {
        showDialog(
          context: ctx,
          builder: (context) {
            return ResponseDialog(
              isTransparent: false,
              isSuccess: true,
              message: value.data["message"].toString(),
            );
          },
        );
      } else {
        showDialog(
          context: ctx,
          builder: (context) {
            return ResponseDialog(
              isTransparent: false,
              isSuccess: false,
              message: value.data["message"].toString(),
            );
          },
        );
      }
    }).catchError((onError) {
      showDialog(
        context: ctx,
        builder: (context) {
          return ResponseDialog(
            isTransparent: false,
            isSuccess: false,
            message: "يوجد خطأ حاول مرة أخرى",
          );
        },
      );
    });
  }
}
