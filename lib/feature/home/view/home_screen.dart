import 'package:cartzy_app/core/data/remote_data/home_api.dart';
import 'package:cartzy_app/core/model/response/product_response.dart';
import 'package:cartzy_app/feature/home/controller/home_cubit.dart';
import 'package:cartzy_app/feature/home/widgets/tab_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/common/widget/product_item_widget.dart';
import '../../../core/model/response/category_response.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text.rich(
            TextSpan(
              text: 'Hi !,\n',
              style: TextStyle(
                color: Color(0xff212121),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: 'Let’s start your shopping',
                  style: TextStyle(
                    color: Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Categories",
            style: TextStyle(
              color: Color(0xff212121),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          //! getCategories
          // FutureBuilder<List<CategoryResponse>>(
          //   future: HomeApi.getCategories(),
          //   builder: (context, snapshot) {
          //     var listOfCategories = snapshot.data ?? [];
          //     return Skeletonizer(
          //       enabled: snapshot.connectionState == ConnectionState.waiting ||
          //           snapshot.hasError,
          //       child: TabContainerWidget(
          //         categories: listOfCategories,
          //       ),
          //     );
          //   },
          // ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              //Loading
              if (state is HomeCategoryLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: TabContainerWidget(
                    categories: dummyCategories,
                  ),
                );
              }
              //Error
              if (state is HomeCategoryError) {
                return Text(
                  state.messageError,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                );
              }
              //Success
              return TabContainerWidget(
                categories: context
                    .read<HomeCubit>()
                    .categories,
              );
            },
          ),
          SizedBox(height: 16),
          // FutureBuilder<List<ProductResponse>>(
          //   future: HomeApi.getProduct(),
          //   builder: (context, snapshot) {
          //     var productList = snapshot.data ?? [];
          //     return Expanded(
          //       child: GridView.builder(
          //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //           mainAxisSpacing: 15,
          //           crossAxisSpacing: 30,
          //           childAspectRatio: 163 / 288,
          //         ),
          //         itemBuilder: (context, index) => Skeletonizer(
          //             enabled:
          //                 snapshot.connectionState == ConnectionState.waiting ||
          //                     snapshot.hasError,
          //             child: ProdectItemWidget(product: productList[index])),
          //         itemCount: productList.length,
          //       ),
          //     );
          //   },
          // ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              //Loading
              if (state is HomeProductLoading) {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 30,
                      childAspectRatio: 163 / 288,
                    ),
                    itemBuilder: (context, index) =>
                        Skeletonizer(
                            enabled: true,
                            child: ProdectItemWidget(product:dummyProducts[index])),
                    itemCount:dummyProducts.length,
                  ),
                );
              }

              //Error
              if (state is HomeProductError) {
                return Text(
                  state.messageError,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                );
              }
              //Success
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 30,
                        childAspectRatio: 163 / 288,
                      ),
                      itemBuilder: (context, index) => ProdectItemWidget(product: context.read<HomeCubit>().products[index]),
                      itemCount: context.read<HomeCubit>().products.length,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}

List<CategoryResponse> dummyCategories = [
  CategoryResponse(name: "Category1"),
  CategoryResponse(name: "Category2"),
  CategoryResponse(name: "Category3"),
  CategoryResponse(name: "Category4"),
  CategoryResponse(name: "Category5"),
];
List<ProductResponse> dummyProducts = [
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),
  ProductResponse(
    images: [imageTest], title: 'Dummy Title Product', price: 30,),

];
