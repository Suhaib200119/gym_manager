import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gym_manager/feature/GlobalWidgets/ResponseDialog.dart';
import 'package:gym_manager/feature/providers/Auth_Provider.dart';
import 'package:gym_manager/feature/providers/SubscriberOperations.dart';
import 'package:gym_manager/feature/GlobalWidgets/dialogInternet.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class DialoRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  var subscriber_operations = Provider.of<SubscriberOperations>(context);
  var auth_provider = Provider.of<Auth_Provider>(context);

    return AlertDialog(
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          "قم بتقييم المدرب  بكل مصداقية ",
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        SizedBox(
          height: 16,
        ),
        RatingBar.builder(
          initialRating: 1,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: ColorsManager.primaryColor,
          ),
          onRatingUpdate: (rating) {
            subscriber_operations.changePercentage(rating / 5 * 100);
            int ratingInt =rating.toInt();
            subscriber_operations.changeRating(ratingInt);
          },
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
                width:150,
                height: 40,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    color: ColorsManager.primaryColor
                ),
                child: Text(
                  "إرسال التقييم",
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
                  subscriber_operations.changeCircleProg(circleProg: true);
                  subscriber_operations.trainerRating(
                      trainer_id: auth_provider.subscriberData.trainerId!.toInt(),
                      subscriber_id: auth_provider.subscriberData.id!.toInt(),
                      rating: subscriber_operations.rating,
                      token: auth_provider.subscriberToken.toString()).then((value){
                    subscriber_operations.changeCircleProg(circleProg: false);
                    showDialog(context: context, builder: (context) {
                      if(value.data["status"]){
                        return ResponseDialog(isTransparent: false,isSuccess: true,message: value.data["message"],);
                      }else{
                        return ResponseDialog(isTransparent: false,isSuccess: false,message: value.data["message"],);
                      }
                    },);
                  }).catchError((onError){
                    return ResponseDialog(isTransparent: false,isSuccess: false,message: onError,);
                  });
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

        SizedBox(height: 8,),
        Text(
              "التقييم : ${subscriber_operations.percentage} %",
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                  fontSize:14,
                  color: ColorsManager.blackColor
                ),
              ),
            ),
      ]),
      backgroundColor: ColorsManager.whiteColor,
    );
  }
}
