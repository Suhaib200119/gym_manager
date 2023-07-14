import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/colorsManager.dart';

class offerButton extends StatelessWidget {
late String buttonTitle;
late Function buttonFunction;
offerButton({required this.buttonTitle,required this.buttonFunction});
  @override
  Widget build(BuildContext context) {
    return Container(
            height: 50,
      width: MediaQuery.of(context).size.width-10,
      margin:const  EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: ColorsManager.whiteColor,
        borderRadius: BorderRadius.circular(4),
      ),

      child: MaterialButton(
        child: Text(
          "$buttonTitle",
          style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        onPressed: () {
          buttonFunction();
        },
      ),
    );
  }
}