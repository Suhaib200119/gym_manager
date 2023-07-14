import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/feature/providers/Shared_Provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/colorsManager.dart';
import '../../../models/Notifications.dart';
import 'dialogNotification.dart';

class cardNotification extends StatelessWidget {



  Notifications notification;
  cardNotification( {required this.notification});

  @override
  Widget build(BuildContext context) {
    var sharedProvider=Provider.of<Shared_Provider>(context);
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 5, bottom: 5),
      child: ListTile(
        leading: Icon(
          Icons.notifications,
          color: ColorsManager.primaryColor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${notification.title}",
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                  color: ColorsManager.whiteColor,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              "${sharedProvider.getDayName(dateString: notification.createdAt!.substring(0,10))}  ${notification.createdAt?.substring(0,10)} ",
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                  color: ColorsManager.whiteColor,
                  fontSize: 14,
                ),
              ),
            ),

          ],
        ),
        subtitle: Text(
          "${notification.message}",
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.cairo(
            textStyle: TextStyle(
              color: ColorsManager.whiteColor,
              fontSize: 16,
            ),
          ),
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return DialogNotificationData(
                  notification: notification,
                );
              });
        },
      ),
    );
  }
}