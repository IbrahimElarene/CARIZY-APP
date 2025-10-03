// import 'package:flutter/material.dart';
//
// import '../../../core/common/widget/product_item_widget.dart';
// import '../../../core/data/local_data/cart_local_data.dart';
//
// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         children: [
//           Text(
//             "My Cart",
//             style: TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.bold,
//               color: Color(0xff1F1F1F),
//             ),
//           ),
//           SizedBox(height: 16),
//           CartBodyWidget()
//         ],
//       ),
//     );
//   }
// }
//
// class CartBodyWidget extends StatelessWidget {
//   const CartBodyWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 5,
//       child: FutureBuilder<CartLocalData>(
//         future: CartLocalData.instance,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//
//           final cart = snapshot.data!;
//           final products = CartLocalData.productBox.values.toList();
//
//           if (products.isEmpty) {
//             return EmptyScreen(
//               description: "Your cart is empty",
//               image: "assets/images/empty.png",
//             );
//           }
//
//           return ListView.separated(
//             itemCount: products.length,
//             separatorBuilder: (context, index) => const SizedBox(height: 20),
//             itemBuilder: (context, index) {
//               final product = products[index];
//
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xffF4F4F4),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.network(
//                         product.images?[0] ?? imageTest,
//                         width: 100,
//                         height: 100,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(product.title ?? "Product Name"),
//                         Text("EGP ${product.price}"),
//                       ],
//                     ),
//                     Spacer(),
//                     Column(
//                       children: [
//                         IconButton(
//                           onPressed: () async {
//                             await cart.deleteFromCart(product.id!);
//                             (context as Element).reassemble(); // refresh بسيط
//                           },
//                           icon: Icon(Icons.cancel_outlined, size: 30),
//                         ),
//                         Row(
//                           children: [
//                             IconButton(
//                               onPressed: () async {
//                                 if ((product.quantity ?? 1) > 1) {
//                                   product.quantity = (product.quantity ?? 1) - 1;
//                                   await cart.updateCart(product);
//                                   (context as Element).reassemble();
//                                 }
//                               },
//                               icon: Icon(Icons.remove_circle_outline),
//                             ),
//                             Text("${product.quantity ?? 1}"),
//                             IconButton(
//                               onPressed: () async {
//                                 product.quantity = (product.quantity ?? 1) + 1;
//                                 await cart.updateCart(product);
//                                 (context as Element).reassemble();
//                               },
//                               icon: Icon(Icons.add_circle_outline),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//
//     // return Expanded(
//     //   child: Column(
//     //     children: [
//     //       Expanded(
//     //         flex: 5,
//     //         child: ListView.separated(
//     //           itemBuilder: (context, index) => Container(
//     //             decoration: BoxDecoration(
//     //               color: Color(0xffF4F4F4),
//     //               borderRadius: BorderRadius.circular(10),
//     //             ),
//     //             child: Row(
//     //               children: [
//     //                 ClipRRect(
//     //                   borderRadius: BorderRadius.circular(10),
//     //                   child: Image.network(
//     //                     "https://i.imgur.com/QkIa5tT.jpeg",
//     //                     width: 100,
//     //                     height: 100,
//     //                   ),
//     //                 ),
//     //                 SizedBox(width: 10),
//     //                 Column(
//     //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//     //                   crossAxisAlignment: CrossAxisAlignment.start,
//     //                   children: [
//     //                     Text(
//     //                       "Product Name",
//     //                       style: TextStyle(
//     //                         fontSize: 15,
//     //                         fontWeight: FontWeight.w500,
//     //                         color: Color(0xff212121),
//     //                       ),
//     //                     ),
//     //                     Text(
//     //                       "EGP 1000",
//     //                       style: TextStyle(
//     //                         fontSize: 15,
//     //                         fontWeight: FontWeight.w500,
//     //                         color: Color(0xff212121),
//     //                       ),
//     //                     ),
//     //                   ],
//     //                 ),
//     //                 Spacer(),
//     //                 Column(
//     //                   crossAxisAlignment: CrossAxisAlignment.end,
//     //                   children: [
//     //                     IconButton(
//     //                       onPressed: () {},
//     //                       icon: Icon(
//     //                         Icons.cancel_outlined,
//     //                         size: 30,
//     //                         color: Color(0xff212121),
//     //                       ),
//     //                     ),
//     //                     Container(
//     //                       decoration: BoxDecoration(
//     //                         color: Color(0xffF4F4F4),
//     //                         borderRadius: BorderRadius.circular(10),
//     //                       ),
//     //                       child: Row(
//     //                         mainAxisAlignment: MainAxisAlignment.center,
//     //                         mainAxisSize: MainAxisSize.min,
//     //                         children: [
//     //                           IconButton(
//     //                             onPressed: () {},
//     //                             icon: Icon(
//     //                               Icons.remove_circle_outline,
//     //                               color: Color(0xff212121),
//     //                             ),
//     //                           ),
//     //                           Text(
//     //                             "1",
//     //                             style: TextStyle(
//     //                               fontSize: 16,
//     //                               fontWeight: FontWeight.w500,
//     //                               color: Color(0xff212121),
//     //                             ),
//     //                           ),
//     //                           IconButton(
//     //                             onPressed: () {},
//     //                             icon: Icon(
//     //                               Icons.add_circle_outline,
//     //                               color: Color(0xff212121),
//     //                             ),
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   ],
//     //                 )
//     //               ],
//     //             ),
//     //           ),
//     //           separatorBuilder: (context, index) => const SizedBox(height: 20),
//     //           itemCount: 10,
//     //         ),
//     //       ),
//     //       Expanded(
//     //         flex: 1,
//     //         child: Container(
//     //           decoration: BoxDecoration(
//     //             borderRadius: BorderRadius.circular(10),
//     //           ),
//     //           child: Column(
//     //             children: [
//     //               SizedBox(height: 20),
//     //               Row(
//     //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                 children: [
//     //                   Text(
//     //                     "Total",
//     //                     style: TextStyle(
//     //                       fontSize: 20,
//     //                       fontWeight: FontWeight.bold,
//     //                       color: Color(0xff212121),
//     //                     ),
//     //                   ),
//     //                   Text(
//     //                     "EGP 1000",
//     //                     style: TextStyle(
//     //                       fontSize: 15,
//     //                       fontWeight: FontWeight.w500,
//     //                       color: Color(0xff212121),
//     //                     ),
//     //                   ),
//     //                 ],
//     //               ),
//     //               Divider(),
//     //               MaterialButton(
//     //                 minWidth: double.infinity,
//     //                 height: 50,
//     //                 onPressed: () {},
//     //                 color: Color(0xff212121),
//     //                 shape:
//     //                     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     //                 child: Text(
//     //                   "Checkout",
//     //                   style: TextStyle(
//     //                     fontSize: 16,
//     //                     fontWeight: FontWeight.w400,
//     //                     color: Color(0xffFFFFFF),
//     //                   ),
//     //                 ),
//     //               )
//     //             ],
//     //           ),
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }
//
// class EmptyScreen extends StatelessWidget {
//   const EmptyScreen({
//     super.key,
//     required this.description,
//     required this.image,
//   });
//   final String description;
//   final String image;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(height: 150),
//           Image.asset(image),
//           Text(
//             description,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//               color: Color(0xff5C5C5C),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../../../core/data/local_data/cart_local_data.dart';
import '../../../core/dialogs/app_toasts.dart';
import '../../../core/model/response/product_response.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              final cart = await CartLocalData.instance;
              await cart.clearCart(); // مسح الكارت كله
            },
          )
        ],
      ),
      body: Column(
        children: const [
          CartBodyWidget(),
          CartTotalWidget(), // الجزء بتاع التوتال يفضل ثابت تحت
        ],
      ),
    );
  }
}

class CartBodyWidget extends StatelessWidget {
  const CartBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded( // 👈 هنا Expanded موجود دايمًا
      child: ValueListenableBuilder(
        valueListenable: CartLocalData.productBox.listenable(),
        builder: (context, box, child) {
          final products = box.values.toList().cast<ProductResponse>();

          if (products.isEmpty) {
            return const EmptyScreen(
              description: "Your cart is empty",
              image: "assets/image/empty-cart.png",
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
                    Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final cart = await CartLocalData.instance;
                            await cart.deleteFromCart(product.id!);
                          },
                          icon: const Icon(Icons.cancel_outlined, size: 24),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon:
                              const Icon(Icons.remove_circle_outline),
                              onPressed: () async {
                                if ((product.quantity ?? 1) > 1) {
                                  product.quantity =
                                      (product.quantity ?? 1) - 1;
                                  final cart = await CartLocalData.instance;
                                  await cart.updateCart(product);
                                }
                              },
                            ),
                            Text("${product.quantity ?? 1}",
                                style: const TextStyle(fontSize: 14)),
                            IconButton(
                              icon:
                              const Icon(Icons.add_circle_outline),
                              onPressed: () async {
                                product.quantity =
                                    (product.quantity ?? 1) + 1;
                                final cart = await CartLocalData.instance;
                                await cart.updateCart(product);
                              },
                            ),
                          ],
                        ),
                      ],
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

class CartTotalWidget extends StatelessWidget {
  const CartTotalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CartLocalData.productBox.listenable(),
      builder: (context, box, child) {
        final products = box.values.toList().cast<ProductResponse>();

        final total = products.fold<double>(
          0,
              (sum, item) => sum + (item.price ?? 0) * (item.quantity ?? 1),
        );

        if (products.isEmpty) return const SizedBox(); // يخفي لو الكارت فاضي

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("EGP $total",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 10),
              MaterialButton(
                minWidth: double.infinity,
                height: 45,
                onPressed: () {
               return AppToast.showToast(
                      context: context,
                      title: "Success",
                      description: "Success",
                      type: ToastificationType.success);
                },
                color: const Color(0xff212121),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  "Checkout",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.description, required this.image});
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, width: 200, height: 200),
            const SizedBox(height: 20),
            Text(description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

