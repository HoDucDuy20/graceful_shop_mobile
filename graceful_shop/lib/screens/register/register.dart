import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
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
  UserController userController = Get.find<UserController>();

  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtPassCompare = TextEditingController();
  TextEditingController txtFullName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  late String errorPhone = '';
  late String errorPass = '';
  late String errorPassCompare = '';
  late String errorFullName = '';
  late String errorEmail = '';

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
                  title: 'Register'.tr,
                  subTitle: 'RegisterTitle'.tr,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w40),
                  child: Column(
                    children: [
                      TextField(
                        controller: txtFullName,
                        decoration: InputDecoration(
                          label: Text(
                            'InputName'.tr,
                            style: TextStyle(
                              fontSize: Dimensions.font16,
                              color: AppColors.grayColor,
                            ),
                          ),
                          errorText: errorFullName == '' ? null : errorFullName,
                        ),
                      ),
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
                        controller: txtEmail,
                        decoration: InputDecoration(
                          label: Text(
                            'Email'.tr,
                            style: TextStyle(
                              fontSize: Dimensions.font16,
                              color: AppColors.grayColor,
                            ),
                          ),
                          errorText: errorEmail == '' ? null : errorEmail,
                        ),
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
                      TextField(
                        obscureText: isHiden.value,
                        controller: txtPassCompare,
                        decoration: InputDecoration(
                          label: Text(
                            'InputPass2'.tr,
                            style: TextStyle(
                              fontSize: Dimensions.font16,
                              color: AppColors.grayColor,
                            ),
                          ),
                          errorText:
                              errorPassCompare == '' ? null : errorPassCompare,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.h40, bottom: Dimensions.h7),
                        child: ButtonSignInUp(
                          isLoading: userController.isLoading.value,
                          title: 'Register'.tr,
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            {
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
                              //validation pass compare
                              final passCompare = txtPassCompare.value.text;
                              if (passCompare.isEmpty) {
                                errorPassCompare = 'RequiredPass'.tr;
                              } else if (passCompare.length < 6) {
                                errorPassCompare = 'RequiredPassMin'.tr;
                              } else if (passCompare.length > 20) {
                                errorPassCompare = 'RequiredPassMax'.tr;
                              } else if (passCompare != pass) {
                                errorPassCompare = 'RequiredPass_Compare'.tr;
                              } else {
                                errorPassCompare = '';
                              }
                              //validation name
                              final fullName = txtFullName.value.text;
                              if (fullName.isEmpty) {
                                errorFullName = 'RequiredName'.tr;
                              } else if (fullName.length > 40) {
                                errorFullName = 'RequiredNameMax'.tr;
                              } else {
                                errorFullName = '';
                              }
                              //validation email
                              final email = txtEmail.value.text;
                              if (email.isEmpty) {
                                errorEmail = 'RequiredEmail'.tr;
                              } else if (!email.contains("@")) {
                                errorEmail = 'CorrectEmail'.tr;
                              } else {
                                errorEmail = '';
                              }
                              //check error
                              if (errorPhone != '' || errorPass != '' || errorPassCompare != '' || errorFullName != '') {
                                return;
                              } else {
                                userController.register(fullName, phone, email, pass);
                              }
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
            );
          }),
        ),
      ),
    );
  }
}
