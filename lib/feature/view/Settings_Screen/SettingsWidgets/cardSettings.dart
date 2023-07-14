import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';

class cardSettings extends StatelessWidget {
  String title;
  Widget icon;
  Function function;

  cardSettings(
      {required this.title, required this.icon, required this.function});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: GoogleFonts.cairo(
              textStyle: TextStyle(
                color: ColorsManager.grayColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          trailing: IconButton(
            icon: icon,
            onPressed: (() {
              function();
            }),
          ),
        ),
        Divider(
          height: 1,
          color: ColorsManager.blackColor,
        ),
      ],
    );
  }
}
