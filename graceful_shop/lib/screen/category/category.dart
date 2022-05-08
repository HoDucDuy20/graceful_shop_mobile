import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/screen/category_detail/category_detail.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<CategoryModel> lstCategory = [
    CategoryModel(icon: 'assets/svg/shirt.svg', name: 'Áo'),
    CategoryModel(icon: 'assets/svg/trousers.svg', name: 'Quần'),
    CategoryModel(icon: 'assets/svg/dress.svg', name: 'Đầm'),
    CategoryModel(icon: 'assets/svg/big_skirt.svg', name: 'Váy'),
    CategoryModel(icon: 'assets/svg/shoes.svg', name: 'Giày'),
  ];

  @override
  Widget build(BuildContext context) {
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
              height: Dimensions.h100,
              width: Dimensions.screenWidth,
              decoration: BoxDecoration(color: AppColors.whiteColor),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: lstCategory.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryDetail()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Dimensions.w25),
                      padding: EdgeInsets.only(top: Dimensions.h10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            lstCategory[index].icon,
                            height: Dimensions.h50,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            lstCategory[index].name,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryModel {
  String icon;
  String name;
  CategoryModel({required this.icon, required this.name});
}
