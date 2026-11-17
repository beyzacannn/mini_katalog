import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../data/product_repository.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _all = [];
  bool _loading = true;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final products = await ProductRepository.loadProducts();
    if (!mounted) return;
    setState(() {
      _all = products;
      _loading = false;
    });
  }

  List<Product> get _filtered {
    final q = _query.toLowerCase().trim();
    return _all
        .where((p) =>
            p.title.toLowerCase().contains(q) ||
            p.subtitle.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = _filtered;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildSearch()),
            SliverToBoxAdapter(child: _buildBanner(context)),
            if (_loading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (products.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text('No products found.')),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, i) {
                    final product = products[i];
                    return ProductCard(
                      product: product,
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: product, // Route Arguments
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 2),
                Text('Find your perfect device.',
                    style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          ValueListenableBuilder<List<Product>>(
            valueListenable: Cart.items,
            builder: (context, _, __) {
              return IconButton(
                onPressed: () => Navigator.pushNamed(context, '/cart'),
                icon: Badge(
                  backgroundColor: const Color(0xFF0A7AFF),
                  label: Text('${Cart.count}',
                      style: const TextStyle(fontSize: 10)),
                  child: const Icon(Icons.shopping_cart_outlined, size: 28),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: TextField(
        onChanged: (v) => setState(() => _query = v),
        decoration: InputDecoration(
          hintText: 'Search products',
          hintStyle: const TextStyle(color: Color(0xFF8E8E93)),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF8E8E93)),
          filled: true,
          fillColor: const Color(0xFFF1F1F3),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: InkWell(
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gift store is coming soon 🎁')),
        ),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFEDEDEF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('GIFT STORE 🎁',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
              SizedBox(height: 2),
              Text('GIFT YOUR IDEAS. CLICK FOR STORE. 🎁',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
