import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/feature/GlobalWidgets/ResponseDialog.dart';
import 'package:gym_manager/feature/models/ProductApi.dart';
import 'package:gym_manager/feature/providers/Auth_Provider.dart';
import 'package:gym_manager/feature/providers/SubscriberOperations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../core/colorsManager.dart';
import '../../../../GlobalWidgets/dialogInternet.dart';
import 'ProductsWidgets/customTextDet.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductApi productApi;

  ProductDetailsScreen({required this.productApi});

  @override
  Widget build(BuildContext context) {
    var auth_provider = Provider.of<Auth_Provider>(context);
    var subscriberOperations = Provider.of<SubscriberOperations>(context);

    return Scaffold(
      backgroundColor: ColorsManager.blackColor,
      appBar: AppBar(
        backgroundColor: ColorsManager.blackColor,
        elevation: 0,
        title: Text(
          productApi.name.toString().toUpperCase(),
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
      body: Center(
        child: Container(
          height: 450,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 8),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: ColorsManager.whiteColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(children: [
            Image.network(
              "${productApi.image}" ,
              height: 200,
              width: 200,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: ColorsManager.blackColor.withOpacity(0.8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextDet(
                          title: "الأسم",
                          data: "${productApi.name.toString()}"),
                      CustomTextDet(
                          title: "السعر",
                          data: "${productApi.basePrice.toString()} "),
                      CustomTextDet(
                          title: "الخصم",
                          data: "${productApi.discount.toString()} "),
                    ],
                  ),
                  Text(
                    productApi.description.toString(),
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: ColorsManager.whiteColor,
                      ),
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                 Conditional.single(context: context, conditionBuilder: (context) {
                   return subscriberOperations.circleProg == false;
                 }, widgetBuilder: (context) {
                   return  FloatingActionButton(
                     onPressed: ()async {
                       final bool isConnected =
                       await InternetConnectionChecker().hasConnection;
                       if(isConnected){
                         subscriberOperations.changeCircleProg(circleProg: true);
                         subscriberOperations.addOrder(
                             subscriber_id:
                             auth_provider.subscriberData.id.toString(),
                             product_id: productApi.id.toString(),
                             token: auth_provider.subscriberToken,
                             ctx: context);
                       }else {
                         showDialog(
                             context: context,
                             builder: (ctx) {
                               return DialogInternet();
                             });
                       }

                     },
                     backgroundColor: ColorsManager.primaryColor,
                     child: Icon(
                       Icons.add,
                       color: ColorsManager.whiteColor,
                       size: 32,
                     ),
                   );
                 }, fallbackBuilder: (context) {
                   return LoadingAnimationWidget.hexagonDots(
                     color: ColorsManager.primaryColor,
                     size: 50,
                   );
                 },)
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
