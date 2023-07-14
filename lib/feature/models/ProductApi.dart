import 'package:gym_manager/feature/models/Services.dart';

class ProductApi {
  int? id;
  String? name;
  String? categoryId;
  String? image;
  String? basePrice;
  String? discount;
  String? priceAfterDiscount;
  String? quantity;
  String? description;
  String? productionDate;
  String? expiryDate;

  ProductApi(
      {this.id,
        this.name,
        this.categoryId,
        this.image,
        this.basePrice,
        this.discount,
        this.priceAfterDiscount,
        this.quantity,
        this.description,
        this.productionDate,
        this.expiryDate});

  ProductApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    categoryId = json['category_id'].toString();
    image = json['image'].toString().replaceAll("http://localhost/",Services.prefixUrlImage);
    basePrice = json['base_price'].toString();
    discount = json['discount'].toString();
    priceAfterDiscount = json['price_after_discount'].toString();
    quantity = json['quantity'].toString();
    description = json['description'].toString();
    productionDate = json['production_date'].toString();
    expiryDate = json['expiry_date'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['base_price'] = this.basePrice;
    data['discount'] = this.discount;
    data['price_after_discount'] = this.priceAfterDiscount;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['production_date'] = this.productionDate;
    data['expiry_date'] = this.expiryDate;
    return data;
  }
}
