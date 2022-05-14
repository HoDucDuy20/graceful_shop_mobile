import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/object/product_object.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';
import 'package:graceful_shop/screen/category_detail/title_category_detail.dart';

class CategoryDetail extends StatefulWidget {
  const CategoryDetail({Key? key}) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  int categoryIndex = -1;
  List<String> lstCategory = ['Áo', 'Sơ mi', 'T-Shirt', 'Hai dây', 'Áo thun'];
  List<ProductObject> lstProduct = [
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
  ];
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
                  size: Dimensions.font40,
                  color: AppColors.black2Color,
                ),
              ),
            ),
            Text(
              'Áo',
              style: TextStyle(
                fontSize: Dimensions.font25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: lstAction1,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            backgroundColor: AppColors.whiteColor,
            pinned: true,
            title: TitleCategoryDetail(
              categoryIndex: categoryIndex,
              lstCategory: lstCategory,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.h10),
                  decoration: BoxDecoration(
                    color: AppColors.white3Color,
                    border: Border(
                      top: BorderSide(
                        color: AppColors.gray2Color,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: Dimensions.h10),
                  child: GridViewCustom(lstProduct: lstProduct),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
