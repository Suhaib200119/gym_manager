import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/feature/models/Notifications.dart';
import 'package:gym_manager/feature/providers/Auth_Provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/Shared_Provider.dart';
import 'Widgets/cardNotification.dart';

class NotificationScreen extends StatelessWidget {
  // List<NotificationsApi> notifications = [
  //    NotificationsApi(
  //       notificationDate: "الخميس 26/2/2023",
  //       notificationTime: "12:00PM",
  //       notificationText:
  //     "أخبار مثيرة على عكس المعتقدات الشائعة ، فإن ايبسون ليس مجرد نص عشوائي"),
  //    NotificationsApi(
  //       notificationDate: "الخميس 26/3/2023",
  //       notificationTime: "10:00PM",
  //       notificationText:
  //           "لدينا أخبار مثيرة خلافا للاعتقاد السائد فأن ايبسون ليس مجرد نص عشوائي ، بل له جذور في قطعة من الأدب اللاتيني الكلاسيكي من 45 قبل الميلاد مما يجعلها أكثر من 2000 سنة. ريتشارد مكلينتوك"),
  //  NotificationsApi(
  //       notificationDate: "الخميس 26/2/2023",
  //       notificationTime: "12:00PM",
  //       notificationText:
  //     "أخبار مثيرة على عكس المعتقدات الشائعة ، فإن ايبسون ليس مجرد نص عشوائي"),
  //    NotificationsApi(
  //       notificationDate: "الخميس 26/3/2023",
  //       notificationTime: "10:00PM",
  //       notificationText:
  //           "لدينا أخبار مثيرة خلافا للاعتقاد السائد فأن ايبسون ليس مجرد نص عشوائي ، بل له جذور في قطعة من الأدب اللاتيني الكلاسيكي من 45 قبل الميلاد مما يجعلها أكثر من 2000 سنة. ريتشارد مكلينتوك"),
  //  NotificationsApi(
  //       notificationDate: "الخميس 26/2/2023",
  //       notificationTime: "12:00PM",
  //       notificationText:
  //     "أخبار مثيرة على عكس المعتقدات الشائعة ، فإن ايبسون ليس مجرد نص عشوائي"),
  //    NotificationsApi(
  //       notificationDate: "الخميس 26/3/2023",
  //       notificationTime: "10:00PM",
  //       notificationText:
  //           "لدينا أخبار مثيرة خلافا للاعتقاد السائد فأن ايبسون ليس مجرد نص عشوائي ، بل له جذور في قطعة من الأدب اللاتيني الكلاسيكي من 45 قبل الميلاد مما يجعلها أكثر من 2000 سنة. ريتشارد مكلينتوك"),
  //  NotificationsApi(
  //       notificationDate: "الخميس 26/2/2023",
  //       notificationTime: "12:00PM",
  //       notificationText:
  //     "أخبار مثيرة على عكس المعتقدات الشائعة ، فإن ايبسون ليس مجرد نص عشوائي"),
  //    NotificationsApi(
  //       notificationDate: "الخميس 26/3/2023",
  //       notificationTime: "10:00PM",
  //       notificationText:
  //           "لدينا أخبار مثيرة خلافا للاعتقاد السائد فأن ايبسون ليس مجرد نص عشوائي ، بل له جذور في قطعة من الأدب اللاتيني الكلاسيكي من 45 قبل الميلاد مما يجعلها أكثر من 2000 سنة. ريتشارد مكلينتوك"),
  //  NotificationsApi(
  //       notificationDate: "الخميس 26/2/2023",
  //       notificationTime: "12:00PM",
  //       notificationText:
  //     "أخبار مثيرة على عكس المعتقدات الشائعة ، فإن ايبسون ليس مجرد نص عشوائي"),
  //    NotificationsApi(
  //       notificationDate: "الخميس 26/3/2023",
  //       notificationTime: "10:00PM",
  //       notificationText:
  //           "لدينا أخبار مثيرة خلافا للاعتقاد السائد فأن ايبسون ليس مجرد نص عشوائي ، بل له جذور في قطعة من الأدب اللاتيني الكلاسيكي من 45 قبل الميلاد مما يجعلها أكثر من 2000 سنة. ريتشارد مكلينتوك"),
  //
  // ];
  @override
  Widget build(BuildContext context) {
    var shared_Provider = Provider.of<Shared_Provider>(context);
    var auth_Provider = Provider.of<Auth_Provider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("Assets/images/backgroundAppImage.png"),
            fit: BoxFit.cover),
      ),
      child: Container(
        color: ColorsManager.blackColor.withOpacity(0.8),
        child: FutureBuilder(
          future: shared_Provider.getAllNotifications(
            token: auth_Provider.typeUser == "Trainer"
                ? auth_Provider.trainerToken
                : auth_Provider.subscriberToken.toString(),
            apiName: auth_Provider.typeUser == "Trainer"
                ? "trainer/notificatios"
                : "subscribers/showNotification",
          ),
          builder: (context, snapshot) {
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
                List<dynamic> notifications = snapshotData["notifications"];
                return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: notifications.length,
                  itemBuilder: (ctx, index) {
                    Notifications notification =
                        new Notifications.fromJson(notifications[index]);
                    return cardNotification(
                      notification: notification,
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return Divider(
                      color: ColorsManager.primaryColor,
                      height: 2,
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
    );
  }
}
