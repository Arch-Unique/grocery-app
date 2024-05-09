import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/src/features/app_controller.dart';
import 'package:grocery_app/src/features/homepage.dart';
import 'package:grocery_app/src/global/ui/ui_barrel.dart';
import 'package:grocery_app/src/global/ui/widgets/others/containers.dart';
import 'package:grocery_app/src/src_barrel.dart';

class ProductPage extends StatefulWidget {
  const ProductPage(this.product, {super.key});
  final Product product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final controller = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return SinglePageScaffold(
      title: widget.product.name,
      child: SingleChildScrollView(
        child: Ui.padding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UniversalImage(
                "",
                height: Ui.width(context) / 3,
                width: Ui.width(context) / 3,
              ),
              Ui.boxHeight(24),
              AppText.bold(
                widget.product.name,
                fontSize: 24,
              ),
              Ui.boxHeight(8),
              AppText.thin(widget.product.description),
              Ui.boxHeight(8),
              AppText.thin(widget.product.qty),
              Ui.boxHeight(8),
              AppText.bold(widget.product.price.toCurrency()),
              Ui.boxHeight(8),
              CartButton(widget.product)
            ],
          ),
        ),
      ),
    );
  }
}
