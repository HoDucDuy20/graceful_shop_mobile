import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/feedback_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  FeedbackController feedbackController = Get.put(FeedbackController());
  TextEditingController txtContent = TextEditingController();
  var errorFeedback = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                Text(
                  'Feedback'.tr,
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.zero,
                  child: feedbackController.isLoading.value
                      ? Image.asset(
                          'assets/gif/loading_3_2.gif',
                          height: Dimensions.h40,
                        )
                      : MaterialButton(
                          onPressed: () async {
                            if(txtContent.text == ''){
                              errorFeedback.value = 'ContentNotEmpty'.tr;
                            }else{
                              FocusScope.of(context).requestFocus(FocusNode());
                              feedbackController.sendFeedback(txtContent.text);
                            }                            
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(35.0),
                              bottomLeft: Radius.circular(35.0)
                            ),
                          ),
                          color: AppColors.mainColor,
                          height: Dimensions.h40,
                          child: Text(
                            'Send'.tr,
                            style: TextStyle(
                              fontSize: Dimensions.font17,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: AppColors.gray3Color,
                  child: TextField(
                    controller: txtContent,
                    autofocus: true,
                    maxLines: 10,
                    style: TextStyle(
                      fontSize: Dimensions.font17,
                      color: AppColors.black2Color,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hoverColor: AppColors.black2Color,
                      hintText: '${'MoreContent'.tr}...',
                      errorText: errorFeedback.value == '' ? null : errorFeedback.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
