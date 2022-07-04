import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/controllers/slide_ads_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/screens/advertise_detail/advertise_detail.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/services/url.dart';

class ImgSlide extends StatelessWidget {
  ImgSlide({Key? key}) : super(key: key);
  final CarouselController _controller = CarouselController();
  SlideAdsController slideAdsController = Get.find<SlideAdsController>();
  ProductController productController = Get.find<ProductController>();
  RxInt i = 0.obs;
  
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Obx(
      () {
        return Stack(
          children: [
            CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                height: (orientation == Orientation.portrait) ? Dimensions.height : Dimensions.width,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {
                  i.value = index;
                },
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 900),
                autoPlayCurve: Curves.easeOut,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: slideAdsController.slideAdsList.value.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        productController.getSlideAdsDetail(i.id);
                        Get.to(AdvertiseDetail(slideAdsDetail: i), duration: const Duration(milliseconds: 700), transition: Transition.fadeIn);
                      },
                      child: SizedBox(
                        width: (orientation == Orientation.portrait) ? Dimensions.width : Dimensions.height,
                        child: Image(
                          image: FadeInImage.assetNetwork(
                            placeholder: 'assets/gif/loading_2.gif',
                            image: formaterImg(i.picture),
                          ).image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            if(slideAdsController.slideAdsList.isNotEmpty)
              Align(
                alignment: Alignment.bottomCenter,
                child: DotsIndicator(
                  dotsCount: slideAdsController.slideAdsList.isEmpty ? 1 : slideAdsController.slideAdsList.length,
                  position: i.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: AppColors.mainColor,
                    size: Size.square(Dimensions.w7),
                    activeSize: Size.square(Dimensions.w10),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
