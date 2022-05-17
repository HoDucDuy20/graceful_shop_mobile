import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/widgets/button_sign_in_up.dart';
import 'package:graceful_shop/screens/login/login_with_google.dart';
import 'package:graceful_shop/screens/register/link_login.dart';
import 'package:graceful_shop/screens/register/proviso.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/header_login_register.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtPassCompare = TextEditingController();
  TextEditingController txtFullName = TextEditingController();

  late String errorPhone = '';
  late String errorPass = '';
  late String errorPassCompare = '';
  late String errorFullName = '';

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
                title: 'Register'.tr,
                subTitle: 'Register_Title'.tr,
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
                    TextField(
                      obscureText: isHiden,
                      controller: txtPassCompare,
                      decoration: InputDecoration(
                        label: Text(
                          'Input_Pass_2'.tr,
                          style: TextStyle(
                            fontSize: Dimensions.font16,
                            color: AppColors.grayColor,
                          ),
                        ),
                        errorText:
                            errorPassCompare == '' ? null : errorPassCompare,
                      ),
                    ),
                    TextField(
                      controller: txtFullName,
                      decoration: InputDecoration(
                        label: Text(
                          'Input_Name'.tr,
                          style: TextStyle(
                            fontSize: Dimensions.font16,
                            color: AppColors.grayColor,
                          ),
                        ),
                        errorText: errorFullName == '' ? null : errorFullName,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.h40, bottom: Dimensions.h7),
                      child: ButtonSignInUp(
                        title: 'Register'.tr,
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          {
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
                            //validation pass compare
                            final passCompare = txtPassCompare.value.text;
                            if (passCompare.isEmpty) {
                              errorPassCompare = 'Required_Pass'.tr;
                            } else if (passCompare.length < 6) {
                              errorPassCompare = 'Required_Pass_Min'.tr;
                            } else if (passCompare.length > 20) {
                              errorPassCompare = 'Required_Pass_Max'.tr;
                            } else if (passCompare != pass) {
                              errorPassCompare = 'Required_Pass_Compare'.tr;
                            } else {
                              errorPassCompare = '';
                            }
                            //validation name
                            final fullName = txtFullName.value.text;
                            if (fullName.isEmpty) {
                              errorFullName = 'Required_Name'.tr;
                            } else if (fullName.length > 40) {
                              errorFullName = 'Required_Name_Max'.tr;
                            } else {
                              errorFullName = '';
                            }
                            //check error
                            if (errorPhone != '' ||
                                errorPass != '' ||
                                errorPassCompare != '' ||
                                errorFullName != '') {
                              return;
                            } else {}
                          }
                        },
                      ),
                    ),
                    const LinkLogin(),
                    const LoginWithGoogle(),
                    const Proviso(),
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
