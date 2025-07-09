import 'dart:convert';
import 'package:ecommerce_demo_app/models/product_model.dart';
import 'package:flutter/services.dart';

class ProductService {
  static Future<List<Product>> loadProducts() async {
    final String response = await rootBundle.loadString(
      'assets/data/data.json',
    );
    // print(response);
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => Product.fromJson(json)).toList();
  }
}
