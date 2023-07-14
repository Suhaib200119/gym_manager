import 'package:flutter/material.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/feature/providers/Auth_Provider.dart';
import 'package:provider/provider.dart';

import 'Widgets/cardData.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var auth_provider=Provider.of<Auth_Provider>(context);
    return Container(
       decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Assets/images/backgroundAppImage.png"),
                  fit: BoxFit.cover
              ),
            ),
      child: Container(
           color: ColorsManager.blackColor.withOpacity(0.8),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [const  SizedBox(height: 24,),
              CardData(
                title:"بداية الاشتراك" ,
                value: "${auth_provider.subscriberData.subscriptionStart}",
                imageName: "Subscription_start.png",
              ),
              CardData(
                title:"نهاية الإشتراك" ,
                value: "${auth_provider.subscriberData.subscriptionEnd}",
                imageName: "Subscription_end.png",
              ),CardData(
                title:"نوع الاشتراك" ,
                value: "${auth_provider.subscriberData.subscription!.subscriptionType}",
                imageName: "subscription_type.png",
              ),CardData(
                title:"رسوم الإشتراك" ,
                value: "${auth_provider.subscriberData.subscription!.subscriptionPrice}",
                imageName: "money.png",
              ),
              CardData(
                title:"عدد التمارين" ,
                value: "${auth_provider.subscriberData.subscription!.numberExercises}",
                imageName: "Number_exercises.png",
              ),
              CardData(
                title:"الرصيد المالي" ,
                value: "${auth_provider.subscriberData.indebtedness}",
                imageName: "money.png",
              ),],),
    
    
      ),
    );
  }
}
