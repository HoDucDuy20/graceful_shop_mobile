import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graceful_shop/screen/login/link_register.dart';
import 'package:graceful_shop/screen/login/login_with_google.dart';
import 'package:graceful_shop/utils/colors.dart';
import 'package:graceful_shop/utils/dimensions.dart';
import 'package:graceful_shop/widgets/header_login_register.dart';

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
                title: 'Đăng nhập',
                subTitle: 'Vui lòng điền đầy đủ thông tin để đăng nhập',
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w40),
                child: Column(
                  children: [
                    TextField(
                      controller: txtPhone,
                      decoration: InputDecoration(
                        label: Text(
                          'Nhập só điện thoại',
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
                          'Mật khẩu',
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
                      child: MaterialButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {});
                          //validation phone
                          final phone = txtPhone.value.text;
                          if (phone.isEmpty) {
                            errorPhone = 'Nhập số điện thoại';
                          } else if (phone.length != 10 ||
                              phone.substring(0, 1) != '0' ||
                              phone.substring(1, 2) != '3' ||
                              phone.substring(1, 2) != '5' ||
                              phone.substring(1, 2) != '7' ||
                              phone.substring(1, 2) != '8' ||
                              phone.substring(1, 2) != '9') {
                            errorPhone = 'Vui lòng nhập đúng số điện thoại';
                          } else {
                            errorPhone = '';
                          }
                          //validation pass
                          final pass = txtPass.value.text;
                          if (pass.isEmpty) {
                            errorPass = 'Nhập mật khẩu';
                          } else if (pass.length < 6) {
                            errorPass = 'Mật khẩu tối thiểu 6 ký tự';
                          } else if (pass.length > 20) {
                            errorPass = 'Mật khẩu tối đa 20 ký tự';
                          } else {
                            errorPass = '';
                          }
                          //check error
                          if (errorPhone != '' || errorPass != '') {
                            return;
                          } else {}
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        color: AppColors.mainColor,
                        height: Dimensions.h40,
                        minWidth: Dimensions.w210,
                        child: Text(
                          'ĐĂNG NHẬP',
                          style: TextStyle(
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Quên mật khẩu?',
                        style: TextStyle(
                          fontSize: Dimensions.font15,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    const LoginWithGoogle(),
                    const LinkRegister(),
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
