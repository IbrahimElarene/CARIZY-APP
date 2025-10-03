import 'dart:developer';

import 'package:cartzy_app/core/model/response/category_response.dart';
import 'package:cartzy_app/feature/home/controller/home_cubit.dart';
import 'package:cartzy_app/feature/home/view/product_of_category_screen.dart';
import 'package:cartzy_app/feature/home/widgets/tab_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabContainerWidget extends StatefulWidget {
  const TabContainerWidget({
    super.key,
    required this.categories,
  });

  final List<CategoryResponse> categories;

  @override
  State<TabContainerWidget> createState() => _TabContainerWidgetState();
}

class _TabContainerWidgetState extends State<TabContainerWidget> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return DefaultTabController(
      length: widget.categories.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsets.zero,
            onTap: (int index) {
              log('Selected tab: ${widget.categories[index].id}');
              //Navigator.of(context).pushNamed(ProductOfCategoryScreen.routeName,arguments: widget.categories[index]);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                    value: cubit, child: ProductOfCategoryScreen(category: widget.categories[index],)),
              ));
            },
            tabs: widget.categories
                .map(
                  (source) => TabItemWidget(
                    category: source,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
