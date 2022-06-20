import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/button.dart';

class PasswordEdit extends StatefulWidget {
  const PasswordEdit({Key? key}) : super(key: key);

  @override
  State<PasswordEdit> createState() => _PasswordEditState();
}

class _PasswordEditState extends State<PasswordEdit> {
  UserController userController = Get.find<UserController>();

  TextEditingController txtOldPass = TextEditingController();
  TextEditingController txtNewPass1 = TextEditingController();
  TextEditingController txtNewPass2 = TextEditingController();

  String errorOldPass = '';
  String errorNewPass1 = '';
  String errorNewPass2 = '';

  bool isHidenNew = true;

  changeHidenNewPass() {
    if (mounted) {
      setState(() {
        isHidenNew = !isHidenNew;
      });
    }
  }

  bool isHidenOld = true;

  changeHidenOldPass() {
    if (mounted) {
      setState(() {
        isHidenOld = !isHidenOld;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white3Color,
        foregroundColor: AppColors.mainColor,
        shadowColor: AppColors.whiteColor,
        elevation: 0.5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
                child: Icon(
                  Icons.chevron_left,
                  size: Dimensions.font30,
                  color: AppColors.black2Color,
                ),
              ),
            ),
            Text(
              'ChangeThePassword'.tr,
              style: TextStyle(
                fontSize: Dimensions.font20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Obx(() {
            return Container(
                padding: EdgeInsets.all(Dimensions.w15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    info('CurrentPassword'.tr),
                    textField(txtOldPass, 'EnterCurrentPassword'.tr, errorOldPass, isHidenOld, changeHidenOldPass),
                    info('ANewPassword'.tr),
                    textField(txtNewPass1, 'EnterNewPassword'.tr, errorNewPass1, isHidenNew, changeHidenNewPass),
                    info('InputPass2'.tr),
                    textField(txtNewPass2, 'ConfirmNewPassword'.tr, errorNewPass2, isHidenNew, changeHidenNewPass),
                    Container(
                      margin: EdgeInsets.all(Dimensions.w20),
                      alignment: Alignment.center,
                      child: ButtonAddCart(
                        isLoading: userController.isLoading.value,
                        title: 'Save'.tr,
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {});
                          //validation old pass
                          final oldPass = txtOldPass.value.text;
                          if (oldPass.isEmpty) {
                            errorOldPass = 'RequiredPass'.tr;
                          } else if (oldPass.length < 6) {
                            errorOldPass = 'RequiredPassMin'.tr;
                          } else if (oldPass.length > 20) {
                            errorOldPass = 'RequiredPassMax'.tr;
                          } else {
                            errorOldPass = '';
                          }
                          //validation new pass
                          final newPass1 = txtNewPass1.value.text;
                          if (newPass1.isEmpty) {
                            errorNewPass1 = 'RequiredPass'.tr;
                          } else if (newPass1.length < 6) {
                            errorNewPass1 = 'RequiredPassMin'.tr;
                          } else if (newPass1.length > 20) {
                            errorNewPass1 = 'RequiredPassMax'.tr;
                          } else {
                            errorNewPass1 = '';
                          }
                          //validation new pass compare
                          final newPass2 = txtNewPass2.value.text;
                          if (newPass2.isEmpty) {
                            errorNewPass2 = 'RequiredPass'.tr;
                          } else if (newPass2.length < 6) {
                            errorNewPass2 = 'RequiredPassMin'.tr;
                          } else if (newPass2.length > 20) {
                            errorNewPass2 = 'RequiredPassMax'.tr;
                          } else if (newPass2 != newPass1) {
                            errorNewPass2 = 'RequiredPass_Compare'.tr;
                          } else {
                            errorNewPass2 = '';
                          }
                          if (errorOldPass == '' && errorNewPass1 == '' && errorNewPass2 == '') {
                            userController.changePass(oldPass, newPass1);
                          }
                        },
                        color: AppColors.blueAccentColor,
                      ),
                    ),
                  ],
                ));
          }),
        ),
      ),
    );
  }

  Widget info(String infoNname) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.w20),
      child: Text.rich(
        TextSpan(
          text: '$infoNname: ',
          style: TextStyle(
            wordSpacing: 1.5,
            fontSize: Dimensions.font16,
            fontWeight: FontWeight.w500,
            color: AppColors.mainColor,
          ),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget textField(TextEditingController textEditingController, String hintText, String error, bool isHiden, VoidCallback f) {
    return TextField(
      obscureText: isHiden,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: error == '' ? null : error,
        suffix: InkWell(
          onTap: f,
          child: Icon(
            isHiden ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );
  }
}
