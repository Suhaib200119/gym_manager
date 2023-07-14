import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';

class SharedButton extends StatelessWidget {
  String btn_title;
  Function btn_fun;

  SharedButton({required this.btn_title, required this.btn_fun});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {btn_fun();},
        child: Text(btn_title,style: GoogleFonts.cairo(
          color: ColorsManager.whiteColor,
        ),),
        color: ColorsManager.primaryColor);
  }
}
