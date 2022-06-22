import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/address_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/screens/address/add_address.dart';
import 'package:graceful_shop/screens/address/edit_address.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  AddressController addressController = Get.find<AddressController>();

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
              'Address'.tr,
              style: TextStyle(
                fontSize: Dimensions.font20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  color: AppColors.gray3Color,
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: Dimensions.h10),
                        shrinkWrap: true,
                        itemCount: addressController.addressList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Get.to(() => EditAddress(address: addressController.addressList[index]));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: Dimensions.h10),
                              color: AppColors.whiteColor,
                              child: ListTile(
                                title: Text(
                                  addressController.addressList[index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: Dimensions.font17,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackColor,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                subtitle: Text.rich(
                                  TextSpan(
                                    text: '${addressController.addressList[index].phoneNumber}\n',
                                    style: TextStyle(
                                      height: 1.7,
                                      fontSize: Dimensions.font14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black2Color,
                                      letterSpacing: 0.5,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: addressController.addressList[index].address,
                                        style:  TextStyle(
                                        // height: 1.7,
                                        fontSize: Dimensions.font14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black2Color,
                                      ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                trailing: Column(
                                  children: [
                                    Icon(
                                        Icons.location_on_outlined,
                                        color: AppColors.mainColor,
                                    ),
                                    if(addressController.addressList[index].isDefault)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Icon(
                                            Icons.check,
                                            color: AppColors.greenColor,
                                        ),
                                      ),                                
                                  ],
                                ),                            
                              ),
                            ),
                          );
                        },
                      ),
                      InkWell(
                        onTap: (){
                          Get.to(() => const AddAddress());
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: Dimensions.h10),
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
                          color: AppColors.whiteColor,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Text(
                              'AddNewAddress'.tr,
                              style: TextStyle(
                                wordSpacing: 1.5,
                                fontSize: Dimensions.font14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black2Color,
                              ),
                            ),
                            trailing: Icon(
                              Icons.add,
                              size: Dimensions.w25,
                              color: AppColors.grayColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
