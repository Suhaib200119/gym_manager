import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/feature/providers/Auth_Provider.dart';
import 'package:gym_manager/feature/view/Login_Screen/LoginScreen.dart';
import 'package:gym_manager/feature/view/Settings_Screen/SettingsWidgets/cardSettings.dart';
import 'package:gym_manager/feature/view/Settings_Screen/SettingsWidgets/dialogComplaint.dart';
import 'package:gym_manager/feature/view/Settings_Screen/SettingsWidgets/dialog_Trainer.dart';
import 'package:provider/provider.dart';
import '../../GlobalWidgets/sharedButton.dart';
import '../../providers/Shared_Provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var providerAuth_Provider = Provider.of<Auth_Provider>(context);
    var shared_Provider = Provider.of<Shared_Provider>(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("Assets/images/backgroundAppImage.png"),
            fit: BoxFit.cover),
      ),
      child: Container(
        color: ColorsManager.blackColor.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 70),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: ColorsManager.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset("Assets/images/settings.png"),
              cardSettings(
                  title: "لغة التطبيق",
                  icon: const Icon(Icons.language),
                  function: () {}),
              cardSettings(
                  title: providerAuth_Provider.typeUser == "Trainer"?"تواصل مع الإدارة":"تقديم شكوى",
                  icon: const Icon(Icons.comment_rounded),
                  function: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        if (providerAuth_Provider.typeUser == "Trainer") {
                          return DialogTrainer();
                        } else {
                          return DialogComplaint();
                        }
                      },
                    );
                  }),
              cardSettings(
                  title: "خروج",
                  icon: const Icon(Icons.logout),
                  function: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("تأكيد عملية الخروج من التطبيق",style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  color: ColorsManager.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SharedButton(
                                    btn_title: "خروج",
                                    btn_fun: () {
                                      shared_Provider.changeIndexBottomNavigationBar(2);
                                      shared_Provider.changeIndexBottomNavigationBar_Trainer(2);
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return LoginScreen();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  SharedButton(
                                    btn_title: "إلغاء",
                                    btn_fun: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
