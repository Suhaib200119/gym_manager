import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/feature/GlobalWidgets/ResponseDialog.dart';
import 'package:gym_manager/feature/GlobalWidgets/dialogInternet.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/Auth_Provider.dart';
import '../../../providers/Trainer_Operations.dart';

class DialogTrainer extends StatelessWidget {
  var formKeyMessage= new GlobalKey<FormState>();
  TextEditingController tec_message = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth_Provider>(context);
    var trainerOperations = Provider.of<Trainer_Operations>(context);
    return AlertDialog(
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          "تواصل معنا",
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
      
        Form(
          key: formKeyMessage,
          child: TextFormField(
            controller: tec_message,
            keyboardType: TextInputType.text,
            cursorColor: ColorsManager.blackColor,
            style: TextStyle(color: ColorsManager.blackColor),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              hintText: "قم بكتابة الرسالة هنا",
              hintStyle: GoogleFonts.cairo(
                textStyle: TextStyle(
                  color: ColorsManager.blackColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "يجب عليك كتابة الرسالة قبل الإرسال";
              }
            },
          ),
        ),
        SizedBox(
          height: 8,
        ),
         Conditional.single(context: context, conditionBuilder: (context) {
           return trainerOperations.circleProg==false;
         }, widgetBuilder: (context) {
           return  MaterialButton(
             padding: EdgeInsets.zero,
             child: Container(
               width:150,
               height: 40,
               alignment: AlignmentDirectional.center,
               decoration: BoxDecoration(
                   color: ColorsManager.primaryColor
               ),
               child: Text(
                 "إرسال",
                 style: GoogleFonts.cairo(
                   textStyle: TextStyle(
                       fontSize:14,
                       color: ColorsManager.whiteColor
                   ),
                 ),
               ),
             ),
             onPressed: ()async {
               final bool isConnected =
               await InternetConnectionChecker().hasConnection;
               if (isConnected) {
                 if (formKeyMessage.currentState!.validate()) {
                   trainerOperations.changeCircleProg(circleProg: true);
                   trainerOperations.addComplaint(token: authProvider.trainerToken, message:tec_message.text).then((value){
                     trainerOperations.changeCircleProg(circleProg: false);
                     if(value.data["status"]){
                       Navigator.pop(context);
                       showDialog(
                         context: context,
                         builder: (context) {
                           return ResponseDialog(isTransparent: false,message: value.data["message"],isSuccess: value.data["status"],);
                         },
                       );
                     }else{
                       return ResponseDialog(isTransparent: false,message: value.data["message"],isSuccess: value.data["status"],);

                     }
                   });
                 }
               } else {
                 showDialog(
                     context: context,
                     builder: (ctx) {
                       return DialogInternet();
                     });
               }
             },
           );
         }, fallbackBuilder: (context) {
           return LoadingAnimationWidget.hexagonDots(
             color: ColorsManager.primaryColor,
             size: 50,
           );
         },),

      
      ]),
      backgroundColor: ColorsManager.whiteColor,
    );
  }
}
