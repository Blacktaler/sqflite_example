import 'dart:html';

import 'package:dars26/db/products_database.dart';
import 'package:dars26/models/product_fields.dart';
import 'package:dars26/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddProduct extends StatefulWidget {
  AddProduct(this.callback, {required this.isUpdate, required this.id});
  int id; //id update methodi uchun qo'shildi
  bool isUpdate;

  void Function(List<ProductModel> products)? callback;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late List<TextEditingController> controllers;
  List<ProductModel>? products;

  @override
  void dispose() {
    widget.callback!(products!);

    super.dispose();
  }

  @override
  void initState() {
    controllers = List.generate(4, (index) => TextEditingController());
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.isUpdate ? "Edit Product" : "Add Product"),
        actions: [
          TextButton(
            onPressed: () async {
              final productDB = ProductsDatabase.instance;

              final product = ProductModel(
                  id: int.parse(controllers[0].text),
                  name: controllers[1].text,
                  companyName: controllers[2].text,
                  price: int.parse(controllers[3].text));

              widget.isUpdate
                  ? productDB.update(product, widget.id) //id bu yerga beriladi
                  : productDB.create(product);

              products = await ProductsDatabase.instance.readAllProducts();
              setState(() {});

              Navigator.pop(context);
            },
            child: Text("save"),
          ),
        ],
      ),
      body: Column(
        children: [
          textMethod(controllers[0]),
          textMethod(controllers[1]),
          textMethod(controllers[2]),
          textMethod(controllers[3]),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  textMethod(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

}
