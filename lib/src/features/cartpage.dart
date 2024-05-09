import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/src/features/app_controller.dart';
import 'package:grocery_app/src/features/homepage.dart';
import 'package:grocery_app/src/global/ui/ui_barrel.dart';
import 'package:grocery_app/src/global/ui/widgets/others/containers.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final controller = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return SinglePageScaffold(
      title: "Cart Items",
      child: Ui.padding(
          child: Column(
        children: [
          Expanded(
              child: ListView.separated(
                  itemBuilder: (_, i) {
                    final pd = controller.cart[i];
                    return ListTile(
                      leading: UniversalImage(
                        pd.image,
                        height: 48,
                        width: 48,
                      ),
                      title: AppText.bold(pd.name),
                      subtitle: AppText.thin("${pd.qty} | ${pd.price}"),
                      trailing: CartButton(pd),
                    );
                  },
                  separatorBuilder: (_, i) {
                    return AppDivider();
                  },
                  itemCount: controller.cart.length)),
          Ui.boxHeight(24),
          AppButton(
            onPressed: () async {
              await controller.submitCart();
              // Get.to(() => const HomePage());
            },
            text: "Submit",
          )
        ],
      )),
    );
  }
}
