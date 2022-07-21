import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/category_controller.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';
import 'package:graceful_shop/screens/category_detail/category_detail.dart';
import 'package:graceful_shop/services/url.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  CategoryController categoryController = Get.find<CategoryController>();
  ProductController productController = Get.find<ProductController>();
  // int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();  
  }

  @override
  Widget build(BuildContext context) {
    // final orientation = MediaQuery.of(context).orientation;
    return Obx(() {
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
          body: Row(
            children: [
              LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: NavigationRail(
                          backgroundColor: AppColors.blueAccentSearchColor,
                          selectedIndex: categoryController.selectedIndex.value,
                          onDestinationSelected: (int index) {
                            setState(() {});
                            categoryController.selectedIndex.value = index;
                            productController.resetSearch();
                            productController.getProductsOfAllType2(categoryController.categoryList[index].id);
                            // print(categoryController.categoryList[index].id);
                          },
                          labelType: NavigationRailLabelType.selected,
                          destinations: [
                            for(int index = 0; index < categoryController.categoryList.length; index++)
                              NavigationRailDestination(
                                padding: EdgeInsets.zero,
                                icon: Container(
                                  width: Dimensions.w100,
                                  padding: EdgeInsets.all(Dimensions.w7),
                                  // color: AppColors.blueAccentSearchColor,
                                  child: Column(
                                    children: [
                                      SvgPicture.network(
                                        formaterImg(categoryController.categoryList[index].icon),                   
                                        width: Dimensions.w50,
                                        color: AppColors.black2Color,
                                      ),
                                      Text(
                                        categoryController.categoryList[index].categoryName,
                                        style: TextStyle(
                                          color: AppColors.black2Color,
                                          fontSize: Dimensions.font17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                selectedIcon: Container(
                                  width: Dimensions.w100,
                                  padding: EdgeInsets.all(Dimensions.w7),
                                  color: AppColors.white3Color,
                                  child: Column(
                                    children: [
                                      SvgPicture.network(
                                        formaterImg(categoryController.categoryList[index].icon),                   
                                        width: Dimensions.w50,
                                        color: AppColors.mainColor,
                                      ),
                                      Text(
                                        categoryController.categoryList[index].categoryName,
                                        style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: Dimensions.font17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                label: const SizedBox(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const VerticalDivider(thickness: 1, width: 1),
              // This is the main content.
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    categoryController.selectedIndex.value = 0;
                    productController.resetSearch();
                    categoryController.getCategores(); 
                  },
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
                    children: [
                      Container(
                        color: AppColors.gray3Color,
                        child: ListTile(
                          onTap: () {
                            productController.resetSearch();
                            productController.getProductsOfAllType(categoryController.categoryList[categoryController.selectedIndex.value].id);
                            Get.to(CategoryDetail(category: categoryController.categoryList[categoryController.selectedIndex.value]), duration: const Duration(milliseconds: 700), transition: Transition.fadeIn);
                          },
                          title: Text(
                            categoryController.categoryList[categoryController.selectedIndex.value].categoryName,
                            style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: Dimensions.font17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      ),
                      GridViewProduct2(
                        context,
                        productController.productAllType,
                        productController.totalProductAllType.value,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}



// Column(
//   children: [
//     Container(
//       // height: Dimensions.hLstCategory,
//       width: (orientation == Orientation.portrait) ? Dimensions.width * 1.5 : Dimensions.height * 1.5,
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.gray2Color,
//             spreadRadius: 0.5,
//             blurRadius: 2,
//             offset: const Offset(0, 0.5),
//           ),
//         ],
//       ),
//       child: Obx(() {
//         return ListView.builder(
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           itemCount: categoryController.categoryList.length,
//           itemBuilder: ((context, index) {
//             return InkWell(
//               onTap: () {
//                 productController.resetSearch();
//                 productController.getProductsOfAllType(categoryController.categoryList[index].id);
//                 Get.to(() => CategoryDetail(category: categoryController.categoryList[index]));
//               },
//               child: Container(
//                 margin: EdgeInsets.only(left: Dimensions.w25),
//                 padding: EdgeInsets.only(top: Dimensions.h10),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SvgPicture.network(
//                       formaterImg(categoryController.categoryList[index].icon),                   
//                       height: Dimensions.h50,
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       categoryController.categoryList[index].categoryName,
//                       style: TextStyle(
//                         fontSize: Dimensions.font17,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }),
//         );
//       }),
//     ),
//   ],
// ),


