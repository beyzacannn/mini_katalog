import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/product.dart';

/// assets/data/products.json dosyasından ürünleri okur (JSON simülasyonu).
class ProductRepository {
  static Future<List<Product>> loadProducts() async {
    final raw = await rootBundle.loadString('assets/data/products.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final list = data['products'] as List<dynamic>;
    return list
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
