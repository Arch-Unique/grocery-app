import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/src/features/app_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Ui.padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(),
                AppText.bold("Our Products", fontSize: 24),
                Ui.boxHeight(16),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  children: List.generate(
                      10,
                      (index) => ProductCard(Product(
                          id: index.toString(),
                          name: "Product $index",
                          description: "Description $index",
                          qty: "$index kg",
                          image: "",
                          price: index * 200))),
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
      padding: EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image
            UniversalImage(
              product.image,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),

            Ui.boxHeight(16),
            // Name
            AppText.bold(product.name),
            Ui.boxHeight(8),
            AppText.thin(product.qty, fontSize: 10),
            Ui.boxHeight(8),
            Row(
              children: [
                AppText.bold(product.price.toCurrency(), fontSize: 14),
                const Spacer(),
                CartButton(product)
              ],
            )
          ]),
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
            onPressed: () {},
            icon: Stack(
              children: [
                AppIcon(Iconsax.shopping_cart),
                Positioned(
                    child: Obx(() {
                      return AppText.thin(
                        controller.cart.length.toString(),
                        color: AppColors.red,
                        fontSize: 8,
                      );
                    }),
                    bottom: 0,
                    right: 0)
              ],
            )),
        Ui.boxWidth(24),
        IconButton(onPressed: () {}, icon: AppIcon(Iconsax.search_normal)),
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
        ? AppButton.outline(() {
            controller.addToCart(product);
          }, "ADD")
        : counterwidget());
  }

  counterwidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () {
              product.cartQty.value += 1;
            },
            icon: AppIcon(Iconsax.add)),
        Ui.padding(child: Obx(() {
          return AppText.thin(product.cartQty.value.toString());
        })),
        IconButton(
            onPressed: () {
              product.cartQty.value -= 1;
              if (product.cartQty.value == 0) {
                controller.removeFromCart(product);
              }
            },
            icon: AppIcon(Iconsax.minus)),
      ],
    );
  }
}
