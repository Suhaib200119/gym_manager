import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/feature/GlobalWidgets/changePasswordSubscriber.dart';
import 'package:gym_manager/feature/GlobalWidgets/sharedButton.dart';
import 'package:gym_manager/feature/view/screens_subscriber/Profile_Screen/ProfileWidgets/dialogChangeTrainer.dart';
import 'package:gym_manager/feature/view/screens_subscriber/Profile_Screen/ProfileWidgets/dialogRating.dart';
import 'package:provider/provider.dart';

import '../../../GlobalWidgets/UpdatePhoneSubscriber.dart';
import '../../../providers/Auth_Provider.dart';
import '../../../providers/SubscriberOperations.dart';
import '../Offers_Products_Sauna_Orders_Screen/OrdersScreen/OrderScreen.dart';
import 'ProfileWidgets/customListTile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth_provider = Provider.of<Auth_Provider>(context);
    var subscriber_operations = Provider.of<SubscriberOperations>(context);

    return SingleChildScrollView(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("Assets/images/userImage.png"),
                  CustomListTile(
                      title: "الأسم",
                      value: "${auth_provider.subscriberData.name}",
                      iconData: Icon(Icons.person),
                      function: () {}),
                  CustomListTile(
                      title: "رقم الجوال",
                      value: "${auth_provider.subscriberData.phone}",
                      iconData: Icon(Icons.phone_android),
                      function: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return UpdatePhoneSubscriber();
                          },
                        );
                      }),
                  CustomListTile(
                      title: "نوع الإشتراك",
                      value:
                          "${auth_provider.subscriberData.subscription!.subscriptionType}",
                      iconData: Icon(Icons.link_sharp),
                      function: () {}),
                  CustomListTile(
                    title: "اسم المدرب",
                    value: "${auth_provider.subscriberData.trainerName}",
                    iconData: Icon(Icons.change_circle_outlined),
                    function: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "قم باختيار الإجراء الذي تريده",
                                  style: GoogleFonts.cairo(
                                    textStyle: TextStyle(
                                      color: ColorsManager.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SharedButton(
                                      btn_title: "تقييم المدرب",
                                      btn_fun: () {
                                        Navigator.pop(context);
                                        subscriber_operations
                                            .changePercentage(20.0);
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialoRating();
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Conditional.single(
                                      context: context,
                                      conditionBuilder: (context) {
                                        return auth_provider
                                                .trainersList.length>1;

                                      },
                                      widgetBuilder: (context) {
                                        return SharedButton(
                                            btn_title: "تغيير المدرب",
                                            btn_fun: () {
                                              Navigator.pop(context);
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return DialogChangeTrainer();
                                                },
                                              );
                                            });
                                      },
                                      fallbackBuilder: (context) {
                                        return SizedBox(
                                          height: 1,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  CustomListTile(
                    title: "تغيير كلمة المرور",
                    value: "***********",
                    iconData: Icon(Icons.edit),
                    function: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ChangePasswordSubscriber();
                        },
                      );
                    },
                  ),
                  CustomListTile(
                    title: "عرض طلباتي",
                    value: "عرض الطلبات التي قمت بها",
                    iconData: Icon(Icons.reorder),
                    function: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return OrderScreen();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
