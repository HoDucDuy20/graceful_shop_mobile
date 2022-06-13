import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
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
  ProductController productController = Get.find<ProductController>();

  String value;
  _SearchDetailState({Key? key, required this.value});

  TextEditingController txtSearch = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _buildRow(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets,
      ),
    );
  }

  final _totalDots = 1000000;
  int _currentPosition = 500000;
  int _min = 50000;

  double _validPosition(double position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1;
    return position;
  }

  void _updatePosition(double position) {
    setState(() => _currentPosition = _validPosition(position).toInt());
  }

  String getPrettyCurrPosition() {
    return (_currentPosition + 1).toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
        ),
        endDrawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              _buildRow([
                Text(
                  'Current position ${getPrettyCurrPosition()} / $_totalDots',
                ),
              ]),
              _buildRow([
                SizedBox(
                  width: 300.0,
                  child: Slider(
                    value: _currentPosition.toDouble(),
                    max: (_totalDots - 1).toDouble(),
                    min: (_min - 1).toDouble(),
                    onChanged: _updatePosition,
                    label: 'getPrettyCurrPosition()',
                  ),
                ),
              ]),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
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
                  (productController.checkFullSearch.value == true ||
                          productController.productListSearch.value.length == 0)
                      ? SizedBox(
                          height: Dimensions.h40,
                        )
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
                                productController.searchProducts(value);
                              },
                            ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
