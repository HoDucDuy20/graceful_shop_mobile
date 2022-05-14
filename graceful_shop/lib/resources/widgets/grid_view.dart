// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:graceful_shop/object/product_object.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class GridViewCustom extends StatefulWidget {
  List<ProductObject> lstProduct;
  GridViewCustom({Key? key, required this.lstProduct}) : super(key: key);

  @override
  State<GridViewCustom> createState() =>
      _GridViewCustomState(lstProduct: lstProduct);
}

class _GridViewCustomState extends State<GridViewCustom> {
  List<ProductObject> lstProduct;
  _GridViewCustomState({required this.lstProduct});
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
          mainAxisExtent: Dimensions.hCard,
        ),
        itemCount: lstProduct.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            highlightColor: AppColors.whiteColor,
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(Dimensions.w10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray2Color,
                    spreadRadius: 0.5,
                    blurRadius: 2,
                    offset: const Offset(1.5, 2.5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Dimensions.h180,
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(Dimensions.w10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      image: DecorationImage(
                        image: AssetImage(lstProduct[index].img),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.h7),
                        margin: EdgeInsets.only(left: Dimensions.w5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.whiteColor,
                        ),
                        child: Icon(
                          Icons.favorite_outline,
                          size: Dimensions.font20,
                          color: AppColors.grayColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: Dimensions.h65,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
                    child: Text(
                      lstProduct[index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Dimensions.font16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black2Color,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lstProduct[0].price.toString(),
                          style: TextStyle(
                            fontSize: Dimensions.font15,
                            color: AppColors.black2Color,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: Dimensions.w5),
                              child: Icon(
                                Icons.favorite,
                                size: Dimensions.font17,
                                color: AppColors.redColor,
                              ),
                            ),
                            Text(
                              lstProduct[index].favorite.toString(),
                              style: TextStyle(
                                fontSize: Dimensions.font15,
                                color: AppColors.black2Color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
