import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/feature/GlobalWidgets/sharedButton.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:gym_manager/feature/models/TrainerDropMenu.dart';
import 'package:gym_manager/feature/providers/Auth_Provider.dart';
import 'package:gym_manager/feature/providers/SubscriberOperations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../core/colorsManager.dart';
import '../../../../GlobalWidgets/dialogInternet.dart';

class DialogChangeTrainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth_Provider = Provider.of<Auth_Provider>(context);
    var subscriber_operations = Provider.of<SubscriberOperations>(context);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text(
                  'قم بإختيار المدرب الجديد',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items:auth_Provider.trainersList.map(
                      (TrainerDropMenu item) {
                    return DropdownMenuItem<int>(
                      value: item.id,
                      child: Text(
                        "${item.name.toString()}",
                        style:  GoogleFonts.cairo(
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ).toList(),
                value: subscriber_operations.new_trainer_id,
                onChanged: (value) {
                  subscriber_operations.changeNewTrainer_ID(value!);
                },
                buttonStyleData: const ButtonStyleData(
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
          Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) {
              return subscriber_operations.circleProg == false;
            },
            widgetBuilder: (BuildContext context) {
              return SharedButton(btn_title: "تغيير", btn_fun: () async{
                final bool isConnected =
                await InternetConnectionChecker().hasConnection;
                if(isConnected){
                  subscriber_operations.changeCircleProg(circleProg: true);
                  subscriber_operations.changeTrainer( subscriber_id: auth_Provider.subscriberData.id!.toInt(), token: auth_Provider.subscriberToken.toString(), context: context);
                }else {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return DialogInternet();
                      });
                }
              });
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
    );
  }
}
