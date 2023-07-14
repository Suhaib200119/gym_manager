import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gym_manager/feature/models/Notifications.dart';

import '../../../../core/colorsManager.dart';

class DialogNotificationData extends StatelessWidget {
  Notifications notification;

  DialogNotificationData({required this.notification});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${notification.title}",
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: ColorsManager.blackColor,
                      fontSize: 14,
                  ),
                ),
              ),
              Text(
                "${notification.createdAt?.substring(0,10)}",
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: ColorsManager.blackColor,
                      fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Divider(
            color: ColorsManager.primaryColor,
            height: 2,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "${notification.message}",
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            child: Container(
              width: 200,
              height: 40,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(color: ColorsManager.primaryColor),
              child: Text(
                "إغلاق",
                style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: ColorsManager.whiteColor),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
