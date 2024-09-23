import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:torani/app/components/dialog.dart';
import 'package:torani/app/env/colors.dart';
import 'package:torani/app/modules/login/views/login_view.dart';
import 'package:torani/app/widgets/text.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          title: CText(
            'Profile',
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.person,
                      color: primaryColor,
                      size: 36,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        "${profileController.box.read("userData")["name"]}",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      CText(
                        "${profileController.box.read("userData")["email"]}",
                        fontSize: 14,
                        color: Color(0xFF999999),
                      ),
                      CText("${profileController.box.read("userData")["role"]}",
                          fontSize: 14, color: Color(0xFF999999))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),
              CText(
                "Apps Version: 1.0.0",
                fontSize: 14,
              ),
              SizedBox(
                height: 8,
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  confirmMessage(
                    context,
                    "Konfirmasi Logout",
                    "Apakah Anda yakin ingin logout?",
                    () async {
                      profileController.box.remove("token");
                      profileController.box.remove("userData");
                      Get.offAll(() => LoginView());
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    CText(
                      "Logout",
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ));
  }
}
