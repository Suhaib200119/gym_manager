import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';

class CustomTextDet extends StatelessWidget {
  String title;
  String data;

  CustomTextDet({required this.title,required this.data});


  @override
  Widget build(BuildContext context) {
    return Text(
      "${title} : ${data}",
      style: GoogleFonts.cairo(
        textStyle: TextStyle(
          fontSize: 16,
         color:ColorsManager.whiteColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
