import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:video_player/video_player.dart';
import 'package:zenan/common/models/product_model.dart';
import 'package:zenan/common/models/restaurant_model.dart';
import 'package:zenan/common/widgets/drag_page_widget.dart';
import 'package:zenan/common/widgets/no_data_screen_widget.dart';
import 'package:zenan/common/widgets/product_shimmer_widget.dart';
import 'package:zenan/common/widgets/product_widget.dart';
import 'package:zenan/features/home/widgets/theme1/restaurant_widget.dart';
import 'package:zenan/helper/responsive_helper.dart';
import 'package:zenan/util/dimensions.dart';
import 'package:zenan/common/widgets/web_restaurant_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class ProductViewWidget extends StatelessWidget {
//   final List<Product?>? products;
//   final List<Restaurant?>? restaurants;
//   final bool isRestaurant;
//   final EdgeInsetsGeometry padding;
//   final bool isScrollable;
//   final int shimmerLength;
//   final String? noDataText;
//   final bool isCampaign;
//   final bool inRestaurantPage;
//   final bool showTheme1Restaurant;
//   final bool? isWebRestaurant;
//   final bool? fromFavorite;
//   final bool? fromSearch;
//   const ProductViewWidget(
//       {super.key,
//       required this.restaurants,
//       required this.products,
//       required this.isRestaurant,
//       this.isScrollable = false,
//       this.shimmerLength = 20,
//       this.padding = const EdgeInsets.all(Dimensions.paddingSizeSmall),
//       this.noDataText,
//       this.isCampaign = false,
//       this.inRestaurantPage = false,
//       this.showTheme1Restaurant = false,
//       this.isWebRestaurant = false,
//       this.fromFavorite = false,
//       this.fromSearch = false});

//   @override
//   Widget build(BuildContext context) {
//     bool isNull = true;
//     int length = 0;
//     if (isRestaurant) {
//       isNull = restaurants == null;
//       if (!isNull) {
//         length = restaurants!.length;
//       }
//     } else {
//       isNull = products == null;
//       if (!isNull) {
//         length = products!.length;
//       }
//     }

//     return Column(children: [
//       !isNull
//           ? length > 0
//               ? GridView.builder(
//                   key: UniqueKey(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisSpacing: Dimensions.paddingSizeLarge,
//                     mainAxisSpacing:
//                         ResponsiveHelper.isDesktop(context) && !isWebRestaurant!
//                             ? Dimensions.paddingSizeLarge
//                             : isWebRestaurant!
//                                 ? Dimensions.paddingSizeLarge
//                                 : 0.01,
//                     //childAspectRatio: ResponsiveHelper.isDesktop(context) && !isWebRestaurant! ? 3 : isWebRestaurant! ? 1.5 : showTheme1Restaurant ? 1.9 : 3.3,
//                     mainAxisExtent:
//                         ResponsiveHelper.isDesktop(context) && !isWebRestaurant!
//                             ? 142
//                             : isWebRestaurant!
//                                 ? 280
//                                 : showTheme1Restaurant
//                                     ? 200
//                                     : 150,
//                     crossAxisCount:
//                         ResponsiveHelper.isMobile(context) && !isWebRestaurant!
//                             ? 1
//                             : isWebRestaurant!
//                                 ? 4
//                                 : 3,
//                   ),
//                   physics: isScrollable
//                       ? const BouncingScrollPhysics()
//                       : const NeverScrollableScrollPhysics(),
//                   shrinkWrap: isScrollable ? false : true,
//                   itemCount: length,
//                   padding: padding,
//                   itemBuilder: (context, index) {
//                     return showTheme1Restaurant
//                         ? RestaurantWidget(
//                             restaurant: restaurants![index],
//                             index: index,
//                             inStore: inRestaurantPage)
//                         : isWebRestaurant!
//                             ? WebRestaurantWidget(
//                                 restaurant: restaurants![index])
//                             : ProductWidget(
//                                 isRestaurant: isRestaurant,
//                                 product: isRestaurant ? null : products![index],
//                                 restaurant:
//                                     isRestaurant ? restaurants![index] : null,
//                                 index: index,
//                                 length: length,
//                                 isCampaign: isCampaign,
//                                 inRestaurant: inRestaurantPage,
//                               );
//                   },
//                 )
//               : NoDataScreen(
//                   isEmptyRestaurant: isRestaurant ? true : false,
//                   isEmptyWishlist: fromFavorite! ? true : false,
//                   isEmptySearchFood: fromSearch! ? true : false,
//                   title: noDataText ??
//                       (isRestaurant
//                           ? 'there_is_no_restaurant'.tr
//                           : 'there_is_no_food'.tr),
//                 )
//           : GridView.builder(
//               key: UniqueKey(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisSpacing: Dimensions.paddingSizeLarge,
//                 mainAxisSpacing: ResponsiveHelper.isDesktop(context)
//                     ? Dimensions.paddingSizeLarge
//                     : 0.01,
//                 //childAspectRatio: ResponsiveHelper.isDesktop(context) && !isWebRestaurant! ? 3 : isWebRestaurant! ? 1.5 : showTheme1Restaurant ? 1.9 : 3.3,
//                 mainAxisExtent:
//                     ResponsiveHelper.isDesktop(context) && !isWebRestaurant!
//                         ? 142
//                         : isWebRestaurant!
//                             ? 280
//                             : showTheme1Restaurant
//                                 ? 200
//                                 : 150,
//                 crossAxisCount:
//                     ResponsiveHelper.isMobile(context) && !isWebRestaurant!
//                         ? 1
//                         : isWebRestaurant!
//                             ? 4
//                             : 3,
//               ),
//               physics: isScrollable
//                   ? const BouncingScrollPhysics()
//                   : const NeverScrollableScrollPhysics(),
//               shrinkWrap: isScrollable ? false : true,
//               itemCount: shimmerLength,
//               padding: padding,
//               itemBuilder: (context, index) {
//                 return showTheme1Restaurant
//                     ? RestaurantShimmer(isEnable: isNull)
//                     : isWebRestaurant!
//                         ? const WebRestaurantShimmer()
//                         : ProductShimmer(
//                             isEnabled: isNull,
//                             isRestaurant: isRestaurant,
//                             hasDivider: index != shimmerLength - 1);
//               },
//             ),
//     ]);
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenan/util/dimensions.dart';
import 'package:zenan/common/widgets/product_shimmer_widget.dart';
import 'package:zenan/common/widgets/no_data_screen_widget.dart';

import 'dart:io';

import '../models/product_model.dart';
import 'product_detail_screen.dart';

class ProductViewWidget extends StatefulWidget {
  final List<Product?>? products;
  final List<Restaurant?>? restaurants;
  final bool isRestaurant;
  final EdgeInsetsGeometry padding;
  final bool isScrollable;
  final int shimmerLength;
  final String? noDataText;
  final String? restaurantImage;
  final bool isCampaign;
  final bool inRestaurantPage;
  final bool showTheme1Restaurant;
  final bool? isWebRestaurant;
  final bool? fromFavorite;
  final bool? fromSearch;
  final ChewieController? chewieController;
  final VideoPlayerController? videoController;
  ProductViewWidget({
    super.key,
    required this.restaurants,
    required this.products,
    required this.isRestaurant,
    this.isScrollable = false,
    this.shimmerLength = 20,
    this.padding = const EdgeInsets.all(0),
    this.noDataText,
    this.restaurantImage,
    this.isCampaign = false,
    this.inRestaurantPage = false,
    this.showTheme1Restaurant = false,
    this.isWebRestaurant = false,
    this.fromFavorite = false,
    this.fromSearch = false,
    this.chewieController,
    this.videoController,
  });

  @override
  State<ProductViewWidget> createState() => _ProductViewWidgetState();
}

class _ProductViewWidgetState extends State<ProductViewWidget> {
  @override
  Widget build(BuildContext context) {
    bool isNull = true;
    int length = 0;
    if (widget.isRestaurant) {
      isNull = widget.restaurants == null;
      if (!isNull) {
        length = widget.restaurants!.length;
      }
    } else {
      isNull = widget.products == null;
      if (!isNull) {
        length = widget.products!.length;
      }
    }

    return Column(
      children: [
        !isNull
            ? length > 0
                ? GridView.builder(
                    key: UniqueKey(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.isRestaurant
                          ? 2
                          : ResponsiveHelper.isMobile(context)
                              ? 3
                              : 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                    ),
                    physics: widget.isScrollable
                        ? const BouncingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: length,
                    padding: widget.padding,
                    itemBuilder: (context, index) {
                      return widget.isRestaurant
                          ? RestaurantWidget(
                              restaurant: widget.restaurants![index],
                              index: index,
                              inStore: widget.inRestaurantPage)
                          : Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: GestureDetector(
                                        onTap: () {
                                          print('BASDDDDDD');
                                          if (widget.chewieController != null) {
                                            widget.chewieController!.pause();
                                            widget.videoController!.pause();
                                          }

                                          // Navigator.push(
                                          //   context,
                                          //   PageRouteBuilder(
                                          //     pageBuilder: (context,
                                          //             animation,
                                          //             secondaryAnimation) =>
                                          //         ProductDetailScreen(
                                          //       product: widget
                                          //           .products![index]!,
                                          //       restaurantImage: widget
                                          //               .restaurantImage ??
                                          //           "",
                                          //       heroTag:
                                          //           'productImageHero${widget.products![index]!.id}',
                                          //       videoThumbnail:
                                          //           thumbnails![index]
                                          //               .toString(),
                                          //     ),
                                          //     transitionsBuilder: (context,
                                          //         animation,
                                          //         secondaryAnimation,
                                          //         child) {
                                          //       return CupertinoPageTransition(
                                          //         primaryRouteAnimation:
                                          //             animation,
                                          //         secondaryRouteAnimation:
                                          //             secondaryAnimation,
                                          //         child: child,
                                          //         linearTransition: true,
                                          //       );
                                          //     },
                                          //   ),
                                          // );
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  ProductDetailScreen(
                                                product:
                                                    widget.products![index]!,
                                                restaurantImage:
                                                    widget.restaurantImage ??
                                                        "",
                                                heroTag:
                                                    'productImageHero${widget.products![index]!.id}',
                                              ),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag:
                                              'productImageHero${widget.products![index]!.id}',
                                          child: Image(
                                            image: CachedNetworkImageProvider(
                                              widget.products![index]!
                                                  .imageFullUrl![0]
                                                  .toString(),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (widget.products![index]!.imageFullUrl!
                                        .length >
                                    1)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.black26),
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(FeatherIcons.copy,
                                          size: 18, color: Colors.white),
                                    ),
                                  )
                              ],
                            );
                    },
                  )
                : NoDataScreen(
                    title: widget.noDataText ?? 'No products available',
                  )
            : GridView.builder(
                key: UniqueKey(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveHelper.isMobile(context) ? 3 : 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                physics: widget.isScrollable
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.shimmerLength,
                padding: widget.padding,
                itemBuilder: (context, index) {
                  return ProductShimmer2(
                    isEnabled: isNull,
                    hasDivider: true,
                  );
                },
              ),
      ],
    );
  }
}
