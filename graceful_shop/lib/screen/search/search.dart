import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/screen/search_detail/search_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController txtSearch = TextEditingController();
  List<String>? searchHistory = [];

  _loadList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistory = prefs.getStringList('searchHistory');
      searchHistory ??= [];
    });
  }

  _setListData(String key, List<String> value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setStringList(key, value);
  }

  _addItem(String item) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      int index = searchHistory!.indexOf(item);
      if (index != -1) {
        searchHistory!.removeAt(index);
      }
      searchHistory!.add(item);
    });
    _setListData('searchHistory', searchHistory!);
  }

  _deleteItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistory!.removeAt(index);
    });
    _setListData('searchHistory', searchHistory!);
  }

  _deleteAllItem() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistory!.clear();
    });
    _setListData('searchHistory', searchHistory!);
  }

  @override
  void initState() {
    super.initState();
    _loadList();
  }

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
          title: Padding(
            padding: EdgeInsets.only(left: Dimensions.w20),
            child: SizedBox(
              height: Dimensions.h40,
              child: TextField(
                autofocus: true,
                controller: txtSearch,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  if (txtSearch.text != '') {
                    _addItem(txtSearch.text);
                    Get.to(() => SearchDetail(value: value));
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: Dimensions.h5),
                  filled: true,
                  fillColor: AppColors.gray2Color,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.grayColor,
                  ),
                  hintText: 'Search'.tr,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: txtSearch.clear,
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: AppColors.grayColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Cancel'.tr,
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: Dimensions.font17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.h10, horizontal: Dimensions.w20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  minVerticalPadding: 0,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'SearchHistory'.tr,
                    style: TextStyle(
                      fontSize: Dimensions.font17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                    ),
                  ),
                  trailing: searchHistory!.isEmpty
                      ? null
                      : InkWell(
                          onTap: () {
                            _deleteAllItem();
                          },
                          child: Text(
                            'DeleteAll'.tr,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: Dimensions.w7),
                  child: Wrap(
                    children: [
                      if (searchHistory!.isEmpty)
                        Container(
                          padding: EdgeInsets.only(top: Dimensions.h12),
                          alignment: Alignment.center,
                          child: Text(
                            'NoHistory'.tr,
                            softWrap: true,
                            style: TextStyle(fontSize: Dimensions.font16),
                          ),
                        )
                      else
                        for (int i = 0; i < searchHistory!.length; i++)
                          InkWell(
                            onTap: () {
                              txtSearch.text = searchHistory![i];
                              Get.to(
                                  () => SearchDetail(value: searchHistory![i]));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: Dimensions.h7, left: Dimensions.w7),
                              child: Chip(
                                backgroundColor:
                                    AppColors.blueAccentSearchColor,
                                onDeleted: () {
                                  _deleteItem(i);
                                },
                                label: Text(
                                  searchHistory![i],
                                  style: TextStyle(
                                    fontSize: Dimensions.font16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
