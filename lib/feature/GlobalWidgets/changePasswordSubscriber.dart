import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/feature/GlobalWidgets/ResponseDialog.dart';
import 'package:gym_manager/feature/GlobalWidgets/sharedButton.dart';
import 'package:gym_manager/feature/providers/SubscriberOperations.dart';
import 'package:gym_manager/feature/GlobalWidgets/dialogInternet.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../providers/Auth_Provider.dart';
import '../providers/Trainer_Operations.dart';

class ChangePasswordSubscriber extends StatelessWidget {
  var formKeyChangePass = new GlobalKey<FormState>();
  TextEditingController tec_oldPass = new TextEditingController();
  TextEditingController tec_newPass_1 = new TextEditingController();
  TextEditingController tec_newPass_2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth_Provider>(context);
    var subscriberOperations = Provider.of<SubscriberOperations>(context);

    return AlertDialog(
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          "تغيير كلمة المرور",
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        SizedBox(
          height: 16,
        ),
        Form(
          key: formKeyChangePass,
          child: Column(
            children: [
              TextFormField(
                controller: tec_oldPass,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: ColorsManager.blackColor,
                style: TextStyle(color: ColorsManager.blackColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  hintText: "كلمة المرور القديمة",
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
                    return "يجب عليك كتابة كلمة المرور القديمة قبل الإرسال";
                  }
                },
              ),
              TextFormField(
                controller: tec_newPass_1,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: ColorsManager.blackColor,
                style: TextStyle(color: ColorsManager.blackColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  hintText: "كلمة المرور الجديدة",
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
                    return "يجب عليك كتابة كلمة المرور الجديدة قبل الإرسال";
                  }
                },
              ),
              TextFormField(
                controller: tec_newPass_2,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: ColorsManager.blackColor,
                style: TextStyle(color: ColorsManager.blackColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  hintText: " تأكيد كلمة المرور الجديدة",
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
                    return "يجب عليك كتابة تأكيد كلمة المرور الجديدة قبل الإرسال";
                  }
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) {
            return subscriberOperations.circleProg == false;
          },
          widgetBuilder: (BuildContext context) {
            return SharedButton(
              btn_title: "تغيير",
              btn_fun: () async {
                final bool isConnected =
                await InternetConnectionChecker().hasConnection;
                if (isConnected) {
                  if (formKeyChangePass.currentState!.validate()) {
                    subscriberOperations.changeCircleProg(circleProg: true);
                    if (tec_newPass_1.text.toString()==tec_newPass_2.text.toString()) {
                      subscriberOperations.changePassword(
                          token: authProvider.subscriberToken.toString(),
                          subscriber_id: authProvider.subscriberData.id.toString(),
                          oldPassword: tec_oldPass.text.toString(),
                          newPassword: tec_newPass_1.text.toString(),
                          confirmNewPassword: tec_newPass_2.text.toString()).then((value){
                        subscriberOperations.changeCircleProg(circleProg: false);
                        showDialog(context: context, builder: (ctx) {
                          if(value.data["status"]){
                            return ResponseDialog(isSuccess: true,isTransparent: false,message: value.data["message"],);
                          }else{
                            return ResponseDialog(isSuccess: false,isTransparent: false,message: value.data["message"],);
                          }
                        },);
                      }).catchError((onError){
                        return ResponseDialog(isSuccess: false,isTransparent: false,message: onError);

                      });
                    }else if(tec_newPass_1.text.toString()!=tec_newPass_2.text.toString()){
                      subscriberOperations.changeCircleProg(circleProg: false);
                      showDialog(context: context, builder: (context) {
                        return ResponseDialog(isSuccess: false,isTransparent: false,message: "كلمة المرور وتأكيد كلمة المرور غير متطابقتين");
                      },);
                    }
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return DialogInternet();
                    },
                  );
                }
              },
            );
          },
          fallbackBuilder: (BuildContext context) {
            return LoadingAnimationWidget.hexagonDots(
              color: ColorsManager.primaryColor,
              size: 50,
            );
          },
        ),

      ]),
      backgroundColor: ColorsManager.whiteColor,
    );
  }
}
