import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/screens/forgot_pass/forgot_pass.dart';
import 'package:graceful_shop/screens/login/link_register.dart';
import 'package:graceful_shop/screens/login/login_with_google.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/header_login_register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserController userController = Get.find<UserController>();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  late String errorPhone = '';
  late String errorPass = '';
  RxBool isHiden = true.obs;

  changeHidenPass() {
    if (mounted) {
      isHiden.value = !isHiden.value;
    }
  }

  @override
  void initState() {
    super.initState();
    userController.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              children: [
                HeaderLoginRegister(
                  title: 'Login'.tr,
                  subTitle: 'LoginTitle'.tr,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w40),
                  child: Column(
                    children: [
                      TextField(
                        controller: txtPhone,
                        decoration: InputDecoration(
                          label: Text(
                            'InputPhone'.tr,
                            style: TextStyle(
                              fontSize: Dimensions.font16,
                              color: AppColors.grayColor,
                            ),
                          ),
                          errorText: errorPhone == '' ? null : errorPhone,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered
                      ),
                      TextField(
                        obscureText: isHiden.value,
                        controller: txtPass,
                        decoration: InputDecoration(
                          label: Text(
                            'InputPass'.tr,
                            style: TextStyle(
                              fontSize: Dimensions.font16,
                              color: AppColors.grayColor,
                            ),
                          ),
                          suffix: InkWell(
                            onTap: changeHidenPass,
                            child: Icon(
                              isHiden.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          errorText: errorPass == '' ? null : errorPass,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimensions.h40, bottom: Dimensions.h7),
                        child: ButtonSignInUp(
                          isLoading: userController.isLoading.value,
                          title: 'Login'.tr,
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {});
                            //validation phone
                            final phone = txtPhone.value.text;
                            if (phone.isEmpty) {
                              errorPhone = 'RequiredPhone'.tr;
                            } else if (phone.length == 10 && phone.substring(0, 1) == '0' && (phone.substring(1, 2) == '3' 
                                        || phone.substring(1, 2) == '5' || phone.substring(1, 2) == '7' || phone.substring(1, 2) == '8' 
                                        || phone.substring(1, 2) == '9')) {
                              errorPhone = '';
                            } else {
                              errorPhone = 'RequiredPhoneCorrect'.tr;
                            }
                            //validation pass
                            final pass = txtPass.value.text;
                            if (pass.isEmpty) {
                              errorPass = 'RequiredPass'.tr;
                            } else if (pass.length < 6) {
                              errorPass = 'RequiredPassMin'.tr;
                            } else if (pass.length > 20) {
                              errorPass = 'RequiredPassMax'.tr;
                            } else {
                              errorPass = '';
                            }
                            //check error
                            if (errorPhone != '' || errorPass != '') {
                              return;
                            } else {
                              userController.logIn(phone, pass);
                            }
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const ForgotPass());
                        },
                        child: Text(
                          'ForgotPass'.tr,
                          style: TextStyle(
                            fontSize: Dimensions.font15,
                            color: AppColors.black2Color,
                          ),
                        ),
                      ),
                      const LoginWithGoogle(),
                      const LinkRegister(),
                      SizedBox(height: Dimensions.h40),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
