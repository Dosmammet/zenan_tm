import 'package:expandable_text/expandable_text.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:zenan/common/widgets/custom_favourite_widget.dart';
import 'package:zenan/features/restaurant/controllers/restaurant_controller.dart';
import 'package:zenan/features/address/domain/models/address_model.dart';
import 'package:zenan/common/models/restaurant_model.dart';
import 'package:zenan/features/favourite/controllers/favourite_controller.dart';
import 'package:zenan/features/review/domain/models/rate_review_model.dart';
import 'package:zenan/features/review/screens/rate_review_screen.dart';
import 'package:zenan/helper/price_converter.dart';
import 'package:zenan/helper/responsive_helper.dart';
import 'package:zenan/helper/route_helper.dart';
import 'package:zenan/util/app_constants.dart';
import 'package:zenan/util/dimensions.dart';
import 'package:zenan/util/images.dart';
import 'package:zenan/util/styles.dart';
import 'package:zenan/common/widgets/custom_image_widget.dart';
import 'package:zenan/common/widgets/custom_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class InfoViewWidget2 extends StatelessWidget {
  final Restaurant restaurant;
  final RestaurantController restController;

  const InfoViewWidget2({
    super.key,
    required this.restaurant,
    required this.restController,
  });

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 0.2),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Stack(children: [
                        CustomImageWidget(
                          image: '${restaurant.logoFullUrl}',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              restaurant.foodsCount.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Işler'.tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              restaurant.likesCount.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Halanyldy'.tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              restaurant.followersCount.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Yzarlaýjy'.tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                  // Column(children: [
                  //   GetBuilder<FavouriteController>(
                  //       builder: (favouriteController) {
                  //     bool isWished = favouriteController.wishRestIdList
                  //         .contains(restaurant.id);
                  //     return CustomFavouriteWidget(
                  //       isWished: isWished,
                  //       isRestaurant: true,
                  //       restaurant: restaurant,
                  //       size: 24 - (1 * 4),
                  //     );
                  //   }),
                  //   const SizedBox(height: Dimensions.paddingSizeSmall),
                  //   AppConstants.webHostedUrl.isNotEmpty
                  //       ? InkWell(
                  //           onTap: () {
                  //             if (isDesktop) {
                  //               // String? hostname = html.window.location.hostname;
                  //               // String protocol = html.window.location.protocol;
                  //               // String shareUrl = '$protocol//$hostname${restController.filteringUrl(restaurant.slug ?? '')}';
                  //               String shareUrl =
                  //                   '${AppConstants.webHostedUrl}${restController.filteringUrl(restaurant.slug ?? '')}';
                  //               Clipboard.setData(
                  //                   ClipboardData(text: shareUrl));
                  //               showCustomSnackBar('restaurant_url_copied'.tr,
                  //                   isError: false);
                  //             } else {
                  //               String shareUrl =
                  //                   '${AppConstants.webHostedUrl}${restController.filteringUrl(restaurant.slug ?? '')}';
                  //               Share.share(shareUrl);
                  //             }
                  //           },
                  //           child: Icon(
                  //             Icons.share,
                  //           ),
                  //         )
                  //       : const SizedBox(),
                  // ]),
                ]),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name!,
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyMedium!.color),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Fashion/ Nails',
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).primaryColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.getRestaurantReviewRoute(
                          restaurant.id, restaurant.name, restaurant));
                    },
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Icon(Icons.star,
                                color: Theme.of(context).primaryColor,
                                size: 14),
                            const SizedBox(
                                width: Dimensions.paddingSizeExtraSmall),
                            Text(
                              restaurant.avgRating!.toStringAsFixed(1),
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color),
                            ),
                          ]),
                          const SizedBox(
                              width: Dimensions.paddingSizeExtraSmall),
                          Text(' | '),
                          Text(
                            '${restaurant.ratingCount} + ${'ratings'.tr}',
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).primaryColor),
                          ),
                        ]),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(RouteHelper.getMapRoute(
                      AddressModel(
                        id: restaurant.id,
                        address: restaurant.address,
                        latitude: restaurant.latitude,
                        longitude: restaurant.longitude,
                        contactPersonNumber: '',
                        contactPersonName: '',
                        addressType: '',
                      ),
                      'restaurant',
                      restaurantName: restaurant.name,
                    )),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 14,
                          child: Image.asset(Images.restaurantLocationIcon,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          //restaurant.phone.toString(),
                          restaurant.address.toString(),
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: Theme.of(context).primaryColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (restaurant.phoneNumbers != null)
                    ListView.builder(
                      padding: EdgeInsets.only(),
                      shrinkWrap: true,
                      itemCount: restaurant.phoneNumbers!.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Icon(FeatherIcons.phone, size: 16),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              restaurant.phoneNumbers![index],
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color),
                            ),
                          ],
                        );
                      },
                    ),
                  SizedBox(
                    height: 8,
                  ),
                  ExpandableText(
                    restaurant.description ?? '',
                    expandText: 'show_more'.tr,
                    collapseText: '',
                    maxLines: 3,
                    linkColor: Colors.grey,
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).textTheme.bodyMedium!.color),
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}
