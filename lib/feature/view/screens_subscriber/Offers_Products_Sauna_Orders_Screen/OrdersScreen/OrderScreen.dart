import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/feature/models/OrderApi.dart';
import 'package:gym_manager/feature/view/screens_subscriber/Offers_Products_Sauna_Orders_Screen/OrdersScreen/OrdersWidgets/OrderCard.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../core/colorsManager.dart';
import '../../../../providers/Auth_Provider.dart';
import '../../../../providers/SubscriberOperations.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var subscriberOperations = Provider.of<SubscriberOperations>(context);
    var auth_provider = Provider.of<Auth_Provider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.blackColor,
        elevation: 0,
        title: Text(
          "الطلبات",
          style: GoogleFonts.cairo(
            textStyle: TextStyle(
              color: ColorsManager.primaryColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        titleSpacing: 0,
        iconTheme: IconThemeData(color: ColorsManager.primaryColor),
        actions: [
          Image.asset(
            "Assets/images/GymLogo.png",
            width: 25,
            height: 25,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        color: ColorsManager.blackColor,
        child: FutureBuilder(
          future:subscriberOperations.getAllMyOrders(
              subscriber_id: auth_provider.subscriberData.id.toString(),
              token: auth_provider.subscriberToken) ,
          builder:(context, snapshot) {
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
                List<dynamic> orders = snapshotData["orders"];
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(height: 8,);
                  },
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    print("index: ${index} : ${orders[index]["pivot"]["status"]}");
                    Map<String,dynamic> mapDtata={
                      "id":orders[index]["pivot"]["id"],
                      "subscriberId":orders[index]["pivot"]["subscriber_id"],
                      "productId":orders[index]["pivot"]["productId"],
                      "status":orders[index]["pivot"]["status"],
                      "name":orders[index]["name"],
                      "description":orders[index]["description"],
                      "image":orders[index]["image"],
                      "price_after_discount":orders[index]["price_after_discount"],
                    };
                    OrderApi order=new OrderApi.fromJson(mapDtata);
                    return OrderCard(
                      orderApi: order,
                    );
                  },
                );
              }else{
                return Center(
                    child: Text("${snapshotData["message"]}",style: GoogleFonts.cairo(
                      color: ColorsManager.primaryColor,
                    ),)
                );
              }
            }else {
              return Center(
                child: Text(
                  "حدثت مشكلة , ربما بسبب انقطاع الإتصال بالانترنت",
                  style: GoogleFonts.cairo(
                    color: ColorsManager.primaryColor,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

}
