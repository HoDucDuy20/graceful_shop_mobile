import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/screen/advertise_detail/advertise_detail.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class ImgSlide extends StatefulWidget {
  const ImgSlide({Key? key}) : super(key: key);

  @override
  State<ImgSlide> createState() => _ImgSlideState();
}

class _ImgSlideState extends State<ImgSlide> {
  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      width: Dimensions.width,
      // height: Dimensions.h250,
      initialPage: 0,
      indicatorColor: AppColors.mainColor,
      indicatorBackgroundColor: AppColors.grayColor,
      children: [
        InkWell(
          onTap: () {
            Get.to(() => const AdvertiseDetail());
          },
          child: Image.asset('assets/images/img_1.jpg', fit: BoxFit.cover),
        ),
        InkWell(
          onTap: () {
            Get.to(() => const AdvertiseDetail());
          },
          child: Image.asset('assets/images/img_2.jpg', fit: BoxFit.cover),
        ),
      ],
      onPageChanged: (value) {
        // print('Page changed: $value');
      },
      autoPlayInterval: null,
      isLoop: true,
    );
  }
}
