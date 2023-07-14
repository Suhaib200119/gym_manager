import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';

class ResponseDialog extends StatelessWidget {
  bool isTransparent;
  bool isSuccess;
  String message;

  ResponseDialog(
      {this.isTransparent = false, this.isSuccess = true, this.message = ""});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: isSuccess
                ? Image.asset("Assets/images/seccessfullyImage.png")
                : Image.asset("Assets/images/error.png"),
          ),
          Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(color: ColorsManager.blackColor)),
        ],
      ),
      backgroundColor:
          isTransparent ? Colors.transparent : ColorsManager.whiteColor,
    );
  }
}
