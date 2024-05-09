import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:grocery_app/src/features/app_controller.dart';
import 'package:grocery_app/src/features/cartpage.dart';
import 'package:grocery_app/src/features/productpage.dart';
import 'package:grocery_app/src/global/services/app_service.dart';
import 'package:grocery_app/src/global/ui/ui_barrel.dart';
import 'package:grocery_app/src/global/ui/widgets/others/containers.dart';
import 'package:grocery_app/src/src_barrel.dart';
import 'package:icons_plus/icons_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Ui.height(context),
          child: Ui.padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(),
                Ui.boxHeight(24),
                AppText.bold("Our Products", fontSize: 24),
                Ui.boxHeight(16),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: ((Ui.width(context)-64)/2)/240,
                  children: List.generate(
                      controller.products.length,
                      (index) => ProductCard(controller.products[index])),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  ProductCard(this.product, {super.key});
  final Product product;
  final controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return CurvedContainer(
      border: Border.all(color: AppColors.textFieldColor,strokeAlign: BorderSide.strokeAlignOutside),
      onPressed: (){
        Get.to(ProductPage(product));
      },
      radius: 16,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: AppColors.white,
              padding: EdgeInsets.all(4),
              child: Ui.align(
              align: Alignment.center,
              child: UniversalImage(
                product.image,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            ),
            // Image
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
              
              // Name
              AppText.bold(product.name),
              AppText.thin(product.qty, fontSize: 12),
              Ui.boxHeight(8),
              Row(
                children: [
                  AppText.bold(product.price.toCurrency(), fontSize: 14),
                  const Spacer(),
                  CartButton(product)
                ],
              )
                        ]),
            ),]),
    );
  }
}

class AppHeader extends StatelessWidget {
  AppHeader({super.key});
  final controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserProfilePic(),
        Ui.boxWidth(24),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.bold(
                  "Hello ${controller.appService.currentUser.value.fullName}"),
              AppText.thin("Any purchase you want to make today ?")
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              Get.to(CartPage());
            },
            icon: Stack(
              children: [
                AppIcon(Icons.shopping_cart_checkout_rounded),
                Positioned(
                    child: Obx(() {
                      return AppText.thin(
                        controller.cart.length.toString(),
                        color: AppColors.red,
                        fontSize: 12,
                      );
                    }),
                    bottom: 0,
                    right: 0)
              ],
            )),
        IconButton(onPressed: () {}, icon: AppIcon(Icons.search_rounded)),
      ],
    );
  }
}

class CartButton extends StatelessWidget {
  CartButton(this.product, {super.key});
  final Product product;
  final controller = Get.find<AppController>();

  RxInt curQty = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.cart.contains(product)
        ? counterwidget() :  InkWell(
          onTap:  () {
            controller.addToCart(product);
          },
          child: AppText.bold("ADD"),));
  }

  counterwidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
       GestureDetector(
            onTap: () {
              product.cartQty.value -= 1;
              if (product.cartQty.value == 0) {
                controller.removeFromCart(product);
              }
            },
            child: AppIcon(Iconsax.minus)),
        Ui.padding(
          padding: 4,
          child: Obx(() {
          return AppText.thin(product.cartQty.value.toString());
        })),
         GestureDetector(
            onTap: () {
              product.cartQty.value += 1;
            },
            child: AppIcon(Iconsax.add)),
        
      ],
    );
  }
}
