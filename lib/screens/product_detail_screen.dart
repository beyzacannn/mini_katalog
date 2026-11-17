import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../models/product.dart';
import '../widgets/back_label.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  Color _hex(String hex) =>
      Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));

  @override
  Widget build(BuildContext context) {
    // Route Arguments ile gelen ürün
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leadingWidth: 90,
        leading: const Align(
          alignment: Alignment.centerLeft,
          child: BackLabel(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(product.image, height: 220, fit: BoxFit.contain),
            ),
            const SizedBox(height: 12),
            Text(product.title,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 2),
            Text(product.subtitle,
                style: const TextStyle(fontSize: 17, color: Color(0xFF8E8E93))),
            const SizedBox(height: 10),
            Text(product.description,
                style: const TextStyle(fontSize: 13.5, height: 1.35)),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFE5E5EA)),
            const SizedBox(height: 14),
            const Text('Specifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ...product.specs.entries.map(
              (e) => _specRow(
                e.key,
                Text(e.value, style: const TextStyle(fontSize: 14)),
              ),
            ),
            _specRow(
              'COLORS',
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final c in product.colors)
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: _hex(c),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFD1D1D6)),
                      ),
                    ),
                ],
              ),
              last: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              final added = Cart.add(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(added
                      ? '${product.title} added to cart'
                      : '${product.title} is already in your cart'),
                ),
              );
            },
            child: const Text('Add to Cart',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }

  Widget _specRow(String label, Widget value, {bool last = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: Color(0xFFE5E5EA))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
          value,
        ],
      ),
    );
  }
}
