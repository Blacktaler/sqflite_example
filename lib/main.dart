import 'package:dars26/db/products_database.dart';
import 'package:dars26/models/product_model.dart';
import 'package:dars26/views/products_page.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: ProductsPage(),
    );
  }
}