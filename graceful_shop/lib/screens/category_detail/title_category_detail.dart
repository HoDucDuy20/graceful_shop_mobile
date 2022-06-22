// ignore_for_file: must_be_immutable, no_logic_in_create_state, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/models/product_type.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class TitleCategoryDetail extends StatefulWidget {
  TitleCategoryDetail({Key? key, required this.categoryIndex, required this.categoryId, required this.lstProductType}) : super(key: key);
  int categoryIndex;
  int categoryId;
  List<ProductType> lstProductType;

  @override
  State<TitleCategoryDetail> createState() => _TitleCategoryDetailState(categoryIndex: categoryIndex, categoryId: categoryId, lstProductType: lstProductType);
}

class _TitleCategoryDetailState extends State<TitleCategoryDetail> {
  _TitleCategoryDetailState({Key? key, required this.categoryIndex, required this.categoryId, required this.lstProductType});
  ProductController productController = Get.find<ProductController>();
  int categoryIndex;
  int categoryId;
  List<ProductType> lstProductType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.h40,
      width: Dimensions.width,
      alignment: Alignment.centerLeft,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                productController.resetSearch();
                productController.getProductsOfAllType(categoryId);
                categoryIndex = -1;
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
              child: Text(
                'All'.tr,
                style: TextStyle(
                  fontSize: Dimensions.font17,
                  fontWeight: categoryIndex == -1 ? FontWeight.w600 : FontWeight.w500,
                  color: categoryIndex == -1 ? AppColors.mainColor : AppColors.grayColor,
                ),
              ),
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: false,
            itemCount: lstProductType.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    productController.resetSearch();
                    productController.getProductsOfType(lstProductType[index].id);
                    categoryIndex = index;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: AppColors.grayColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Text(
                    lstProductType[index].productTypeName,
                    style: TextStyle(
                      fontSize: Dimensions.font16,
                      fontWeight: categoryIndex == index ? FontWeight.w600 : FontWeight.w500,
                      color: categoryIndex == index ? AppColors.mainColor : AppColors.grayColor,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
