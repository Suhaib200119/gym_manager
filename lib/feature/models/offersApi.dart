import 'package:gym_manager/feature/models/Services.dart';

class OfferApi {
  String? image;
  String? title;
  String? offerStart;
  String? offerEnd;
  String? description;

  OfferApi(
      {this.image,
        this.title,
        this.offerStart,
        this.offerEnd,
        this.description});

  OfferApi.fromJson(Map<String, dynamic> json) {
    image = json['image'].toString().replaceAll("http://localhost/",Services.prefixUrlImage);
    title = json['title'];
    offerStart = json['offer_start'];
    offerEnd = json['offer_end'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['offer_start'] = this.offerStart;
    data['offer_end'] = this.offerEnd;
    data['description'] = this.description;
    return data;
  }
}
