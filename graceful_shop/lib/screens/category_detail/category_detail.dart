import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/models/category.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';
import 'package:graceful_shop/screens/category_detail/title_category_detail.dart';

class CategoryDetail extends StatefulWidget {
  CategoryDetail({Key? key, required this.category}) : super(key: key);
  Category category;

  @override
  State<CategoryDetail> createState() => _CategoryDetailState(category: category);
}

class _CategoryDetailState extends State<CategoryDetail> {
  _CategoryDetailState({required this.category});
  int categoryIndex = -1;
  Category category;

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
              category.categoryName,
              style: TextStyle(
                fontSize: Dimensions.font20,
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
              categoryId: category.id,
              lstProductType: category.productTypes,
            ),
          ),
          Obx(() {
            return SliverList(
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
                    child: GridViewProduct(
                      context,
                      productController.productListSearch,
                      productController.totalSearch.value,
                      false,
                      false,
                    ),
                  ),
                  (productController.checkFull.value == true || productController.productListSearch.isEmpty)
                      ? SizedBox(height: Dimensions.h40)
                      : productController.loading.value
                          ? Center(
                              child: Image.asset(
                                'assets/gif/loading_2_2.gif',
                                height: Dimensions.h50,
                              ),
                            )
                          : ButtonShowMore(
                              onPressed: () {
                                productController.loading.value = true;
                                productController.getNewProducts();
                              },
                            ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
