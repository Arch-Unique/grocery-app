import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/src/global/ui/ui_barrel.dart';
import 'package:grocery_app/src/global/views/pages.dart';
import 'package:grocery_app/src/src_barrel.dart';

import '../global/services/barrel.dart';
import 'homepage.dart';

class AppController extends GetxController {
  RxList<TextEditingController> tecs =
      List.generate(4, (index) => TextEditingController()).obs;

  RxList<Product> products = List.generate(
                      10,
                      (index) => Product(
                          id: index.toString(),
                          name: "Product $index",
                          description: "Description $index",
                          qty: "$index kg",
                          image: Assets.ss1,
                          price: index * 200)).obs;
  RxList<Product> cart = <Product>[].obs;

  final appService = Get.find<AppService>();
  final authFormKey = GlobalKey<FormState>();

  login() async {
    if (authFormKey.currentState!.validate()) {
      appService.isLoggedIn.value = true;
      appService.currentUser.value.firstName = tecs[1].text;
      appService.currentUser.value.lastName = "";
      //appService.loginUser("jwt", "refreshJwt")
      Get.offAll(HomePage());
    } else {
      Ui.showError("Fields not validated");
    }
  }

  submitCart() async {
    Ui.showInfo("Successfully Submitted");
    Get.offAll(HomePage());
  }

  addToCart(Product pd) {
    pd.cartQty.value += 1;
    cart.add(pd);
  }

  removeFromCart(Product pd) {
    cart.remove(pd);
  }
}

class Product {
  final String name;
  final String id;
  final String description;
  final String qty;
  RxInt cartQty = 0.obs;
  final String image;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.qty,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      qty: json['qty'],
      image: json['image'],
      price: json['price'],
    );
  }
}
