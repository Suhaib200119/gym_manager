import 'package:gym_manager/feature/models/Services.dart';

class OrderApi {
  String? id;
  String? subscriberId;
  String? productId;
  String? status;
  String? name;
  String? description;
  String? image;
  String? priceAfterDiscount;

  OrderApi(
      {this.id,
        this.subscriberId,
        this.productId,
        this.status,
        this.name,
        this.description,
        this.image,
        this.priceAfterDiscount});

  OrderApi.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    subscriberId = json['subscriber_id'].toString();
    productId = json['product_id'].toString();
    status = json['status'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    image = json['image'].toString().replaceAll("http://localhost/",Services.prefixUrlImage);
    priceAfterDiscount = json['price_after_discount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subscriber_id'] = this.subscriberId;
    data['product_id'] = this.productId;
    data['status'] = this.status;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price_after_discount'] = this.priceAfterDiscount;
    return data;
  }
}
