import 'package:flutter/material.dart';

class DialogInternet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: ColorsManager.primaryColor,
      title: Column(
        children: [
          Image.asset("Assets/images/wifi.jpg",height: 70,),
          SizedBox(height: 5,),
          Text("check the internet",style: TextStyle(/*color: ColorsManager.whiteColor*/),)
        ],

      ),
    );
  }
}
