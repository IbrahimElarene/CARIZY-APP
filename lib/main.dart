import 'dart:developer';

import 'package:cartzy_app/core/data/remote_data/home_api.dart';
import 'package:cartzy_app/core/data/remote_data/profile_api.dart';
import 'package:cartzy_app/core/model/response/product_response.dart';
import 'package:cartzy_app/core/model/response/user_response.dart';
import 'package:cartzy_app/core/storage_helper/app_shared_preference_helper.dart';
import 'package:cartzy_app/feature/app_section/app_section.dart';
import 'package:cartzy_app/feature/auth/view/login_screen.dart';
import 'package:cartzy_app/feature/auth/view/register_screen.dart';
import 'package:cartzy_app/feature/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/common/screens/product_details_screen.dart';
import 'core/data/local_data/cart_local_data.dart';
import 'feature/home/view/product_of_category_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesHelper.init();
  List<ProductResponse> product=await HomeApi.getProduct();
  log(product.length.toString());
  // UserResponse user=await ProfileApi.getProfileData('Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjksImlhdCI6MTc1NjMyNzE4NSwiZXhwIjoxNzU4MDU1MTg1fQ.1Pujv1et1zQxEX6TQo7Uxdb_JzpefN6CXvKu0yDr4KY');
  // log(user.id.toString());
  // log(user.name.toString());
  await Hive.initFlutter();

  Hive.registerAdapter(ProductResponseAdapter()); // لو عندك Adapter للـ Product
  await CartLocalData.init();
  await FavoriteLocalData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "User App",
      initialRoute: OnboardingScreen.routeName,
      routes: {
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        AppSection.routeName: (context) => const AppSection(),
        ProductDetailsScreen.routeName: (context) =>  ProductDetailsScreen(),
      },
    );
  }
}
