import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';
import 'package:graceful_shop/resources/widgets/icon_onTap.dart';

class SearchDetail extends StatefulWidget {
  String value;
  SearchDetail({Key? key, required this.value}) : super(key: key);

  @override
  State<SearchDetail> createState() => _SearchDetailState(value: value);
}

class _SearchDetailState extends State<SearchDetail> {
  _SearchDetailState({Key? key, required this.value});
  String value;

  ProductController productController = Get.find<ProductController>();

  TextEditingController txtSearch = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  double minValue = 0;
  double maxValue = 5000000;
  int divisionsValue = 50;

  int proType = -1;

  RangeValues _currentRangeValues = RangeValues(0, 0);

  int index = 0;

  int priceSort = 0;
  bool newSort = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void lienQuan(){

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Obx(() {
          return Scaffold(
            key: _scaffoldKey,
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
              title: SizedBox(
                height: Dimensions.hSearch2,
                child: TextField(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Get.back();
                  },
                  autofocus: false,
                  readOnly: true,
                  textAlignVertical: TextAlignVertical.bottom,
                  controller: txtSearch,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
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
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: Dimensions.w10),
                  child: IconOnTap1(
                    onPressed: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    icon: Icons.filter_alt_outlined,
                    size: Dimensions.font30,
                    color: AppColors.mainColor,
                    border: false,
                  ),
                ),
              ],
              bottom:  PreferredSize(
                preferredSize: const Size.fromHeight(35),
                child: Container(
                  color: AppColors.whiteColor,
                  height: 30.0,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {});
                          index = 0;
                          priceSort = 0;
                          newSort = false;
                          productController.resetSearch();
                          productController.searchProducts(value, proType == -1 ? null: proType, _currentRangeValues.start.round(), _currentRangeValues.end.round(), newSort, priceSort);
                        },
                        child: Container(
                          width: Dimensions.width / 3,
                          alignment: Alignment.center,
                          decoration: index == 0
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Concern'.tr,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black2Color,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {});
                          index = 1;
                          priceSort = 0;
                          newSort = true;
                          productController.resetSearch();
                          productController.searchProducts(value, proType == -1 ? null: proType, _currentRangeValues.start.round(), _currentRangeValues.end.round(), newSort, priceSort);
                        },
                        child: Container(
                          width: Dimensions.width / 3,
                          alignment: Alignment.center,
                          decoration: index == 1
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'New'.tr,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black2Color,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {});
                          index = 2;
                          if(priceSort == 1){
                            priceSort = 2;
                          }else{
                            priceSort = 1;
                          }
                          newSort = false;
                          productController.resetSearch();
                          productController.searchProducts(value, proType == -1 ? null: proType, _currentRangeValues.start.round(), _currentRangeValues.end.round(), newSort, priceSort);
                        },
                        child: Container(
                          width: Dimensions.width / 3,
                          alignment: Alignment.center,
                          decoration: index == 2
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Price'.tr,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black2Color,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              if(priceSort == 1)
                                Icon(
                                  Icons.arrow_upward_outlined,
                                  color: AppColors.black2Color,
                                ),
                              if(priceSort == 2)
                                Icon(
                                  Icons.arrow_downward_outlined ,
                                  color: AppColors.black2Color,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),   
            ),
            endDrawer: Drawer(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.h65),
                    child: ListView(
                      // Important: Remove any padding from the ListView.
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                          ),
                          child: Center(
                            child: Text(
                              'SearchFilters'.tr,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font17,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                                letterSpacing: 0.7,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: AppColors.gray2Color,
                          padding: EdgeInsets.all(Dimensions.w10),
                          child: Text(
                            'Price'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black2Color,
                              // letterSpacing: 0.7,
                            ),
                          ),
                        ), 
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Format.numPrice(_currentRangeValues.start.round()),
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontSize: Dimensions.font12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.red3Color,
                                  // letterSpacing: 0.7,
                                ),
                              ), 
                              Text(
                                'To'.tr,
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontSize: Dimensions.font12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blackColor,
                                  // letterSpacing: 0.7,
                                ),
                              ), 
                              Text(
                                Format.numPrice(_currentRangeValues.end.round()),
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontSize: Dimensions.font12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.red3Color,
                                  // letterSpacing: 0.7,
                                ),
                              ), 
                            ],
                          ),
                        ),
                        RangeSlider(
                          values: _currentRangeValues,
                          min: minValue,
                          max: maxValue,
                          activeColor: AppColors.yellowColor,
                          divisions: divisionsValue,
                          labels: RangeLabels(
                            _currentRangeValues.start.round().toString(),
                            _currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues = values;
                            });
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.w10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {});
                                       _currentRangeValues = RangeValues(_currentRangeValues.start.round() - (maxValue / divisionsValue) < minValue 
                                       ? minValue : _currentRangeValues.start.round() - (maxValue / divisionsValue), _currentRangeValues.end.round().toDouble());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.gray2Color,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.remove_outlined,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.w10),
                                  InkWell(
                                    onTap: () {
                                      setState(() {});
                                      _currentRangeValues = RangeValues(_currentRangeValues.start.round() + (maxValue / divisionsValue) > _currentRangeValues.end.round().toDouble() 
                                      ? _currentRangeValues.end.round().toDouble() : _currentRangeValues.start.round() + (maxValue / divisionsValue) > maxValue 
                                      ? maxValue : _currentRangeValues.start.round() + (maxValue / divisionsValue),  _currentRangeValues.end.round().toDouble());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.gray2Color,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add_outlined,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: (){
                                  setState(() {});
                                  _currentRangeValues = const RangeValues(0, 0);
                                }, 
                                child: Text(
                                  'Reset'.tr,
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    fontSize: Dimensions.font12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.mainColor,
                                    // letterSpacing: 0.7,
                                  ),
                                ), 
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {});
                                       _currentRangeValues = RangeValues(_currentRangeValues.start.round().toDouble(), 
                                       _currentRangeValues.end.round() - (maxValue / divisionsValue) < _currentRangeValues.start.round().toDouble() 
                                       ? _currentRangeValues.start.round().toDouble() : _currentRangeValues.end.round() - (maxValue / divisionsValue) < minValue 
                                       ? minValue : _currentRangeValues.end.round() - (maxValue / divisionsValue));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.gray2Color,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.remove_outlined,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.w10),
                                  InkWell(
                                    onTap: () {
                                      setState(() {});
                                      _currentRangeValues = RangeValues(_currentRangeValues.start.round().toDouble(), _currentRangeValues.end.round() + (maxValue / divisionsValue) > maxValue 
                                      ? maxValue : _currentRangeValues.end.round() + (maxValue / divisionsValue));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.gray2Color,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add_outlined,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: AppColors.gray2Color,
                          padding: EdgeInsets.all(Dimensions.w10),
                          child: Text(
                            'ProductType'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black2Color,
                              // letterSpacing: 0.7,
                            ),
                          ),
                        ), 
                        Container(
                          width: Dimensions.w10,
                          margin: EdgeInsets.only(top: Dimensions.h10),
                          color: AppColors.whiteColor,
                          child: ListTile(
                            title: Text(
                              'All'.tr,
                              maxLines: 3,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                fontSize: Dimensions.font15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                                letterSpacing: 0.7,
                              ),
                            ),  
                            trailing: InkWell(
                              onTap: (){
                                setState(() {});
                                proType = -1;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  proType == -1
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                  size: Dimensions.font20,  
                                  color: AppColors.greenColor,                                  
                                ),
                              ),
                            ),                       
                          ),       
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: Dimensions.h10),
                          shrinkWrap: true,
                          itemCount: productController.productTypeListSearch.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: Dimensions.w10,
                              margin: EdgeInsets.only(bottom: Dimensions.h10),
                              color: AppColors.whiteColor,
                              child: ListTile(
                                title: Text(
                                  productController.productTypeListSearch[index].productTypeName,
                                  maxLines: 3,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    fontSize: Dimensions.font15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackColor,
                                    letterSpacing: 0.7,
                                  ),
                                ),  
                                trailing: InkWell(
                                  onTap: (){
                                    setState(() {});
                                    proType = productController.productTypeListSearch[index].id;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      proType == productController.productTypeListSearch[index].id
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                      size: Dimensions.font20,  
                                      color: AppColors.greenColor,                                  
                                    ),
                                  ),
                                ),                       
                              ),       
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.h10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ButtonAddCart(
                        title: 'Apply'.tr, 
                        onPressed: (){
                          Get.back();
                          productController.resetSearch();
                          productController.searchProducts(value, proType == -1 ? null: proType, _currentRangeValues.start.round(), _currentRangeValues.end.round(), newSort, priceSort);
                        }, 
                        color: AppColors.orangeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.w10),
                child: Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GridViewProduct(
                        context,
                        productController.productListSearch,
                        productController.totalSearch.value,
                        true,
                        false,
                      ),
                      (productController.checkFullSearch.value == true || productController.productListSearch.isEmpty)
                          ? SizedBox(height: Dimensions.h40)
                          : productController.loading.value
                              ? Center(
                                  child: Image.asset(
                                    'assets/gif/loading_2_2.gif',
                                    height: Dimensions.h50,
                                  ),
                                )
                              : ButtonShowMore(
                                  onPressed: () {
                                    productController.loading.value = true;
                                    productController.searchProducts(value, proType == -1 ? null: proType, _currentRangeValues.start.round(), _currentRangeValues.end.round(), newSort, priceSort);
                                  },
                                ),
                    ],
                  );
                }),
              ),
            ),
          );
        }
      ),
    );
  }
}

