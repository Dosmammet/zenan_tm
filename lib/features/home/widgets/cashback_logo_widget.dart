import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenan/common/widgets/custom_asset_image_widget.dart';
import 'package:zenan/helper/responsive_helper.dart';
import 'package:zenan/util/dimensions.dart';
import 'package:zenan/util/images.dart';
import 'package:zenan/util/styles.dart';

class CashBackLogoWidget extends StatelessWidget {
  const CashBackLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const CustomAssetImageWidget(Images.cashBack, height: 80, width: 80),
      Positioned(
        top: 20,
        left: 20,
        child: Text('cash_back'.tr,
            style: robotoBold.copyWith(
                color: Colors.white,
                fontSize: ResponsiveHelper.isDesktop(context)
                    ? Dimensions.fontSizeSmall
                    : Dimensions.fontSizeDefault)),
      ),
    ]);
  }
}
