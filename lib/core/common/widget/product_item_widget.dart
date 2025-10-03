// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cartzy_app/core/common/screens/product_details_screen.dart';
// import 'package:cartzy_app/core/model/response/product_response.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// class ProdectItemWidget extends StatefulWidget {
//    ProdectItemWidget({super.key, required this.product});
//
//   final ProductResponse product;
//
//   @override
//   State<ProdectItemWidget> createState() => _ProdectItemWidgetState();
// }
//
// class _ProdectItemWidgetState extends State<ProdectItemWidget> {
//   bool isFavorite = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).pushNamed(
//           ProductDetailsScreen.routeName,
//           arguments: widget.product,
//         );
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         spacing: 10,
//         children: [
//           Stack(
//             children: [
//               CachedNetworkImage(
//                 imageUrl: widget.product.images?[0] ?? imageTest,
//                 placeholder: (context, url) =>
//                 const Center(child: CircularProgressIndicator()),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//                 width: double.infinity,
//                 height: 240,
//                 fit: BoxFit.fill,
//               ),
//               Positioned(
//                 top: 5,
//                 right: 5,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       isFavorite = !isFavorite;
//                     });
//                   },
//                   child: Icon(
//                     isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: isFavorite ? Colors.red : Colors.black,
//                     size: 28,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             widget.product.title ?? "T-shirt oversize",
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: Colors.black,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "EGP ${widget.product.price}",
//             style: const TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.w400,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// const String imageTest = 'https://i.imgur.com/QkIa5tT.jpeg';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartzy_app/core/common/screens/product_details_screen.dart';
import 'package:cartzy_app/core/model/response/product_response.dart';
import 'package:flutter/material.dart';

import '../../data/local_data/cart_local_data.dart';



class ProdectItemWidget extends StatefulWidget {
  const ProdectItemWidget({super.key, required this.product});

  final ProductResponse product;

  @override
  State<ProdectItemWidget> createState() => _ProdectItemWidgetState();
}

class _ProdectItemWidgetState extends State<ProdectItemWidget> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // ✅ أول ما الصفحة تفتح نشيك إذا المنتج موجود في المفضلة
    isFavorite =
        FavoriteLocalData.favoriteBox.values.any((p) => p.id == widget.product.id);
  }

  void toggleFavorite() async {
    final fav = await FavoriteLocalData.instance;

    setState(() {
      if (isFavorite) {
        fav.deleteFromFavorite(widget.product.id!); // حذف من المفضلة
        isFavorite = false;
      } else {
        fav.addToFavorite(widget.product); // إضافة للمفضلة
        isFavorite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailsScreen.routeName,
          arguments: widget.product,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: widget.product.images?[0] ?? imageTest,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: double.infinity,
                height: 240,
                fit: BoxFit.fill,
              ),
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: toggleFavorite,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
          Text(
            widget.product.title ?? "T-shirt oversize",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "EGP ${widget.product.price}",
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

const String imageTest = 'https://i.imgur.com/QkIa5tT.jpeg';
