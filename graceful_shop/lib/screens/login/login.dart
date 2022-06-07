import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/widgets/button_sign_in_up.dart';
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
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPass = TextEditingController();

  late String errorPhone = '';
  late String errorPass = '';

  bool isHiden = true;
  changeHidenPass() {
    if (mounted) {
      setState(() {
        isHiden = !isHiden;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderLoginRegister(
                title: 'Login'.tr,
                subTitle: 'Login_Title'.tr,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w40),
                child: Column(
                  children: [
                    TextField(
                      controller: txtPhone,
                      decoration: InputDecoration(
                        label: Text(
                          'Input_Phone'.tr,
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
                      obscureText: isHiden,
                      controller: txtPass,
                      decoration: InputDecoration(
                        label: Text(
                          'Input_Pass'.tr,
                          style: TextStyle(
                            fontSize: Dimensions.font16,
                            color: AppColors.grayColor,
                          ),
                        ),
                        suffix: InkWell(
                          onTap: changeHidenPass,
                          child: Icon(
                            isHiden ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                        errorText: errorPass == '' ? null : errorPass,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.h40, bottom: Dimensions.h7),
                      child: ButtonSignInUp(
                        title: 'Login'.tr,
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {});
                          //validation phone
                          final phone = txtPhone.value.text;
                          if (phone.isEmpty) {
                            errorPhone = 'Required_Phone'.tr;
                          } else if (phone.length == 10 &&
                              phone.substring(0, 1) == '0' &&
                              (phone.substring(1, 2) == '3' ||
                                  phone.substring(1, 2) == '5' ||
                                  phone.substring(1, 2) == '7' ||
                                  phone.substring(1, 2) == '8' ||
                                  phone.substring(1, 2) == '9')) {
                            errorPhone = '';
                          } else {
                            errorPhone = 'Required_Phone_Correct'.tr;
                          }
                          //validation pass
                          final pass = txtPass.value.text;
                          if (pass.isEmpty) {
                            errorPass = 'Required_Pass'.tr;
                          } else if (pass.length < 6) {
                            errorPass = 'Required_Pass_Min'.tr;
                          } else if (pass.length > 20) {
                            errorPass = 'Required_Pass_Max'.tr;
                          } else {
                            errorPass = '';
                          }
                          //check error
                          if (errorPhone != '' || errorPass != '') {
                            return;
                          } else {}
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot_Pass'.tr,
                        style: TextStyle(
                          fontSize: Dimensions.font15,
                          color: AppColors.black2Color,
                        ),
                      ),
                    ),
                    const LoginWithGoogle(),
                    const LinkRegister(),
                    SizedBox(
                      height: Dimensions.h40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
