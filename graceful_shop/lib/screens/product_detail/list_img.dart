import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/models/picture.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/img_view.dart';
import 'package:graceful_shop/services/url.dart';

class ListImg extends StatelessWidget {
  ListImg({Key? key, required this.lstImg}) : super(key: key);
  List<Picture> lstImg;
  final CarouselController _controller = CarouselController();
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
              ),
              items: lstImg.map((img) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => ImgView(lstImg: lstImg, i: i.value),
                        );
                      },
                      child: SizedBox(
                        width: (orientation == Orientation.portrait)
                            ? Dimensions.width
                            : Dimensions.height,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/gif/loading_2.gif',
                          image: formaterImg(img.pictureValue),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: Dimensions.h10, horizontal: Dimensions.w15),
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: SizedBox(
                  width: Dimensions.w50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${i.value + 1}/${lstImg.length}',
                        style: TextStyle(
                          color: AppColors.black2Color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
