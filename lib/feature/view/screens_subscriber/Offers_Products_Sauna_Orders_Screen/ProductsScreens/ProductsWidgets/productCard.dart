import 'package:flutter/material.dart';

import '../../../../../../core/colorsManager.dart';
import '../../../../../models/ProductApi.dart';
import 'customText.dart';

class ProductCard extends StatelessWidget {
ProductApi productApi;
 Function function;
ProductCard({required this.productApi,required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        function();
      },
      child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 22, left: 16, right: 16),
                padding: const EdgeInsetsDirectional.only( top: 10),
                decoration: BoxDecoration(
                  color: ColorsManager.whiteColor,
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Column(
                  children: [
                    //"Assets/images/nitro.jpeg"
                    Image.network("${productApi.image}",  width: 60,
                      height: 100,
                      fit: BoxFit.cover,),
                   const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorsManager.blackColor.withOpacity(0.6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomText(title:"الأسم",value: productApi.name.toString() ),
                          CustomText(title:"السعر",value: productApi.basePrice.toString() ),
                          CustomText(title:"الخصم",value: "${productApi.discount}" ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}