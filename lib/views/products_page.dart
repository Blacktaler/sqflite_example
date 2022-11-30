import 'package:dars26/db/products_database.dart';
import 'package:dars26/models/product_model.dart';
import 'package:dars26/views/add_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductsPage extends StatefulWidget {
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<ProductModel>? products;
  late bool isloading;
  @override
  void initState() {
    updateProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        onPressed: () {
          pageRoute(
            
            AddProduct(
             updateCallback,
            isUpdate: false,
            id: 0,//bu id ishlatilmaydi
          ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(),
      body: !isloading
          ? products!.isEmpty
              ? Center(
                  child: Text("No Product"),
                )
              : ListView.builder(
                  itemCount: products!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(products![index].id.toString()),
                      title: Text(products![index].name),
                      subtitle: Text(products![index].companyName),
                      trailing: Row(
                        children: [
                          CupertinoButton(
                              child: Icon(Icons.edit),
                              onPressed: () {
                                pageRoute(
                                  AddProduct(
                                 updateCallback,
                                  isUpdate: true,
                                  id: products![index].id, //bu id ishlatiladi
                                ));
                              }),
                          IconButton(onPressed: (){
                            products!.removeAt(index);
                            setState(() {});
                            ProductsDatabase.instance.delete(products![index].id);
                          }, icon: Icon(Icons.delete_rounded,color: Colors.red,))
                        ],
                      ),
                    );
                  },
                )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  updateCallback(List<ProductModel> product) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      products = product;
      setState(() {});
    });
  }

  updateProducts() async {
    setState(() => isloading = true);

    products = await ProductsDatabase.instance.readAllProducts();

    setState(() => isloading = false);
  }

  void pageRoute(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
