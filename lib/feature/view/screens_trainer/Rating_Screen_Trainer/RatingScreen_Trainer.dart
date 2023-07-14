import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/feature/providers/Trainer_Operations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../providers/Auth_Provider.dart';
import 'Widgets/cardData.dart';


class RatingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth_Provider>(context);
    var trainer_Operations = Provider.of<Trainer_Operations>(context);

    return Container(
       decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Assets/images/backgroundAppImage.png"),
                  fit: BoxFit.cover
              ),
            ),
      child: FutureBuilder(
        future: trainer_Operations.getAllRating(token: authProvider.trainerToken, trainerId: authProvider.trainerData.id.toString()),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: LoadingAnimationWidget.hexagonDots(
                color: ColorsManager.primaryColor,
                size: 50,
              ),
            );
          }else if(snapshot.hasData){
            dynamic snapshotData = jsonDecode(snapshot.data.toString());
            if(snapshotData["status"]){
              List<dynamic> ratings = snapshotData["ratings"];
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: ratings.length,
                itemBuilder: ((context, index) {
                  return CardData(
                    rateIndex: index+1,
                    date: "${ratings[index]["evaluation_date"]}",
                    rate: double.parse(ratings[index]["rating"].toString()),
                  );
                }),
              );
            }else{
              return Center(
                  child: Text("${snapshotData["message"]}",style: GoogleFonts.cairo(
                    color: ColorsManager.primaryColor,
                  ),)
              );
            }

          }
          else{
             return  Center(child: Text("Some Error",style: TextStyle(color: Colors.orange,fontSize: 25),),);
          }

        },
      ),
    );
  }
}
