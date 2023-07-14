import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/localization/AppLocale.dart';

class CardData extends StatelessWidget {
  int rateIndex;
  String date;
  double rate;

  CardData({ required this.rateIndex, required this.date , required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        color: ColorsManager.whiteColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        title:Text("رقم التقييم : ${rateIndex}",style: GoogleFonts.cairo(
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: ColorsManager.blackColor
          ),
        )) ,
        subtitle:Text("التاريخ : ${date}" ,style: GoogleFonts.cairo(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: ColorsManager.blackColor,
            fontSize: 14,
          ),
        )),
        trailing: RatingBarIndicator(
          rating: rate,
          direction: Axis.horizontal,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal:1),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: ColorsManager.primaryColor,
          ),
          itemSize: 22,
        ),

      ),
    );
  }
}
