import 'package:cartzy_app/core/model/response/product_response.dart';
import 'package:flutter/material.dart';

import '../../data/local_data/cart_local_data.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  static const String routeName = "ProductDetailsScreen";

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments as ProductResponse;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 24,
          children: [
            Image.network(
              arg.images![0],
              width: double.infinity,
              height: 350,
              fit: BoxFit.fill,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    arg.title ?? "",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "EGP ${arg.price}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
            Text(
              arg.description ?? "",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: MaterialButton(
          minWidth: double.infinity,
          padding: EdgeInsets.all(16),
          onPressed: () async{
            final cart = await CartLocalData.instance;
            await cart.addToCart(arg);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${arg.title} added to cart"),
                duration: Duration(seconds: 2),
              ),
            );
          },
          color: Color(0xff212121),
          child: Text(
            'Add to cart',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
