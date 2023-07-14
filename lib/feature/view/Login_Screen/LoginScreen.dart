// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/feature/providers/Auth_Provider.dart';
import 'package:gym_manager/feature/providers/Shared_Provider.dart';
import 'package:gym_manager/feature/view/Login_Screen/Widgets/passwordRecovery.dart';
import 'package:gym_manager/feature/view/screens_trainer/Layout_Screen_Trainer/LayoutScreenTrainer.dart';
import 'package:gym_manager/feature/view/screens_subscriber/Layout_Screen_Subscriber/LayoutScreenSubscriber.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../../core/colorsManager.dart';
import '../../GlobalWidgets/dialogInternet.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var keyForm = GlobalKey<FormState>();

  TextEditingController tec_phone_number = TextEditingController();

  TextEditingController tec_password = TextEditingController();
  bool passwordVisible=true;
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth_Provider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Assets/images/backgroundAppImage.png"),
                fit: BoxFit.cover),
          ),
          child: Container(
            color: ColorsManager.blackColor.withOpacity(0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "Assets/images/GymLogo.png",
                  width: 190,
                  height: 120,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "جولدين ",
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            color: ColorsManager.primaryColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      "جيم",
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            color: ColorsManager.whiteColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 64,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: tec_phone_number,
                          keyboardType: TextInputType.phone,
                          cursorColor: ColorsManager.primaryColor,
                          style: TextStyle(color: ColorsManager.whiteColor),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: ColorsManager.primaryColor,
                            ),
                            hintText: "رقم الجوال",
                            hintStyle: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                color: ColorsManager.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorsManager.primaryColor, width: 1),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorsManager.primaryColor, width: 2),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorsManager.redColor, width: 2),
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "يجب عليك إدخال رقم الجوال";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: tec_password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText:passwordVisible,
                          cursorColor: ColorsManager.primaryColor,
                          style: TextStyle(color: ColorsManager.whiteColor),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: ColorsManager.primaryColor,
                            ),
                            suffixIcon: IconButton(
                              color: ColorsManager.primaryColor,
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                               setState(() {
                                 passwordVisible =!passwordVisible;
                               });
                              },
                            ),
                            hintText: "كلمة المرور",
                            hintStyle: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                color: ColorsManager.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorsManager.primaryColor, width: 1),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorsManager.primaryColor, width: 2),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorsManager.redColor, width: 2),
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "يجب عليك إدخال كلمة المرور";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PasswordRecovery();
                        },
                      );
                    },
                    child: Text(
                      "نسيت كلمة المرور ؟",
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    )),
                Conditional.single(
                  context: context,
                  conditionBuilder: (BuildContext context) {
                    return authProvider.isClickLoginButton == false;
                  },
                  widgetBuilder: (BuildContext context) {
                    return ElevatedButton(
                      onPressed: () async {
                        final bool isConnected =
                            await InternetConnectionChecker().hasConnection;
                        if (isConnected) {
                          if (keyForm.currentState!.validate()) {
                            authProvider.changeClickLoginButton(newValue: true);
                            authProvider.loginUser(
                              ctx: context,
                              phoneNumber: tec_phone_number.text,
                              password: tec_password.text,
                            );
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70.0, vertical: 5.0),
                        primary: ColorsManager.primaryColor,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        "تسجيل الدخول",
                        style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.whiteColor),
                        ),
                      ),
                    );
                  },
                  fallbackBuilder: (BuildContext context) {
                    return LoadingAnimationWidget.hexagonDots(
                      color: ColorsManager.primaryColor,
                      size: 50,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
