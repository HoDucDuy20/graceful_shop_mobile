import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/resources/widgets/icon_ontap.dart';
import 'package:graceful_shop/services/url.dart';
import 'package:image_picker/image_picker.dart';

class PersonalEdit extends StatefulWidget {
  const PersonalEdit({Key? key}) : super(key: key);

  @override
  State<PersonalEdit> createState() => _PersonalEditState();
}

class _PersonalEditState extends State<PersonalEdit> {
  UserController userController = Get.find<UserController>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDateOfBirth = TextEditingController();
  String dateOfBirth = '';
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  String errorName = '';
  String errorEmail = '';
  File? image;

  int sexVal = 0;
  final List<Map> sexData = [
    {'value': 0, 'display': 'Male'.tr},
    {'value': 1, 'display': 'Female'.tr}
  ];

  @override
  void initState() {
    super.initState();
    txtName.text = userController.user.value.fullName;
    dateOfBirth = userController.user.value.dateOfBirth;
    txtDateOfBirth.text = Format.date(dateOfBirth);
    txtEmail.text = userController.user.value.email;
    txtAddress.text = userController.user.value.address;
    sexVal = userController.user.value.sex;
  }

  void saveChange() {
    userController.user.value.fullName = txtName.text;
    userController.user.value.sex = sexVal;
    userController.user.value.sexName = sexVal < 0 ? '' : sexData[sexVal]['display'];
    userController.user.value.dateOfBirth = dateOfBirth;
    userController.user.value.email = txtEmail.text;
    userController.user.value.address = txtAddress.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Edit'.tr,
              style: TextStyle(
                fontSize: Dimensions.font20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(Dimensions.w15),
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: Dimensions.h10),
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: Dimensions.w100,
                          backgroundColor: AppColors.gray2Color,
                          backgroundImage: image != null
                              ? FileImage(File(image!.path))
                              : FadeInImage.assetNetwork(
                                  placeholder: 'assets/gif/loading_2.gif',
                                  image: formaterImg(userController.user.value.avatar),
                                ).image,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 15,
                          child: IconOnTap1(
                            onPressed: () {
                              showModalBottomSheet(context: context, builder: (context) => buttonSheet());
                            },
                            icon: Icons.camera_alt,
                            size: Dimensions.w35,
                            color: AppColors.black2Color,
                            border: true,
                          ),
                        )
                      ],
                    ),
                  ),
                  title('PersonalPageInfo'.tr),
                  info('InputName'.tr),
                  textField(txtName, errorName, false),
                  info('DateOfBirth'.tr),
                  textFieldDate(),
                  info('Sex'.tr),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < 2; i++)
                        Row(
                          children: [
                            Radio(
                              value: sexVal,
                              groupValue: sexData[i]['value'],
                              onChanged: (value) {
                                setState(() {});
                                sexVal = i;
                              },
                            ),
                            Text(
                              sexData[i]['display'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black2Color,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  title('AccountInformation'.tr),
                  if(userController.user.value.typeLogin == 0)
                    info('Phone'.tr),
                  if(userController.user.value.typeLogin == 0)
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grayColor)),
                        border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainColor)),
                        hintText: userController.user.value.phone,
                      ),
                    ),
                  info('Email'.tr),
                  textField(txtEmail, errorEmail, true),
                  // info('Address'.tr),
                  // textField(txtAddress, ''),
                  Container(
                    margin: EdgeInsets.all(Dimensions.w20),
                    alignment: Alignment.center,
                    child: ButtonAddCart(
                      isLoading: userController.isLoading.value,
                      title: 'Save'.tr,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {});
                        if (txtName.text.isEmpty) {
                          errorName = 'RequiredName'.tr;
                          return;
                        } else if (txtName.text.length > 40) {
                          errorName = 'RequiredNameMax'.tr;
                          return;
                        } else {
                          errorName = '';
                        }
                        
                        if (txtEmail.value.text.isEmpty) {
                          errorEmail = 'RequiredEmail'.tr;
                          return;
                        } else if (!txtEmail.value.text.contains("@")) {
                          errorEmail = 'CorrectEmail'.tr;
                          return;
                        } else {
                          errorEmail = '';
                        }
                        saveChange();
                        userController.updateProfile(image);
                      },
                      color: AppColors.blueAccentColor,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.h10),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: Dimensions.font17,
          fontWeight: FontWeight.w600,
          color: AppColors.black2Color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget info(String infoNname) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.w10),
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

  Widget textField(TextEditingController textEditingController, String error, bool disable) {
    return TextField(
      readOnly: disable,
      controller: textEditingController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColor),
        ),
        // hintText: textEditingController.value.text,
        errorText: error == '' ? null : error,
      ),
    );
  }

  Widget textFieldDate() {
    return TextField(
      readOnly: true,
      controller: txtDateOfBirth,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grayColor),
        ),
        // errorText: error == '' ? null : error,
      ),
      onTap: () {
        DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(1900, 1, 1),
            maxTime: DateTime.now(),
            onChanged: (date) {}, onConfirm: (date) {
          setState(() {
            dateOfBirth = date.toString();
            txtDateOfBirth.text = Format.date(date.toString());
          });
        }, currentTime: DateTime.now(), locale: LocaleType.vi);
      },
    );
  }

  Widget buttonSheet() {
    return SizedBox(
      height: Dimensions.h200,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: Dimensions.h20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: Dimensions.w10),
              child: Text(
                'ChooseYourPhoto'.tr,
                style: TextStyle(
                  wordSpacing: 1.5,
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black2Color,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.w10),
                      child: Text(
                        'Camera'.tr,
                        style: TextStyle(
                          wordSpacing: 1.5,
                          fontSize: Dimensions.font17,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      icon: Icon(
                        Icons.camera,
                        size: Dimensions.font35,
                        color: AppColors.blueColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.w10),
                      child: Text(
                        'Library'.tr,
                        style: TextStyle(
                          wordSpacing: 1.5,
                          fontSize: Dimensions.font17,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      icon: Icon(
                        Icons.image,
                        size: Dimensions.font35,
                        color: AppColors.greenColor,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future getImage(ImageSource source) async {
    Get.back();
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      // print(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      Get.snackbar(
        'FailedAction'.tr,
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
