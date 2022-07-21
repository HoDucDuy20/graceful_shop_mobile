import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/models/category.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';

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

  static const double endReachedThreshold = 200; // Khi chỉ còn cách phía dưới Grid 200dp thì sẽ load more
  late ScrollController scrollController;
  double scrollControllerOffset = 0.0;
  
  scrollListenner() {
    setState(() {});
    if (productController.checkFullSearch.value == true || productController.productListSearch.isEmpty) {
      return;
    }
    final thresholdReached = scrollController.position.extentAfter < endReachedThreshold; // Check xem đã đạt tới endReachedThreshold chưa
        
    if (thresholdReached) {
      // Load more!
      if(!productController.loading.value)
      {
        productController.loading.value = true;
        // switch (productController.tab.value) {
        //   case 0:
        //     productController.getPopularProducts();
        //     break;
        //   case 1:
        //     productController.getNewProducts();
        //     break;
        // }
        if(categoryIndex == -1){
          productController.getProductsOfAllType(category.id);
        }else{
          productController.getProductsOfType(category.productTypes[categoryIndex].id);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListenner);
  }

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
      body: Obx(() {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                backgroundColor: AppColors.whiteColor,
                pinned: true,
                title: Container(
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
                            productController.getProductsOfAllType(category.id);
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
                        itemCount: category.productTypes.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                productController.resetSearch();
                                productController.getProductsOfType(category.productTypes[index].id);
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
                                category.productTypes[index].productTypeName,
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
                )
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
                      child: GridViewProduct(
                        context,
                        productController.productListSearch,
                        productController.totalSearch.value,
                        false,
                        false,
                      ),
                    ),
                    // (productController.checkFullSearch.value == true || productController.productListSearch.isEmpty)
                    //     ? SizedBox(height: Dimensions.h40)
                    //     : productController.loading.value
                    //         ? Center(
                    //             child: Image.asset(
                    //               'assets/gif/loading_2_2.gif',
                    //               height: Dimensions.h50,
                    //             ),
                    //           )
                    //         : ButtonShowMore(
                    //             onPressed: () {
                    //               productController.loading.value = true;
                    //               productController.getNewProducts();
                    //             },
                    //           ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: productController.loading.value
                    ? Center(
                        child: Image.asset(
                          'assets/gif/loading_2_2.gif',
                          height: Dimensions.h50,
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          );
        }
      ),
    );
  }
}
