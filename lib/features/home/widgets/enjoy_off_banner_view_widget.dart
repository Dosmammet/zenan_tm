import 'package:zenan/features/splash/controllers/splash_controller.dart';
import 'package:zenan/helper/responsive_helper.dart';
import 'package:zenan/util/dimensions.dart';
import 'package:zenan/util/images.dart';
import 'package:zenan/common/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromotionalBannerViewWidget extends StatelessWidget {
  const PromotionalBannerViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Get.find<SplashController>().configModel!.bannerData != null
        ? Padding(
            padding: EdgeInsets.symmetric(
              vertical: ResponsiveHelper.isMobile(context)
                  ? Dimensions.paddingSizeDefault
                  : Dimensions.paddingSizeLarge,
              horizontal: !ResponsiveHelper.isDesktop(context)
                  ? Dimensions.paddingSizeDefault
                  : 0,
            ),
            child: SizedBox(
              height: ResponsiveHelper.isMobile(context) ? 70 : 122,
              width: Dimensions.webMaxWidth,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                child: CustomImageWidget(
                  placeholder: Images.placeholder,
                  image:
                      '${Get.find<SplashController>().configModel!.bannerData!.promotionalBannerImageFullUrl}',
                  fit: BoxFit.fitWidth,
                  width: ResponsiveHelper.isMobile(context) ? 70 : 122,
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
