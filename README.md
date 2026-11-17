# Mini Katalog

Flutter eğitimi kapsamında geliştirilen basit bir ürün katalog uygulaması.

## Kısa Açıklama
Apple ürünleri temalı basit bir mobil katalog uygulaması. Ana sayfada (Discover) arama kutusu, "Gift Store" banner'ı ve GridView ile ürün kartları bulunur. Bir ürüne dokununca Route Arguments ile detay sayfasına geçilir (açıklama, özellikler, renkler). Ürünler sepete eklenir, sepet sayfasından silinir ve Checkout ile tamamlanır (simülasyon). Ekstra paket kullanılmamıştır; ürün verisi `assets/data/products.json` dosyasından okunur.

## Kullanılan Flutter Sürümü
Flutter 3.50.0 • Dart 3.14.0

## Özellikler
- Discover ana sayfası: arama, banner, 2 sütunlu ürün grid'i
- Ürün detayı: görsel, açıklama, Specifications, renk seçenekleri, Add to Cart
- Sepet: boş durum ekranı, ürün silme, Checkout (simülasyon), sepet adedi rozeti
- Named Routes + Route Arguments, model sınıfı (`fromJson` / `toJson`), asset yönetimi

## Çalıştırma Adımları
```bash
git clone https://github.com/beyzacann/mini_katalog.git
cd mini_katalog
flutter create --platforms=android .
flutter pub get
flutter run
```

## Klasör Yapısı
```
lib/
  main.dart
  models/product.dart
  data/product_repository.dart, cart.dart
  screens/home_screen.dart, product_detail_screen.dart, cart_screen.dart
  widgets/product_card.dart, back_label.dart
assets/
  data/products.json
  images/
```

## Ekran Görüntüleri
![Ana sayfa](screenshots/home.png)
![Detay](screenshots/detail.png)
![Sepet](screenshots/cart.png)
