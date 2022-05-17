// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/objects/product_object.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';

class GridProduct extends StatefulWidget {
  String titleName;
  List<ProductObject> lstProduct;
  GridProduct({Key? key, required this.titleName, required this.lstProduct})
      : super(key: key);

  @override
  State<GridProduct> createState() =>
      _GridProductState(titleName: titleName, lstProduct: lstProduct);
}

class _GridProductState extends State<GridProduct> {
  String titleName;
  List<ProductObject> lstProduct;
  _GridProductState({required this.titleName, required this.lstProduct});
  List<String> t = [
    'rộng gợi cảm Áo cổ rộng gợi cảm Áo cổ rộng gợi cảmrộng gợi cảm Áo cổ rộng gợi cảm Áo cổ rộng gợi cảm',
    'Áo cổ rộng gợi cảm',
  ];
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Column(
      children: [
        InkWell(
          highlightColor: AppColors.blueAccentSearchColor,
          onTap: () {},
          child: ListTile(
            // tileColor: Colors.blueGrey,
            title: Text(
              titleName,
              style: TextStyle(
                  fontSize: Dimensions.font20, fontWeight: FontWeight.w600),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: Dimensions.font40,
            ),
          ),
        ),
        GridViewCustom(
          lstProduct: lstProduct,
        ),
        InkWell(
          highlightColor: AppColors.white3Color,
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(Dimensions.w15),
            padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
              color: AppColors.blueAccentSearchColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SeeMore'.tr,
                  style: TextStyle(
                    fontSize: Dimensions.font17,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainColor,
                  ),
                ),
                SizedBox(
                  width: Dimensions.w5,
                ),
                Icon(
                  Icons.expand_more,
                  color: AppColors.mainColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
