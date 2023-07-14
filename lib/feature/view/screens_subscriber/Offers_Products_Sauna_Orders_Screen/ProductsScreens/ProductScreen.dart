import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/feature/models/ProductApi.dart';
import 'package:gym_manager/feature/providers/Auth_Provider.dart';
import 'package:gym_manager/feature/providers/SubscriberOperations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'ProductDetailsScreen.dart';
import 'ProductsWidgets/productCard.dart';


class ProductScreen extends StatelessWidget {
  String category_id;
  String category_name;
  ProductScreen({required String this.category_id,required String this.category_name});

  @override
  Widget build(BuildContext context) {
  var subscriberOperations = Provider.of<SubscriberOperations>(context);

  return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.blackColor,
        elevation: 0,
        title: Text(
          "${category_name}",
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
          future:subscriberOperations.getAllProducts(category_id: category_id) ,
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
                print(snapshotData["status"]);
                if(snapshotData["status"]){
                  List<dynamic> products = snapshotData["products"];
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      ProductApi product=new ProductApi.fromJson(products[index]);
                      return ProductCard(
                        productApi: product,
                        function: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailsScreen(productApi: product);
                            },
                          ),
                          );
                        },
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
                    child: Image(image: AssetImage("Assets/images/error.png"),)
                );
              }
          },
        ),
      ),
    );
  }
}
