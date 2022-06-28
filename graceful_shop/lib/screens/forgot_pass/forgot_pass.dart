import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/header_login_register.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  UserController userController = Get.find<UserController>();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtPassCompare = TextEditingController();
  TextEditingController txtOtp = TextEditingController();

  late String errorPhone = '';
  late String errorPass = '';
  late String errorPassCompare = '';
  late String errorOtp = '';

  RxBool isHiden = true.obs;

  changeHidenPass() {
    if (mounted) {
      isHiden.value = !isHiden.value;
    }
  }

  bool isCountdown = false;

  late Timer timer;
  int start = 30;

  void startTimer() {
    setState(() {});
    isCountdown = true;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {});
          timer.cancel();
          isCountdown = false;
          start = 30;
        } else {
          setState(() {});
          start--;
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    userController.isLoading.value = false;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
                  title: 'ForgotPass'.tr,
                  subTitle: 'ForgotPassTitle'.tr,
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
                      SizedBox(height: Dimensions.h20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Dimensions.w100,
                            child: TextField(
                              onChanged: (value){
                                if(value.length > 4){
                                  txtOtp.text = value.substring(0,4);
                                }
                              },
                              controller: txtOtp,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(width: 1,color: AppColors.blueAccentColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(width: 1,color: AppColors.blueAccentColor),
                                ),
                                label: Text(
                                  'OTP'.tr,
                                  style: TextStyle(
                                    fontSize: Dimensions.font16,
                                    color: AppColors.grayColor,
                                  ),
                                ),
                                errorText: errorOtp == '' ? null : errorOtp,
                                    
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          Expanded(
                            child: isCountdown 
                              ? Center(
                                  child: Text(
                                    '$start ${'Second'.tr}',
                                    style: TextStyle(
                                      fontSize: Dimensions.font15,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                )
                              : TextButton(
                                onPressed: (){
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  setState(() {});
                                  final phone = txtPhone.value.text;
                                  if (phone.isEmpty) {
                                    errorPhone = 'RequiredPhone'.tr;
                                    return;
                                  } else if (phone.length == 10 && phone.substring(0, 1) == '0' && (phone.substring(1, 2) == '3' 
                                              || phone.substring(1, 2) == '5' || phone.substring(1, 2) == '7' || phone.substring(1, 2) == '8' 
                                              || phone.substring(1, 2) == '9')) {
                                    errorPhone = '';
                                  } else {
                                    errorPhone = 'RequiredPhoneCorrect'.tr;
                                    return;
                                  }
                                  userController.requestOtp(phone); 
                                  startTimer();
                                }, 
                                child: Text(
                                  'GetOtp'.tr,
                                  style: TextStyle(
                                    fontSize: Dimensions.font15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimensions.h40, bottom: Dimensions.h7),
                        child: ButtonSignInUp(
                          isLoading: userController.isLoading.value,
                          title: 'Send'.tr,
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
                            //validation otp
                            final otp = txtOtp.value.text;
                            if (otp.isEmpty) {
                              errorOtp = 'RequiredOtp'.tr;
                            } else {
                              errorOtp = '';
                            }
                            print(otp);
                            //check error
                            if (errorPhone != '' || errorPass != ''|| errorPassCompare != '' || errorOtp != '') {
                              return;
                            } else {
                              userController.forgotPass(phone, otp, pass);
                            }
                          },
                        ),
                      ),
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
