import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/favorite_controller.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screens/favorite/no_product.dart';
import 'package:graceful_shop/screens/favorite/not_logged_in.dart';
import 'package:graceful_shop/screens/product_detail/product_detail.dart';
import 'package:graceful_shop/services/url.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);
  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  UserController userController = Get.find<UserController>();
  FavoriteController favoriteController = Get.find<FavoriteController>();

  @override
  void initState() {
    super.initState();
    favoriteController.getProductLike();
  }

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
          'Favorite'.tr,
          style: TextStyle(
            fontSize: Dimensions.font25,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: lstAction1,
      ),
      body: Obx(() {
          return SingleChildScrollView(
            child: userController.token == ''
                ? const NotLoggedIn()
                : Column(
                    children: [
                      if (favoriteController.producFavoritetList.isEmpty)
                        const NoProduct()
                      else
                        Obx(() {
                          return MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: favoriteController.producFavoritetList.isEmpty
                                ? Center(
                                    child: Image.asset(
                                      'assets/gif/loading_5.gif',
                                      height: Dimensions.w250,
                                      width: Dimensions.w250,
                                    ),
                                  )
                                : GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                                      mainAxisExtent: Dimensions.hCard,
                                    ),
                                    itemCount: favoriteController.producFavoritetList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        highlightColor: AppColors.whiteColor,
                                        onTap: () {
                                          Get.to(ProductDetail(product: favoriteController.producFavoritetList[index]), duration: const Duration(milliseconds: 400), transition: Transition.zoom);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(Dimensions.w10),
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
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
                                                height: Dimensions.h275,
                                                alignment: Alignment.bottomRight,
                                                padding: EdgeInsets.all(Dimensions.w10),
                                                decoration: BoxDecoration(
                                                  borderRadius:const BorderRadius.all(Radius.circular(20.0)),
                                                  image: DecorationImage(
                                                    image: FadeInImage.assetNetwork(
                                                      placeholder: 'assets/gif/loading_2.gif',
                                                      image: formaterImg(favoriteController.producFavoritetList[index].pictures[0].pictureValue),
                                                    ).image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (userController.token.value == '') {
                                                      showLogIn();
                                                      return;
                                                    }
                                                    favoriteController.likeFavorite(index);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(Dimensions.h7),
                                                    margin: EdgeInsets.only(left: Dimensions.w5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:BorderRadius.circular(100),
                                                      color: AppColors.whiteColor,
                                                    ),
                                                    child: favoriteController.producFavoritetList[index].isLike
                                                      ? Icon(
                                                          Icons.favorite,
                                                          size: Dimensions.font20,
                                                          color: AppColors.redColor,
                                                        )
                                                      : Icon(
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
                                                  favoriteController.producFavoritetList[index].productName,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: Dimensions.font16,
                                                    fontWeight: FontWeight.w500,
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
                                                      Format.numPrice(favoriteController.producFavoritetList[index].price),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: Dimensions.font15,
                                                        color: AppColors.mainColor,
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
                                                          favoriteController.producFavoritetList[index].numLike.toString(),
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
                        }),
                    ],
                  ),
          );
        }
      ),
    );
  }
}
