// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:inteqc_app/states/main_home.dart';
import 'package:inteqc_app/utility/app_constant.dart';
import 'package:inteqc_app/utility/app_controller.dart';
import 'package:inteqc_app/widgets/widget_button.dart';
import 'package:inteqc_app/widgets/widget_form.dart';
import 'package:inteqc_app/widgets/widget_icon_button.dart';
import 'package:inteqc_app/widgets/widget_image.dart';
import 'package:inteqc_app/widgets/widget_textbutton.dart'
    show WidgetTextButton;
import 'package:loader_overlay/loader_overlay.dart';

class Authen extends StatefulWidget {
  final String platform;
  const Authen({super.key, required this.platform});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  AppController appController = Get.find();

  final keyForm = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80), 
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Center(
                        child: SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: widget_image(),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'INTEQC Application',
                      style: AppConstant.headStyle(),
                    ),
                  ),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.9,
                            child: Form(
                              key: keyForm,
                              child: Column(
                                children: [
                                  SizedBox(height: 60),
                                  WidgetForm(
                                    hintText: 'Username',
                                    labelText: 'Username',
                                    suffixIcon: WidgetIconButton(
                                      icon: Icons.person_2,
                                      onPressed: () {},
                                    ),
                                    validator: (p0) {
                                      if (p0?.isEmpty ?? true) {
                                        return 'Please Fill Username';
                                      } else {
                                        return null;
                                      }
                                    },
                                    obscureText: false,
                                  ),
                                  SizedBox(height: 16),
                                  Obx(
                                    () => WidgetForm(
                                      validator: (p0) {
                                        if (p0?.isEmpty ?? true) {
                                          return 'Please Fill Password';
                                        } else {
                                          return null;
                                        }
                                      },
                                      hintText: 'Password',
                                      labelText: 'Password',
                                      obscureText: appController.resEye.value,
                                      suffixIcon: WidgetIconButton(
                                        icon: Icons.remove_red_eye,
                                        onPressed: () {
                                          appController.resEye.value =
                                              !appController.resEye.value;
                                        },
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 5),

                                  CheckboxListTile(
                                    value: false,
                                    onChanged: (value) {},
                                    title: Text(
                                      'Remember me',
                                      style: AppConstant.bodyStyle(),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),

                                  SizedBox(height: 8),

                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      return SizedBox(
                                        width: double.infinity,
                                        height: 40,
                                        child: WidgetButton(
                                          text: 'LOGIN',
                                          icon: Icon(
                                            Icons.login,
                                            color: Colors.white,
                                          ),
                                          onPressed: () async {
                                            if (keyForm.currentState!
                                                .validate()) {
                                              final ctx = context;

                                              try {
                                                ctx.loaderOverlay.show();
                                                FocusScope.of(
                                                  context,
                                                ).unfocus();

                                                await Future.delayed(
                                                  Duration(seconds: 1),
                                                );

                                                if (!mounted) return;

                                                Navigator.pushReplacement(
                                                  ctx,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        const MainHome(),
                                                  ),
                                                );
                                              } catch (e) {
                                                if (!mounted) return;
                                                debugPrint('Login error: $e');
                                                ScaffoldMessenger.of(
                                                  ctx,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Login failed: $e',
                                                    ),
                                                  ),
                                                );
                                              } finally {
                                                if (mounted) {
                                                  ctx.loaderOverlay.hide();
                                                }
                                              }
                                            }
                                          },

                                          fullWidthButton: true,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 8),

                                  Container(
                                    width: double.infinity,
                                    alignment: Alignment.centerRight,
                                    child: WidgetTextButton(
                                      onPressed: () {
                                        // ไปหน้า reset password
                                      },
                                      child: const Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            5,
                                            124,
                                            251,
                                          ),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
