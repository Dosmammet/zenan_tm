import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:zenan/features/home/widgets/arrow_icon_button_widget.dart';
import 'package:zenan/features/home/widgets/restaurants_card_widget.dart';
import 'package:zenan/features/restaurant/controllers/restaurant_controller.dart';
import 'package:zenan/helper/responsive_helper.dart';
import 'package:zenan/helper/route_helper.dart';
import 'package:zenan/util/app_constants.dart';
import 'package:zenan/util/dimensions.dart';
import 'package:zenan/util/styles.dart';
import 'package:zenan/features/restaurant/screens/restaurant_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../restaurant/screens/all_restaurant_screen.dart';

class NewOnStackFoodViewWidget extends StatelessWidget {
  final bool isLatest;
  const NewOnStackFoodViewWidget({super.key, required this.isLatest});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantController>(builder: (restController) {
      return (restController.latestRestaurantList != null &&
              restController.latestRestaurantList!.isEmpty)
          ? const SizedBox()
          : Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ResponsiveHelper.isMobile(context)
                      ? Dimensions.paddingSizeDefault
                      : Dimensions.paddingSizeLarge),
              child: Container(
                width: Dimensions.webMaxWidth,
                height: 210,
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${'new_on'.tr} ${AppConstants.appName}',
                                style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                    fontWeight: FontWeight.w600)),
                            ArrowIconButtonWidget(onTap: () {
                              String _page = isLatest ? 'latest' : '';
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: AllRestaurantScreen(
                                  isPopular: _page == 'popular',
                                  isRecentlyViewed: _page == 'recently_viewed',
                                  isOrderAgain: _page == 'order_again',
                                ),
                              );
                            }
                                // Get.toNamed(
                                //         RouteHelper.getAllRestaurantRoute(
                                //             isLatest ? 'latest' : '')),
                                ),
                          ]),
                    ),
                    restController.latestRestaurantList != null
                        ? SizedBox(
                            height: 130,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                  right: Dimensions.paddingSizeDefault),
                              itemCount:
                                  restController.latestRestaurantList!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.paddingSizeDefault),
                                  child: InkWell(
                                    onTap: () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: RestaurantScreen(
                                          restaurant: restController
                                              .latestRestaurantList![index],
                                          //slug: Get.parameters['slug'] ?? '',
                                        ),
                                      );
                                      // Get.toNamed(
                                      //   RouteHelper.getRestaurantRoute(
                                      //       restController
                                      //           .latestRestaurantList![index]
                                      //           .id),
                                      //   arguments: RestaurantScreen(
                                      //       restaurant: restController
                                      //           .latestRestaurantList![index]),
                                      // );
                                    },
                                    child: RestaurantsCardWidget(
                                      isNewOnStackFood: true,
                                      restaurant: restController
                                          .latestRestaurantList![index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : const RestaurantsCardShimmer(isNewOnStackFood: false),
                  ],
                ),
              ),
            );
    });
  }
}
