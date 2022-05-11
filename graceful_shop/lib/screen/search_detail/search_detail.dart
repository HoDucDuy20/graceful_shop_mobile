import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class SearchDetail extends StatefulWidget {
  String value;
  SearchDetail({Key? key, required this.value}) : super(key: key);

  @override
  State<SearchDetail> createState() => _SearchDetailState(value: value);
}

class _SearchDetailState extends State<SearchDetail> {
  String value;
  _SearchDetailState({Key? key, required this.value});
  TextEditingController txtSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white3Color,
          shadowColor: AppColors.whiteColor,
          foregroundColor: AppColors.grayColor,
          elevation: 5,
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              Get.back();
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
          title: Padding(
            padding:
                EdgeInsets.only(left: Dimensions.w20, right: Dimensions.w10),
            child: SizedBox(
              height: Dimensions.h40,
              child: TextField(
                autofocus: false,
                readOnly: true,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Get.back();
                },
                controller: txtSearch,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: Dimensions.h5),
                  filled: true,
                  fillColor: AppColors.gray2Color,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.grayColor,
                  ),
                  hintText: value,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.h10, horizontal: Dimensions.w20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
