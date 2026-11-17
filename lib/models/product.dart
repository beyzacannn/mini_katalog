class Product {
  final int id;
  final String title;
  final String subtitle;
  final double price;
  final String image;
  final String description;
  final Map<String, String> specs;
  final List<String> colors;

  const Product({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.image,
    required this.description,
    required this.specs,
    required this.colors,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      description: json['description'] as String,
      specs: Map<String, String>.from(json['specs'] as Map),
      colors: List<String>.from(json['colors'] as List),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'price': price,
        'image': image,
        'description': description,
        'specs': specs,
        'colors': colors,
      };

  /// 1599 -> $1,599
  String get priceText {
    final s = price.round().toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return '\$$buf';
  }
}
