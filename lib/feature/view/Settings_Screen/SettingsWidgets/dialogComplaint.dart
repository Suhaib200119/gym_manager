import 'package:dropdown_button2/dropdown_button2.dart';
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
import '../../../providers/SubscriberOperations.dart';

class DialogComplaint extends StatelessWidget {
  List<String> items = [
    "شكوى في موظف المالية",
    "شكوى في موظف الخدمات",
    "شكوى في المدرب",
    "شكوى في أحد المشتركين",
  ];
  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: GoogleFonts.cairo(
                fontSize: 14,
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  var formKeyComplaint = new GlobalKey<FormState>();
  TextEditingController tec_complaint = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var auth_provider = Provider.of<Auth_Provider>(context);
    var subscriber_operations = Provider.of<SubscriberOperations>(context);
    return AlertDialog(
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          "قم بتقديم الشكوى بكل مصداقية وسنقوم بمتابعتها بأسرع وقت",
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        SizedBox(
          height: 16,
        ),
        Form(
          key: formKeyComplaint,
          child: TextFormField(
            controller: tec_complaint,
            keyboardType: TextInputType.text,
            cursorColor: ColorsManager.blackColor,
            style: TextStyle(color: ColorsManager.blackColor),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              hintText: "قم بكتابة الشكوى هنا",
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
                return "يجب عليك كتابة الشكوى قبل الإرسال";
              }
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              hint: Text("قم باختيار نوع الشكوى"),
              items: _addDividersAfterItems(items),
              value: subscriber_operations.complaintType,
              onChanged: (value) {
                subscriber_operations.changeComplaintType(
                    complaintType: value as String);
                print(subscriber_operations.complaintType);
              },
              buttonStyleData: const ButtonStyleData(
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 25,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) {
            return subscriber_operations.circleProg == false;
          },
          widgetBuilder: (BuildContext context) {
            return MaterialButton(
              padding: EdgeInsets.zero,
              child: Container(
                width: 150,
                height: 40,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(color: ColorsManager.primaryColor),
                child: Text(
                  "إرسال",
                  style: GoogleFonts.cairo(
                    textStyle:
                    TextStyle(fontSize: 14, color: ColorsManager.whiteColor),
                  ),
                ),
              ),
              onPressed: () async {
                final bool isConnected =
                await InternetConnectionChecker().hasConnection;
                if (isConnected) {
                  subscriber_operations.changeCircleProg(circleProg: true);
                  if (formKeyComplaint.currentState!.validate()) {
                    subscriber_operations
                        .addComplaint(
                        token: auth_provider.subscriberToken.toString(),
                        complaint: tec_complaint.text,
                        subscriber_id: auth_provider.subscriberData.id!.toInt())
                        .then((value) {
                      subscriber_operations.changeCircleProg(circleProg: false);
                      showDialog(context: context, builder: (context) {
                        if(value.data['status']){
                          return ResponseDialog(isTransparent: false,isSuccess: true,message: value.data["message"],);
                        }else{
                          return ResponseDialog(isTransparent: false,isSuccess: false,message: value.data["message"],);
                        }
                      },);
                    })
                        .catchError((onError) {
                      showDialog(context: context, builder: (context) {
                        return ResponseDialog(message: "يوجد خطأ في البيانات المرسلة",isTransparent: false,isSuccess: false,);
                      },);

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
