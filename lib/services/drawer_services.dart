import 'package:flutter/material.dart';
import 'package:food_vendor_app/screens/banner_screen.dart';
import 'package:food_vendor_app/screens/dashboard_screen.dart';
import 'package:food_vendor_app/screens/login_screen.dart';
import 'package:food_vendor_app/screens/product_screen.dart';

class DrawerServices {
  Widget drawerScreen(title) {
    if (title == 'Dashboard') {
      return MainScreen();
    }
    if (title == 'Product') {
      return ProductScreen();
    }
    if (title == 'Banner') {
      return BannerScreen();
    }
    if (title == 'LogOut') {
      return LoginScreen();
    }
    return MainScreen();
  }
}
