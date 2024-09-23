import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:torani/app/data/service_provider.dart';
import 'package:torani/app/env/colors.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 260,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Image.asset(
              "assets/images/torani-logo.png",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: loginController.usernameController,
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.person),
                contentPadding:
                    EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Obx(
              () => TextField(
                controller: loginController.passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => loginController.isPassword.value =
                        !loginController.isPassword.value,
                    icon: loginController.isPassword.value
                        ? const Icon(Icons.remove_red_eye)
                        : const Icon(Icons.visibility_off),
                  ),
                  hintText: 'Kata Sandi',
                  prefixIcon: Icon(Icons.key),
                  contentPadding:
                      EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                  ),
                ),
                obscureText: loginController.isPassword.value,
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              var email = loginController.usernameController.text;
              var pass = loginController.passwordController.text;
              ServiceProvider().login(context, email, pass);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Kirim",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
