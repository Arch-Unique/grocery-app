import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/src/features/app_controller.dart';
import 'package:grocery_app/src/global/ui/ui_barrel.dart';
import 'package:grocery_app/src/global/ui/widgets/fields/custom_textfield.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Ui.padding(
          child: Form(
            key: controller.authFormKey,
            child: Column(
              children: [
                AppText.bold("Grocery Shop",fontSize: 24),
                AppText.thin("Welcome to grocery shop"),
                const Spacer(),
                CustomTextField("Enter Unique Code", controller.tecs[0]),
                CustomTextField("User Name", controller.tecs[1]),
                CustomTextField.password("Password", controller.tecs[2]),
                const Spacer(),
                AppButton(
                    onPressed: () async {
                      await controller.login();
                    },
                    text: "Login"),
                Ui.boxHeight(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
