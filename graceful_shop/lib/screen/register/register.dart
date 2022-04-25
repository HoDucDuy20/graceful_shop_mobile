import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graceful_shop/screen/login/login_with_google.dart';
import 'package:graceful_shop/screen/register/link_login.dart';
import 'package:graceful_shop/screen/register/proviso.dart';
import 'package:graceful_shop/utils/colors.dart';
import 'package:graceful_shop/utils/dimensions.dart';
import 'package:graceful_shop/widgets/header_login_register.dart';

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
                title: 'Đăng ký',
                subTitle: 'Vui lòng điền đầy đủ thông tin để đăng ký',
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
                    TextField(
                      obscureText: isHiden,
                      controller: txtPassCompare,
                      decoration: InputDecoration(
                        label: Text(
                          'Nhập lại mật khẩu',
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
                          'Họ và tên',
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
                      child: MaterialButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          {
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
                            //validation pass compare
                            final passCompare = txtPassCompare.value.text;
                            if (passCompare.isEmpty) {
                              errorPassCompare = 'Nhập mật khẩu';
                            } else if (passCompare.length < 6) {
                              errorPassCompare = 'Mật khẩu tối thiểu 6 ký tự';
                            } else if (passCompare.length > 20) {
                              errorPassCompare = 'Mật khẩu tối đa 20 ký tự';
                            } else if (passCompare != pass) {
                              errorPassCompare = 'Mật khẩu không khớp';
                            } else {
                              errorPassCompare = '';
                            }
                            //validation name
                            final fullName = txtFullName.value.text;
                            if (fullName.isEmpty) {
                              errorFullName = 'Họ và tên không được để trống';
                            } else if (fullName.length > 40) {
                              errorFullName = 'Họ tên tối đa 40 ký tự';
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
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        color: AppColors.mainColor,
                        height: Dimensions.h40,
                        minWidth: Dimensions.w210,
                        child: Text(
                          'ĐĂNG KÝ',
                          style: TextStyle(
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                        ),
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
