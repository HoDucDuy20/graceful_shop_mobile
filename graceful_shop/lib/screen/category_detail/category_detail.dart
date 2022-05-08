import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';

class CategoryDetail extends StatefulWidget {
  const CategoryDetail({Key? key}) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  List<String> lstCategory = ['Áo', 'Sơ mi', 'T-Shirt', 'Hai dây', 'Áo thun'];
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
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
                child: Icon(
                  Icons.chevron_left,
                  size: Dimensions.font40,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            Text(
              'Áo',
              style: TextStyle(
                fontSize: Dimensions.font25,
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
            title: Container(
              height: Dimensions.h40,
              width: Dimensions.screenWidth,
              alignment: Alignment.centerLeft,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
                      child: Text(
                        'All'.tr,
                        style: TextStyle(
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mainColor),
                      ),
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: lstCategory.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimensions.w15),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: AppColors.grayColor,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Text(
                            lstCategory[index],
                            style: TextStyle(
                                fontSize: Dimensions.font20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
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
                Container(
                    height: 900, decoration: BoxDecoration(color: Colors.amber))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
