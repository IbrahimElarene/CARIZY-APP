import 'package:cartzy_app/core/model/response/product_response.dart';
import 'package:hive_flutter/adapters.dart';

// class CartLocalData {
//
//   // CartLocalData(){
//   //   getInt();
//   // }
//   // getInt()async{
//   //   await Hive.openBox<ProductResponse>('Cart');
//   //   var productBox=Hive.box<ProductResponse>('Cart');
//   // }
//   CartLocalData._();
//   static CartLocalData? cartLocalData;
//   static late Box<ProductResponse> productBox;
//
//   static Future<CartLocalData> get instance async{
//     await Hive.openBox<ProductResponse>('Cart');
//     productBox=Hive.box<ProductResponse>('Cart');
//     return cartLocalData??=CartLocalData._();
//   }
//   Future<void> addToCart(ProductResponse product) async{
//     // await Hive.openBox<ProductResponse>('Cart');
//     // var productBox=Hive.box<ProductResponse>('Cart');
//
//     await productBox.put(product.id, product);
//   }
//   Future<List<ProductResponse>>getCart()async {
//     // await Hive.openBox<ProductResponse>('Cart');
//     // var productBox=Hive.box<ProductResponse>('Cart');
//
//     return productBox.values.toList();
//   }
//   deleteToCart() {}
//
//   UpdateToCart() {}
//
//
//
//   clearCart() {}
// }
// class CartLocalData {
//   CartLocalData._();
//   static CartLocalData? cartLocalData;
//   static late Box<ProductResponse> productBox;
//
//   static Future<CartLocalData> get instance async {
//     await Hive.openBox<ProductResponse>('Cart');
//     productBox = Hive.box<ProductResponse>('Cart');
//     return cartLocalData ??= CartLocalData._();
//   }
//
//   Future<void> addToCart(ProductResponse product) async {
//     if (productBox.containsKey(product.id)) {
//       // لو المنتج موجود نزود الكمية
//       var existingProduct = productBox.get(product.id)!;
//       existingProduct.quantity = (existingProduct.quantity ?? 1) + 1;
//       await productBox.put(product.id, existingProduct);
//     } else {
//       product.quantity = 1; // أول مرة يدخل بكيمة 1
//       await productBox.put(product.id, product);
//     }
//   }
//
//   Future<List<ProductResponse>> getCart() async {
//     return productBox.values.toList();
//   }
//
//   Future<void> deleteFromCart(int productId) async {
//     await productBox.delete(productId);
//   }
//
//   Future<void> updateCart(ProductResponse product) async {
//     await productBox.put(product.id, product); // هنا هيعمل update تلقائي
//   }
//
//   Future<void> clearCart() async {
//     await productBox.clear();
//   }
// }
class CartLocalData {
  static late Box<ProductResponse> productBox;

  static Future<void> init() async {
    productBox = await Hive.openBox<ProductResponse>('cartBox');
  }

  static Future<CartLocalData> get instance async {
    return CartLocalData();
  }
  Future<void> addToCart(ProductResponse product) async {
    if (productBox.containsKey(product.id)) {
      // لو المنتج موجود نزود الكمية
      var existingProduct = productBox.get(product.id)!;
      existingProduct.quantity = (existingProduct.quantity ?? 1) + 1;
      await productBox.put(product.id, existingProduct);
    } else {
      product.quantity = 1; // أول مرة يدخل بكيمة 1
      await productBox.put(product.id, product);
    }
  }
  Future<void> clearCart() async {
    await productBox.clear();
  }

  Future<void> deleteFromCart(int id) async {
    final key = productBox.keys.firstWhere(
          (k) => productBox.get(k)!.id == id,
      orElse: () => null,
    );
    if (key != null) {
      await productBox.delete(key);
    }
  }

  Future<void> updateCart(ProductResponse product) async {
    final key = productBox.keys.firstWhere(
          (k) => productBox.get(k)!.id == product.id,
      orElse: () => null,
    );
    if (key != null) {
      await productBox.put(key, product);
    }
  }
}

class FavoriteLocalData {
  static late Box<ProductResponse> favoriteBox;

  static Future<void> init() async {
    favoriteBox = await Hive.openBox<ProductResponse>('favoriteBox');
  }

  static Future<FavoriteLocalData> get instance async {
    return FavoriteLocalData();
  }

  Future<void> addToFavorite(ProductResponse product) async {
    // لو المنتج موجود بالفعل ما نكرروش
    final exists = favoriteBox.values.any((p) => p.id == product.id);
    if (!exists) {
      await favoriteBox.add(product);
    }
  }

  Future<void> deleteFromFavorite(int id) async {
    final key = favoriteBox.keys.firstWhere(
          (k) => favoriteBox.get(k)!.id == id,
      orElse: () => null,
    );
    if (key != null) {
      await favoriteBox.delete(key);
    }
  }

  Future<void> clearFavorite() async {
    await favoriteBox.clear();
  }
}

