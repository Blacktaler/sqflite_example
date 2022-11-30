import 'package:dars26/models/product_fields.dart';

class ProductModel {
  int id;
  String name;
  String companyName;
  int price;

  ProductModel(
      {required this.id,
      required this.name,
      required this.companyName,
      required this.price});


  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
      id: map['_id'],
      name: map['name'],
      companyName: map[ProductFields.companyName],
      price: map[ProductFields.price]);


  Map<String, dynamic> toMap(){
    Map<String,dynamic> map = Map();
    map['_id'] = id;
    map['name'] = name;
    map[ProductFields.companyName] = companyName;
    map[ProductFields.price] = price;
    return map;
  }
}

