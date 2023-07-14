import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/feature/GlobalWidgets/ResponseDialog.dart';
import 'package:gym_manager/feature/GlobalWidgets/dialogInternet.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/Shared_Provider.dart';

class PasswordRecovery extends StatelessWidget {
  var keyForm = GlobalKey<FormState>();
  TextEditingController tec_phone_email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var shared_Provider = Provider.of<Shared_Provider>(context);

    return AlertDialog(
      title: Form(
        key: keyForm,
        child: Column(
          children: [
            Text(
              "قم بكتابة البريد الإلكتروني لإسترجاع كلمة المرور",
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                  color: ColorsManager.blackColor,
                  fontSize: 12,
                ),
              ),
            ),
            TextFormField(
              controller: tec_phone_email,
              keyboardType: TextInputType.emailAddress,
              cursorColor: ColorsManager.primaryColor,
              style: TextStyle(color: ColorsManager.primaryColor),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                prefixIcon: Icon(
                  Icons.email,
                  color: ColorsManager.primaryColor,
                ),
                hintText: "البريد الإلكتروني",
                hintStyle: GoogleFonts.cairo(
                  textStyle: TextStyle(
                    color: ColorsManager.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                focusColor: ColorsManager.primaryColor,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "يجب عليك إدخال البريد الإلكتروني ";
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Conditional.single(context: context, conditionBuilder: (context) {
              return shared_Provider.isClickResetPasswordButton==false;
            }, widgetBuilder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  final bool isConnected =
                  await InternetConnectionChecker().hasConnection;
                  if (isConnected) {
                    if (keyForm.currentState!.validate()) {
                      String email = tec_phone_email.text;
                      shared_Provider.forgetPassword(email: email).then((value) {
                        print(value.data);
                        showDialog(
                          context: context,
                          builder: (context) {
                            if (value.data["status"] == true) {
                              return ResponseDialog(isTransparent: false,isSuccess: true,message: value.data["message"],);
                            }else{
                              return ResponseDialog(isTransparent: false,isSuccess: false,message: value.data["message"],);
                            }
                          },
                        );
                      }).catchError((onError) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ResponseDialog(
                              isTransparent: false,
                              isSuccess: false,
                              message: onError.message,
                            );
                          },
                        );
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
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 70.0, vertical: 5.0),
                  primary: ColorsManager.primaryColor,
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  "إسترجاع كملة المرور",
                  style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.whiteColor),
                  ),
                ),
              );
            }, fallbackBuilder: (context) {
              return LoadingAnimationWidget.hexagonDots(
                color: ColorsManager.primaryColor,
                size: 50,
              );
            },),

          ],
        ),
      ),
    );
  }
}
