import 'package:hive/hive.dart';

import 'category_response.dart';
part 'product_response.g.dart';
@HiveType(typeId: 0)
class ProductResponse {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  String? slug;
  @HiveField(2)
  int? price;
  String? description;
  CategoryResponse? category;
  @HiveField(3)
  List<String>? images;
  String? creationAt;
  String? updatedAt;
  @HiveField(4)
  int quantity=1;

  ProductResponse(
      {this.id,
        this.title,
        this.slug,
        this.price,
        this.description,
        this.category,
        this.images,
        this.creationAt,
        this.updatedAt,
      this.quantity=1
      });

  ProductResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? new CategoryResponse.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }


}

