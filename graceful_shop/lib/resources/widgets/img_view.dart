import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/models/picture.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/services/url.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImgView extends StatefulWidget {
  ImgView({Key? key, required this.lstImg, required this.i}) : super(key: key);
  List<Picture> lstImg;
  int i;
  @override
  State<ImgView> createState() => _ImgViewState(lstImg: lstImg, i: i);
}

class _ImgViewState extends State<ImgView> {
  _ImgViewState({Key? key, required this.lstImg, required this.i});
  List<Picture> lstImg;
  PageController pageController = PageController();
  int i;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            itemCount: lstImg.length,
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: FadeInImage.assetNetwork(
                  placeholder: 'assets/gif/loader.gif',
                  image: formaterImg(lstImg[index].pictureValue),
                  fit: BoxFit.cover,
                ).image,
                initialScale: PhotoViewComputedScale.contained * 1,
                maxScale: PhotoViewComputedScale.contained * 2.4,
                minScale: PhotoViewComputedScale.contained * 0.8,
                heroAttributes: PhotoViewHeroAttributes(tag: lstImg[index].id),
              );
            },
            loadingBuilder: (context, event) => Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: const CircularProgressIndicator(value: 0.4),
              ),
            ),
            backgroundDecoration: BoxDecoration(color: AppColors.black2Color),
            pageController: pageController,
            onPageChanged: (index) {
              setState(() {
                i = index;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.h40, horizontal: Dimensions.w15),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.clear_rounded,
                size: Dimensions.font30,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.h12),
              child: Text(
                (i + 1).toString() + '/' + lstImg.length.toString(),
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
