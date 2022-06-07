// ignore_for_file: must_be_immutable, no_logic_in_create_state, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/models/product_type.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class TitleCategoryDetail extends StatefulWidget {
  int categoryIndex;
  List<ProductType> lstProductType;
  TitleCategoryDetail(
      {Key? key, required this.categoryIndex, required this.lstProductType})
      : super(key: key);

  @override
  State<TitleCategoryDetail> createState() => _TitleCategoryDetailState(
      categoryIndex: categoryIndex, lstProductType: lstProductType);
}

class _TitleCategoryDetailState extends State<TitleCategoryDetail> {
  int categoryIndex;
  List<ProductType> lstProductType;
  _TitleCategoryDetailState(
      {Key? key, required this.categoryIndex, required this.lstProductType});
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
                  fontWeight:
                      categoryIndex == -1 ? FontWeight.w600 : FontWeight.w500,
                  color: categoryIndex == -1
                      ? AppColors.mainColor
                      : AppColors.grayColor,
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
                      fontWeight: categoryIndex == index
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: categoryIndex == index
                          ? AppColors.mainColor
                          : AppColors.grayColor,
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
