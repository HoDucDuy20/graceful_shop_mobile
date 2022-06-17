import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/screens/search/search.dart';

class MenuTop extends StatelessWidget {
  const MenuTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: Dimensions.h7),
      leading: SvgPicture.asset(
        'assets/svg/logo.svg',
        height: Dimensions.hSearch2,
      ),
      title: InkWell(
        highlightColor: AppColors.noneColor,
        splashColor: AppColors.noneColor,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Get.to(() => const Search());
        },
        child: Container(
          height: Dimensions.hSearch1,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: AppColors.blueAccentSearchColor,
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: Dimensions.font25,
              ),
              SizedBox(width: Dimensions.w7),
              Text(
                'Search'.tr,
                style: TextStyle(fontSize: Dimensions.font16),
              ),
            ],
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Action_Cart(true),
          Action_Message(true),
        ],
      ),
    );
  }
}


// SizedBox(
//         height: Dimensions.hSearch1,
//         child: TextField(
//           autofocus: false,
//           readOnly: true,
//           textInputAction: TextInputAction.search,
//           onTap: () {
//             FocusScope.of(context).requestFocus(FocusNode());
//             Get.to(() => const Search());
//           },
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.all(0),
//             filled: true,
//             fillColor: AppColors.blueAccentSearchColor,
//             prefixIcon: const Icon(Icons.search),
//             label: Text(
//               'Search'.tr,
//               style: TextStyle(fontSize: Dimensions.font16),
//             ),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(25.0),
//             ),
//           ),
//         ),
//       ),