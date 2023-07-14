import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/feature/models/offersApi.dart';
import '../../../../../../core/colorsManager.dart';

class CardOffers extends StatelessWidget {
  OfferApi offersApi;
  CardOffers({super.key, required this.offersApi});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          color: ColorsManager.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "${offersApi.image}",
              width: MediaQuery.of(context).size.width,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "${offersApi.title}",
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            "${offersApi.description}",
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
