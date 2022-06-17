import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/screens/home/grid_product_featured.dart';
import 'package:graceful_shop/screens/home/grid_product_new.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
          Obx(
            () {
              return SliverList(
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
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget tabBarText(String title) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: Dimensions.font17,
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
          } else {
            productController.getNewProducts();
          }
        }
      },
      child: Container(
        width: Dimensions.width / 2,
        alignment: Alignment.center,
        decoration: productController.tab.value == index
            ? BoxDecoration(
                border: Border.all(
                  color: AppColors.blueAccentColor,
                  width: 1.5,
                ),
                color: AppColors.blueAccentSearchColor,
              )
            : null,
        child: tabBarText(title),
      ),
    );
  }
}
