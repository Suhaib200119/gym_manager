import 'package:flutter/material.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/feature/GlobalWidgets/changePasswordTrainer.dart';
import 'package:provider/provider.dart';

import '../../../providers/Auth_Provider.dart';
import 'ProfileWidgets/customListTile.dart';

class ProfileScreenTrainer extends StatelessWidget {
  const ProfileScreenTrainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth_Provider>(context);
    double avg = double.parse(authProvider.trainerData.avgRating==null?"0":authProvider.trainerData.avgRating.toString());
    double percentage = avg * 100 / 10;


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
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset("Assets/images/userImage.png"),
                CustomListTile(
                    title: "الأسم",
                    value: "${authProvider.trainerData.name}",
                    iconData: Icon(Icons.person),
                    function: () {}),
                CustomListTile(
                    title: "رقم الجوال",
                    value: "${authProvider.trainerData.phone}",
                    iconData: Icon(Icons.phone_android),
                    function: () {}),
                CustomListTile(
                    title: "البريد الإلكتروني",
                    value: "${authProvider.trainerData.email}",
                    iconData: Icon(Icons.email),
                    function: () {}),
                CustomListTile(
                    title: "التقييم العام",
                    value: "${percentage.toStringAsFixed(1) + '%'}",
                    iconData: Icon(Icons.star_border),
                    function: () {}),
                CustomListTile(
                      title: "تغيير كلمة المرور",
                      value: "",
                      iconData: Icon(Icons.edit),
                      function: () {
                        showDialog(context: context, builder: (context) {
                          return ChangePasswordTrainer();
                        },);
                      }),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
