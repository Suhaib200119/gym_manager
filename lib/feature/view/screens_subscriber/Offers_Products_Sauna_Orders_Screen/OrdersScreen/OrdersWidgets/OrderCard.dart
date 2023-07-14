import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/feature/models/OrderApi.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/colorsManager.dart';
import '../../../../../providers/Auth_Provider.dart';
import '../../../../../providers/SubscriberOperations.dart';
import '../../../../../GlobalWidgets/dialogInternet.dart';
import '../../ProductsScreens/ProductsWidgets/customTextDet.dart';

class OrderCard extends StatelessWidget {
  OrderApi orderApi;

  OrderCard({required this.orderApi});

  @override
  Widget build(BuildContext context) {
    var subscriberOperations = Provider.of<SubscriberOperations>(context);
    var auth_provider = Provider.of<Auth_Provider>(context);
    return Container(
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
          "${orderApi.image}",
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
                      title: "الأسم", data: "${orderApi.name.toString()}"),
                  CustomTextDet(
                      title: "السعر",
                      data: "${orderApi.priceAfterDiscount.toString()} "),
                  CustomTextDet(
                    title: "الحالة",
                    data: orderApi.status == "1" ? "مُستلم" :orderApi.status == "0" ? "غير مُستلم":"مرفوض",
                  ),
                ],
              ),
              Text(
                orderApi.description.toString(),
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
              Conditional.single(
                context: context,
                conditionBuilder: (context) {
                  return orderApi.status == "0" ;
                },
                widgetBuilder: (context) {
                  return Conditional.single(
                    context: context,
                    conditionBuilder: (context) {
                      return subscriberOperations.circleProg == false;
                    },
                    widgetBuilder: (context) {
                      return FloatingActionButton(
                        onPressed: () async {
                          final bool isConnected =
                              await InternetConnectionChecker().hasConnection;
                          if (isConnected) {
                            subscriberOperations.changeCircleProg(
                                circleProg: true);
                            subscriberOperations.removeOrder(
                                subscriber_id:
                                    auth_provider.subscriberData.id.toString(),
                                pivot_id: orderApi.id.toString(),
                                token: auth_provider.subscriberToken,
                                ctx: context);
                          } else {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return DialogInternet();
                                });
                          }
                        },
                        backgroundColor: ColorsManager.primaryColor,
                        child: Icon(
                          Icons.delete,
                          color: ColorsManager.whiteColor,
                          size: 32,
                        ),
                      );
                    },
                    fallbackBuilder: (context) {
                      return LoadingAnimationWidget.hexagonDots(
                        color: ColorsManager.primaryColor,
                        size: 50,
                      );
                    },
                  );
                },
                fallbackBuilder: (context) {
                  if(orderApi.status == "1"){
                    return Text(
                      "تم إستلام الطلب",
                      style: GoogleFonts.cairo(
                        color: ColorsManager.primaryColor,
                      ),
                    );
                  }else if(orderApi.status == "-1"){
                    return Text(
                      "تم رفض الطلب",
                      style: GoogleFonts.cairo(
                        color: ColorsManager.primaryColor,
                      ),
                    );
                  }else{
                    return SizedBox();
                  }

                },
              ),
            ],
          ),
        )
      ]),
    );
  }
}
