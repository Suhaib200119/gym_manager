import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';

class CustomListTile extends StatelessWidget {
  String title;
  String value;
  Widget iconData;
  Function function;

  CustomListTile(
      {required this.title, required this.value, required this.iconData,required this.function});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title,style: GoogleFonts.cairo(
            textStyle: TextStyle(
              color: ColorsManager.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          ),
          subtitle: Text(value,style: GoogleFonts.cairo(
            textStyle: TextStyle(
              color: ColorsManager.grayColor,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
          ),
          trailing: IconButton(icon: iconData,onPressed: (){function();}),
        ),
        Divider(
          height: 1,
          color: ColorsManager.blackColor,
        ),
      ],
    );
  }
}
