import 'package:cartzy_app/core/model/response/category_response.dart';
import 'package:cartzy_app/feature/home/controller/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/common/widget/product_item_widget.dart';
import '../../../core/data/remote_data/home_api.dart';
import 'home_screen.dart';

class ProductOfCategoryScreen extends StatefulWidget {
   ProductOfCategoryScreen({super.key, required this.category});
  static const String routeName = 'ProductOfCategoryScreen';
final CategoryResponse category;
  @override
  State<ProductOfCategoryScreen> createState() => _ProductOfCategoryScreenState();
}

class _ProductOfCategoryScreenState extends State<ProductOfCategoryScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().getProductOfCategory(widget.category.id.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //var category = ModalRoute.of(context)?.settings.arguments as CategoryResponse;
    return Scaffold(
backgroundColor: Color(0xffEBEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xffEBEBEB),
        title: Text(widget.category.name ?? 'Category',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),),
      ),
      body: BlocBuilder<HomeCubit,HomeState>(builder: (context, state) {
        //Loading
        if(state is HomeProductOfCategoryLoading){
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
        if(state is HomeProductOfCategoryError){
          return Text(
            state.messageError,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.red),
          );
        }
        //Success
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 30,
                childAspectRatio: 163 / 288,
              ),
              itemBuilder:
                  (context, index) =>
                  ProdectItemWidget(product: context.read<HomeCubit>().productOfCategory[index]),
              itemCount: context.read<HomeCubit>().productOfCategory.length,
            );

      },),
      // FutureBuilder(
      //   future: HomeApi.getProductOfCategory(category.id.toString()),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     }
      //     if (snapshot.hasError) {
      //       return Text("Error");
      //     }
      //     var productList = snapshot.data ?? [];
      //     return GridView.builder(
      //       padding: EdgeInsets.symmetric(horizontal: 16),
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2,
      //         mainAxisSpacing: 15,
      //         crossAxisSpacing: 30,
      //         childAspectRatio: 163 / 288,
      //       ),
      //       itemBuilder:
      //           (context, index) =>
      //           ProdectItemWidget(product: productList[index]),
      //       itemCount: productList.length,
      //     );
      //   },
      // ),
    );
  }
}
