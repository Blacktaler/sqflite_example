import 'package:dars26/models/product_fields.dart';
import 'package:dars26/models/product_model.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductsDatabase {
  static final ProductsDatabase instance = ProductsDatabase.init();

  ProductsDatabase.init();

  static Database? _database;

//4
  Future<Database> get database async {
    if (_database != null) return _database!;


  //3
    return await _initDB('products.db');
  }

// 2
  _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (datavase, version) {
        _createDB(datavase, version);
      },
    );
  }


// 1
  _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $productTable(
    _id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    companyName TEXT NOT NULL,
    price INTEGER NOT NULL
    )
''');
  }

  //CRUD

  create(ProductModel product) async {
    final db = await instance.database;

    await db.insert(productTable, product.toMap());
  }

  readAllProducts() async {
    final db = await instance.database;

    final data = await db.query(productTable);

    return data.map((e) => ProductModel.fromMap(e)).toList();
  }

  read(int id) async {
    final db = await instance.database;

    final data = await db.query(productTable, where: '_id', whereArgs: [id]);

    return ProductModel.fromMap(data.first);
  }

  update(ProductModel product,int id) async {
    final db = await instance.database;

    await db.update(productTable, product.toMap(),
    where: '${ProductFields.id}==?', // _id == ? ya'ni "_id" == id  
    whereArgs: [id] // id si orqali update qilinadi
    );
  }

  delete(int id) async {
    final db = await instance.database;

    await db.delete(productTable, where: '${ProductFields.id}==? ', whereArgs: [id]);
  }
}
