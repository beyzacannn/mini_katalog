import 'package:flutter/foundation.dart';

import '../models/product.dart';

/// Basit sepet simülasyonu. Liste değişince dinleyen widget'lar yenilenir.
class Cart {
  Cart._();

  static final ValueNotifier<List<Product>> items =
      ValueNotifier<List<Product>>([]);

  static int get count => items.value.length;

  static bool contains(Product p) => items.value.any((e) => e.id == p.id);

  /// Ürün zaten sepetteyse false döner.
  static bool add(Product p) {
    if (contains(p)) return false;
    items.value = [...items.value, p];
    return true;
  }

  static void remove(Product p) {
    items.value = items.value.where((e) => e.id != p.id).toList();
  }

  static void clear() => items.value = [];
}
