import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/address_controller.dart';
import 'package:graceful_shop/models/address.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/button.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  AddressController addressController = Get.find<AddressController>();

  Address address = Address(
    id: -1, 
    name: '', 
    address: '', 
    phoneNumber: '', 
    isDefault: false,
  );

  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtAddress = TextEditingController();

  String errorPhone = '';
  String errorName = '';
  String errorAddress = '';

  void checkDefault(){
    setState(() {});
    if(addressController.addressList.isEmpty){
      address.isDefault = true;
    }
  }

  @override
  void initState() {
    super.initState();
    checkDefault();
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
                'NewAddress'.tr,
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
                  color: AppColors.gray3Color,
                  padding: EdgeInsets.only(top: Dimensions.h5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textField(txtName, 'InputName'.tr, errorName),
                      textField(txtPhone, 'Phone'.tr, errorPhone),
                      textField(txtAddress , 'Address'.tr, errorAddress),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: Dimensions.h5),
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
                          color: AppColors.whiteColor,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Text(
                              'FixedAddress'.tr,
                              style: TextStyle(
                                wordSpacing: 1.5,
                                fontSize: Dimensions.font14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black2Color,
                              ),
                            ),
                            trailing: Switch(  
                              onChanged: (value){
                                if(addressController.addressList.isNotEmpty)
                                {
                                  setState(() {});
                                  address.isDefault = !address.isDefault;
                                } else
                                {
                                  Get.snackbar(
                                    'IsNotPossible'.tr,
                                    'IsYourFirstAddress'.tr,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }                             
                              },  
                              value: address.isDefault,  
                              activeColor: AppColors.greenColor,  
                              activeTrackColor: const Color.fromARGB(255, 144, 214, 64),  
                              // inactiveThumbColor: Color.fromARGB(255, 26, 23, 23),  
                              // inactiveTrackColor: Colors.orange,  
                            ) ,
                          ),
                        ),
                      Container(
                        color: AppColors.whiteColor,
                        margin: EdgeInsets.only(top: Dimensions.h5),
                        padding: EdgeInsets.symmetric(vertical: Dimensions.h10),
                        alignment: Alignment.center,
                        child: ButtonAddCart(
                          isLoading: addressController.isLoading.value,
                          title: 'Save'.tr,
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
                            //validation name
                            final name = txtName.value.text;
                            if (name.isEmpty) {
                              errorName = 'RequiredName'.tr;
                            } else if (name.length > 40) {
                              errorName = 'RequiredNameMax'.tr;
                            } else {
                              errorName = '';
                            }
                            //validation address
                            final addressName = txtName.value.text;
                            if (addressName.isEmpty) {
                              errorAddress = 'RequiredAddress'.tr;
                            } else {
                              errorAddress = '';
                            }

                            if (errorPhone == '' && errorName == '' && errorAddress == '') {
                                address.name = txtName.text; 
                                address.address = txtAddress.text;
                                address.phoneNumber = txtPhone.text;
                              addressController.addAddress(address);
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

  Widget textField(TextEditingController textEditingController, String hintText, String error) {
    return Container(
      color: AppColors.whiteColor,
      margin: EdgeInsets.symmetric(vertical: Dimensions.h5),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide.none,
          //   // borderRadius: BorderRadius.circular(25.0),
          // ),
          // enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide.none,
          //   // borderRadius: BorderRadius.circular(25.0),
          // ),
          label: Text(
            hintText, 
            style: TextStyle(
              // wordSpacing: 1.5,
              fontSize: Dimensions.font14,
              fontWeight: FontWeight.w400,
              color: AppColors.black2Color,
            ),
          ),
          // hintText: hintText,
          errorText: error == '' ? null : error,
        ),
      ),
    );
  }
}
