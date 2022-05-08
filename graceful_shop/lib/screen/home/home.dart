import 'package:flutter/material.dart';
import 'package:graceful_shop/screen/home/grid_product.dart';
import 'package:graceful_shop/screen/home/menu_top.dart';
import 'package:graceful_shop/screen/home/slide_advertise.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            flexibleSpace: const FlexibleSpaceBar(
              background: ImgSlide(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(
                    top: Dimensions.h10,
                  ),
                ),
                GridProduct(
                  titleName: 'Dành riêng cho bạn',
                ),
                GridProduct(
                  titleName: 'Hàng mới',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}