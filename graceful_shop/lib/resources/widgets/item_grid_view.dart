import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/favorite_controller.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/resources/widgets/draw_triangle_shape.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/services/url.dart';

UserController userController = Get.find<UserController>();
FavoriteController favoriteController = Get.find<FavoriteController>();

class ItemGridView extends StatefulWidget {
  ItemGridView({Key? key, required this.product, required this.index, this.isSearch = false, this.isFavorite = false}) : super(key: key);
  Product product;
  int index;
  bool isSearch;
  bool isFavorite;

  @override
  State<ItemGridView> createState() => _ItemGridViewState(product: product, index: index, isSearch: isSearch, isFavorite: isFavorite);
}

class _ItemGridViewState extends State<ItemGridView> {
  _ItemGridViewState({Key? key, required this.product, required this.index, required this.isSearch, required this.isFavorite});
  Product product;
  int index;
  bool isSearch;
  bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Dimensions.h275,
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(Dimensions.w10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
                image: DecorationImage(
                  image: FadeInImage.assetNetwork(
                    placeholder: 'assets/gif/loading_2.gif',
                    image: formaterImg(product.pictures[0].pictureValue),
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
                  if (isFavorite) {
                    favoriteController.likeFavorite(index);
                  } else if (isSearch) {
                    favoriteController.likeSearch(index);
                  } else {
                    favoriteController.like(index);
                  }
                  setState(() {
                    product.isLike = !product.isLike;
                    if (product.isLike) {
                      product.numLike++;
                    } else {
                      product.numLike--;
                    }
                  });
                  print('object');
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.h7),
                  margin: EdgeInsets.only(left: Dimensions.w5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.whiteColor,
                  ),
                  child: product.isLike
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
                product.productName,
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
                    Format.numPrice(product.price),
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
                        product.numLike.toString(),
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
        // Container(
        //   height: Dimensions.h275,
        //   alignment: Alignment.center,
        //   padding: EdgeInsets.all(Dimensions.w10),
        //   decoration: BoxDecoration(
        //     borderRadius: const BorderRadius.all(
        //       Radius.circular(20.0),
        //     ),
        //     color: AppColors.white2Color,
        //   ),
        //   child: Container(
        //     width: 100,
        //     decoration: BoxDecoration(
        //       borderRadius: const BorderRadius.all(
        //         Radius.circular(100.0),
        //       ),
        //       color: AppColors.grayColor,
        //     ),
        //     child: Text('Hết hàng'),
        //   ),
        // ),
        if(product.quantityStatus == 0)
          Align(
            alignment: Alignment.topRight,
            child: CustomPaint(
              size: Size(Dimensions.w50, Dimensions.w50),
              painter: DrawTriangleShape2(),
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.w65, bottom: Dimensions.w15, right: Dimensions.w7, top: Dimensions.w7),
                child: Text(
                  'OutOfStock'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.font15,
                    color: AppColors.orangeColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}


class ItemGridView2 extends StatefulWidget {
  ItemGridView2({Key? key, required this.product, required this.index}) : super(key: key);
  Product product;
  int index;

  @override
  State<ItemGridView2> createState() => _ItemGridView2State(product: product, index: index);
}

class _ItemGridView2State extends State<ItemGridView2> {
  _ItemGridView2State({Key? key, required this.product, required this.index});
  Product product;
  int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Dimensions.h150,
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(Dimensions.w10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
                image: DecorationImage(
                  image: FadeInImage.assetNetwork(
                    placeholder: 'assets/gif/loading_2.gif',
                    image: formaterImg(product.pictures[0].pictureValue),
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
                  favoriteController.likeCategory(index);
                  setState(() {
                    product.isLike = !product.isLike;
                    if (product.isLike) {
                      product.numLike++;
                    } else {
                      product.numLike--;
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.h7),
                  margin: EdgeInsets.only(left: Dimensions.w5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.whiteColor,
                  ),
                  child: product.isLike
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
                product.productName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Dimensions.font14,
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
                    Format.numPrice(product.price),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Dimensions.font13,
                      color: AppColors.mainColor,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: Dimensions.w5),
                        child: Icon(
                          Icons.favorite,
                          size: Dimensions.font14,
                          color: AppColors.redColor,
                        ),
                      ),
                      Text(
                        product.numLike.toString(),
                        style: TextStyle(
                          fontSize: Dimensions.font13,
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
        if(product.quantityStatus == 0)
          Align(
            alignment: Alignment.topRight,
            child: CustomPaint(
              size: Size(Dimensions.w50, Dimensions.w50),
              painter: DrawTriangleShape2(),
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.w65, bottom: Dimensions.w15, right: Dimensions.w7, top: Dimensions.w7),
                child: Text(
                  'OutOfStock'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.font15,
                    color: AppColors.orangeColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}