import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/slide_ads_controller.dart';
import 'package:graceful_shop/models/slide_ads.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';
import 'package:graceful_shop/services/url.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class AdvertiseDetail extends StatefulWidget {
  AdvertiseDetail({Key? key, required this.slideAdsDetail}) : super(key: key);
  SlideAds slideAdsDetail;

  @override
  State<AdvertiseDetail> createState() => _AdvertiseDetailState(slideAdsDetail: slideAdsDetail);
}

class _AdvertiseDetailState extends State<AdvertiseDetail> {
  _AdvertiseDetailState({required this.slideAdsDetail});
  SlideAds slideAdsDetail;
  SlideAdsController slideAdsController = Get.find<SlideAdsController>();

  void _launchUrl(String url) async {
    Uri _url = Uri.parse(url);
    // print(_url);
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  int total = 1;

  void setTotal(){
    setState(() {});
    total = 0;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 900), setTotal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Dimensions.h250,
                padding: EdgeInsets.only(left: Dimensions.w20, right: Dimensions.w20, top: Dimensions.h25),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FadeInImage.assetNetwork(
                      placeholder: 'assets/gif/loading_2.gif',
                      image: formaterImg(slideAdsDetail.picture),
                    ).image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100.0),
                        ),
                        color: AppColors.whiteColor,
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        size: Dimensions.font30,
                        color: AppColors.black2Color,
                      ),
                    ),
                  ),
                  // trailing: InkWell(
                  //   onTap: () {},
                  //   child: Container(
                  //     padding: EdgeInsets.all(Dimensions.w5),
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                  //       color: AppColors.whiteColor,
                  //     ),
                  //     child: Icon(
                  //       Icons.share_rounded,
                  //       size: Dimensions.font20,
                  //       color: AppColors.black2Color,
                  //     ),
                  //   ),
                  // ),
                ),
              ),
              Html(
                data: slideAdsDetail.description,
                onLinkTap: ( String? url,  RenderContext context, Map<String, String> attributes, dom.Element? element) {
                  _launchUrl(url!);
                },
              ),
              Container(
                padding: EdgeInsets.only(bottom: Dimensions.h10),
                child: GridViewProduct( context, productController.productListSearch, total, true, false),
              ),
            ],
          ),
        );
      }),
    );
  }
}
