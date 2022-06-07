import 'package:amar_pharmacy/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class Cart extends Product{
  int count =0;
  Cart(
  String title,double price,String id,String description,String image,
      String category, this.count
      ): super(title,price,id,description,image,category);

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}