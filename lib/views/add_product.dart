import 'package:dars26/db/products_database.dart';
import 'package:dars26/models/product_fields.dart';
import 'package:dars26/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late List<TextEditingController> controllers;
  @override
  void initState() {
    controllers = List.generate(
        4, (index) => TextEditingController());
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          textMethod(controllers[0]),
          textMethod(controllers[1]),
          textMethod(controllers[2]),
          textMethod(controllers[3]),
          SizedBox(
            height: 100,
          ),
          ElevatedButton(
              onPressed: () {
                final product = ProductModel(
                    id: int.parse(controllers[0].text),
                    name: controllers[1].text,
                    companyName: controllers[2].text,
                    price: int.parse(controllers[3].text));

                ProductsDatabase.instance.create(product);
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Enter"))
        ],
      ),
    );
  }

  TextFormField textMethod(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }
}
