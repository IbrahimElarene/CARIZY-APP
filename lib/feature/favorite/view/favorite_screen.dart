import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/data/local_data/cart_local_data.dart';
import '../../../core/model/response/product_response.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorites"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              final fav = await FavoriteLocalData.instance;
              await fav.clearFavorite(); // 🔥 مسح الكل
            },
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: FavoriteLocalData.favoriteBox.listenable(),
        builder: (context, box, child) {
          final products = box.values.toList().cast<ProductResponse>();

          if (products.isEmpty) {
            return const EmptyScreen(
              description: "No favorites yet ❤️",
              icon: Icons.favorite_border,
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xffF4F4F4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        product.images?[0] ?? "",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.title ?? "Product Name",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text("EGP ${product.price}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final fav = await FavoriteLocalData.instance;
                        await fav.deleteFromFavorite(product.id!); // 🔥 حذف واحد
                      },
                      icon: const Icon(Icons.favorite, color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.description, required this.icon});
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
