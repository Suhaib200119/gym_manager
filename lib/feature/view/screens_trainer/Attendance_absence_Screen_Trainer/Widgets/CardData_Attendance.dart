import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';

class CardData_Attendance extends StatelessWidget {
  String day;
  String date;
  int order_status;
  String? attendance_time;
  String? leave_time;
  String? duration_time;

  CardData_Attendance({required this.day, required this.date, required this.order_status,required this.attendance_time,required this.leave_time,required this.duration_time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        color: ColorsManager.whiteColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " اليوم : ${day}",
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.blackColor),
              ),
            ),
            Text(
              "التاريخ : ${date}",
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.blackColor),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'الحالة : ',
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.blackColor,
                    fontSize: 17,
                  ),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${order_status==1?"حاضر":"قيد المراجعة"}',
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: order_status==0?ColorsManager.redColor:ColorsManager.greenColor,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            order_status==1?RichText(
              text: TextSpan(
                text: 'وقت الحضور : ',
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.blackColor,
                    fontSize: 17,
                  ),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: attendance_time,
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.blackColor,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ):SizedBox(),
            order_status==1?RichText(
              text: TextSpan(
                text: 'وقت الإنصراف : ',
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.blackColor,
                    fontSize: 17,
                  ),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: leave_time,
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                     color: ColorsManager.blackColor,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ):SizedBox(),
            order_status==1?RichText(
              text: TextSpan(
                text: 'عدد ساعات الدوام : ',
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.blackColor,
                    fontSize: 17,
                  ),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: duration_time,
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.blackColor,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ):SizedBox(),
          ],
        ),
        trailing: Image.asset("Assets/images/calendar.png"),
      ),
    );
  }
}
