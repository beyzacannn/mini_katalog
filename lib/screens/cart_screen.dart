import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../models/product.dart';
import '../widgets/back_label.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leadingWidth: 90,
        leading: const Align(
          alignment: Alignment.centerLeft,
          child: BackLabel(),
        ),
        title: const Text('Cart',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
      body: ValueListenableBuilder<List<Product>>(
        valueListenable: Cart.items,
        builder: (context, items, _) {
          if (items.isEmpty) return _emptyState();
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, color: Color(0xFFEDEDED)),
                  itemBuilder: (context, i) => _cartRow(context, items[i]),
                ),
              ),
              _checkoutBar(context),
            ],
          );
        },
      ),
    );
  }

  Widget _emptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add_shopping_cart_outlined,
              size: 100, color: Color(0xFFD1D1D6)),
          SizedBox(height: 12),
          Text('Your cart is empty',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Text('Add items to start shopping',
              style: TextStyle(fontSize: 13, color: Color(0xFF8E8E93))),
        ],
      ),
    );
  }

  Widget _cartRow(BuildContext context, Product product) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: product),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: Image.asset(product.image, fit: BoxFit.contain),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(product.subtitle, style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 2),
                  Text(product.priceText,
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            IconButton(
              onPressed: () => Cart.remove(product),
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkoutBar(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1, color: Color(0xFFEDEDED)),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 15),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
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
                final messenger = ScaffoldMessenger.of(context);
                Cart.clear();
                Navigator.pop(context);
                messenger.showSnackBar(
                  const SnackBar(content: Text('Order placed (demo)')),
                );
              },
              child: const Text('Checkout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
