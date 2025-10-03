import 'package:cartzy_app/feature/cart/view/cart_screen.dart';
import 'package:cartzy_app/feature/favorite/view/favorite_screen.dart';
import 'package:cartzy_app/feature/home/controller/home_cubit.dart';
import 'package:cartzy_app/feature/home/view/home_screen.dart';
import 'package:cartzy_app/feature/profile/controller/profile_cubit.dart';
import 'package:cartzy_app/feature/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AppSection extends StatefulWidget {
  static const String routeName = 'InitApp';

  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  List<Widget> widgetList = [
    BlocProvider<HomeCubit>(
        create: (context) => HomeCubit()
          ..getCategories()
          ..getProducts(),
        child: HomeScreen()),
    CartScreen(),
    FavoriteScreen(),
    BlocProvider<ProfileCubit>(
        create: (context) => ProfileCubit()..getDataProfile('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjksImlhdCI6MTc1NjMyNzE4NSwiZXhwIjoxNzU4MDU1MTg1fQ.1Pujv1et1zQxEX6TQo7Uxdb_JzpefN6CXvKu0yDr4KY'),
        child: ProfileScreen()),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffEBEBEB),
        unselectedFontSize: 13,
        selectedFontSize: 14,
        selectedItemColor: const Color(0xff212121),
        unselectedItemColor: const Color(0xff5C5C5C),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Color(0xff212121),
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Color(0xff5C5C5C),
        ),
        currentIndex: index,
        onTap: (selectedIndex) {
          index = selectedIndex;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-home.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              color: index == 0 ? Color(0xff212121) : Color(0xff5C5C5C),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-cart.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              color: index == 1 ? Color(0xff212121) : Color(0xff5C5C5C),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-favourite.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              color: index == 2 ? Color(0xff212121) : Color(0xff5C5C5C),
            ),
            label: ' Favorite',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-profile.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              color: index == 3 ? Color(0xff212121) : Color(0xff5C5C5C),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: widgetList[index]),
    );
  }
}
