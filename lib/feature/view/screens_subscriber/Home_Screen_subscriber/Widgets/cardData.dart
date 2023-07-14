import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/localization/AppLocale.dart';

class CardData extends StatelessWidget {
  String title;
  String value;
  String imageName;

  CardData({required this.title, required this.value, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 75,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        color: ColorsManager.grayColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(width: 24,),
                Text(
                  "$title",
                  style: GoogleFonts.cairo(textStyle: TextStyle(
                      fontSize: 15, color: ColorsManager.primaryColor),
                  ),
                ),
                Text(
                  " : ",
                  style: TextStyle(
                      fontSize: 14, color: ColorsManager.primaryColor),
                ),
                Text(
                  "$value",
                  style: TextStyle(
                      fontSize: 14, color: ColorsManager.primaryColor),
                ),
              ],
            ),
          ),
          Image.asset("Assets/images/$imageName"),
          SizedBox(width: 24,),
        ],
      ),
    );
  }
}
