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


class UpdatePhoneSubscriber extends StatelessWidget {
  var formKeyChangePass = new GlobalKey<FormState>();
  TextEditingController tec_newPhone = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth_Provider>(context);
    var subscriberOperations = Provider.of<SubscriberOperations>(context);

    return AlertDialog(
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          "تغيير رقم الجوال ",
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
                controller: tec_newPhone,
                keyboardType: TextInputType.phone,
                cursorColor: ColorsManager.blackColor,
                style: TextStyle(color: ColorsManager.blackColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  hintText: "رقم الجوال الجديد",
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
                    return "يجب عليك كتابة رقم الجوال الجديد قبل الإرسال";
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
                    if(tec_newPhone.text.toString()!=authProvider.subscriberData.phone){
                      subscriberOperations.changeCircleProg(circleProg: true);
                      subscriberOperations.updatePhone(
                          subscriber_id:
                          authProvider.subscriberData.id.toString(),
                          new_phone: tec_newPhone.text.toString(),
                          token: authProvider.subscriberToken,
                          ctx: context);
                    }else{
                      showDialog(context: context, builder: (context) {
                        return ResponseDialog(isTransparent: false,isSuccess: false,message: "قم باختيار رقم جوال مختلف عن رقم الجوال الحالي",);
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
