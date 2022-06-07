import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/category_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/screens/category_detail/category_detail.dart';
import 'package:graceful_shop/services/url.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: Dimensions.w25,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white3Color,
        foregroundColor: AppColors.mainColor,
        shadowColor: AppColors.whiteColor,
        elevation: 0.5,
        title: Text(
          'Category'.tr,
          style: TextStyle(
            fontSize: Dimensions.font25,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: lstAction1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Dimensions.hLstCategory,
              width: (orientation == Orientation.portrait)
                  ? Dimensions.width * 1.5
                  : Dimensions.height * 1.5,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray2Color,
                    spreadRadius: 0.5,
                    blurRadius: 2,
                    offset: const Offset(0, 0.5),
                  ),
                ],
              ),
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categoryController.categoryList.value.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => CategoryDetail(category: categoryController.categoryList.value[index]));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.w25),
                        padding: EdgeInsets.only(top: Dimensions.h10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.network(
                              formaterImg(categoryController.categoryList.value[index].icon),                   
                              height: Dimensions.h50,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              categoryController.categoryList.value[index].categoryName,
                              style: TextStyle(
                                fontSize: Dimensions.font17,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}