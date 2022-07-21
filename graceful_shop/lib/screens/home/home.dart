import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/controllers/slide_ads_controller.dart';
import 'package:graceful_shop/screens/home/grid_product_featured.dart';
import 'package:graceful_shop/screens/home/grid_product_new.dart';
import 'package:graceful_shop/screens/home/grid_product_selling.dart';
import 'package:graceful_shop/screens/home/menu_top.dart';
import 'package:graceful_shop/screens/home/slide_advertise.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  ProductController productController = Get.find<ProductController>();
  SlideAdsController slideAdsController = Get.find<SlideAdsController>();
  static const double endReachedThreshold = 1; // Khi chỉ còn cách phía dưới Grid 200dp thì sẽ load more
  late ScrollController scrollController;
  double scrollControllerOffset = 0.0;
  
  scrollListenner() {
    setState(() {});
    if (productController.checkFull.value == true || productController.productList.isEmpty) {
      return;
    }
    final thresholdReached = scrollController.position.extentAfter < endReachedThreshold; // Check xem đã đạt tới endReachedThreshold chưa
        
    if (thresholdReached) {
      // Load more!
      if(!productController.loading.value){
        productController.loading.value = true;
        switch (productController.tab.value) {
          case 0:
            productController.getPopularProducts();
            break;
          case 1:
            productController.getNewProducts();
            break;
          case 2:
            productController.getSellingProducts();
            break;
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
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () async {
            productController.tab.value = productController.tab.value;
            slideAdsController.getSlideAds();
            productController.reset();
            if (productController.tab.value == 0) {
              productController.getPopularProducts();
            } else if (productController.tab.value == 1) {
              productController.getNewProducts();
            } else {
              productController.getSellingProducts();
            }
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: false,
                title: const MenuTop(),
                expandedHeight: Dimensions.h250,
                backgroundColor: AppColors.whiteColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: ImgSlide(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      width: Dimensions.width,
                      height: Dimensions.h40,
                      // padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.gray2Color,
                            width: 3.5,
                          ),
                          bottom: BorderSide(
                            color: AppColors.gray2Color,
                            width: 3.5,
                          ),
                        ),
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          tab('Featured'.tr, 0),
                          tab('New'.tr, 1),
                          tab('Selling'.tr, 2),
                        ],
                      ),
                    ),
                    IndexedStack(
                      index: productController.tab.value,
                      children: <Widget>[
                        Visibility(
                          maintainState: true,
                          visible: productController.tab.value == 0,
                          child: const GridProductFeatured(),
                        ),
                        Visibility(
                          maintainState: true,
                          visible: productController.tab.value == 1,
                          child: GridProductNew(),
                        ),
                        Visibility(
                          maintainState: true,
                          visible: productController.tab.value == 2,
                          child: GridProductSelling(),
                        ),
                      ],
                    ),
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
          ),
        );
      }),
    );
  }

  Widget tabBarText(String title) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: Dimensions.font16,
        fontWeight: FontWeight.w500,
        color: AppColors.black2Color,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget tab(String title, int index) {
    return InkWell(
      onTap: () {
        if (productController.tab.value != index) {
          productController.tab.value = index;
          productController.reset();
          if (index == 0) {
            productController.getPopularProducts();
          } else if (index == 1) {
            productController.getNewProducts();
          } else {
            productController.getSellingProducts();
          }
        }
      },
      child: Container(
        width: Dimensions.width / 3,
        alignment: Alignment.center,
        decoration: productController.tab.value == index
            ? BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: AppColors.gray2Color,
                    width: 1.5,
                  ),
                  bottom: BorderSide( 
                    color: AppColors.blueAccentColor,
                    width: 1.5,
                  ),
                  top: BorderSide( 
                    color: AppColors.blueAccentColor,
                    width: 1.5,
                  ),
                ),
                color: AppColors.blueAccentSearchColor,
              )
            : BoxDecoration(
                border: Border(
                  right: BorderSide( 
                    color: AppColors.gray2Color,
                    width: 1.5,
                  ),
                ),
                color: AppColors.whiteColor,
              ),
        child: tabBarText(title),
      ),
    );
  }
}
