import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';

class CustomText extends StatelessWidget {
  String title;
  dynamic value;
  CustomText({required this.title,required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,style: GoogleFonts.cairo(
          textStyle: TextStyle(
            fontSize: 16,
            color: ColorsManager.whiteColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        ),
        Text(value,style: GoogleFonts.cairo(
          textStyle: TextStyle(
            fontSize: 12,
            color: ColorsManager.whiteColor,
            fontWeight: FontWeight.w400,
          ),
        ),),
      ],
    );
  }
}
