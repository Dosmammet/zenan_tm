import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zenan/common/models/product_model.dart';
import 'package:zenan/common/models/restaurant_model.dart';
import 'package:zenan/common/widgets/footer_view_widget.dart';
import 'package:zenan/common/widgets/no_data_screen_widget.dart';
import 'package:zenan/common/widgets/product_shimmer_widget.dart';
import 'package:zenan/common/widgets/product_view_widget.dart';
import 'package:zenan/common/widgets/product_view_widget_pinterest.dart';
import 'package:zenan/common/widgets/product_widget.dart';
import 'package:zenan/features/home/widgets/theme1/restaurant_widget.dart';
import 'package:zenan/helper/responsive_helper.dart';
import 'package:zenan/theme/colors.dart';
import 'package:zenan/util/dimensions.dart';
import 'package:zenan/common/widgets/web_restaurant_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/favourite/controllers/favourite_controller.dart';
import '../../features/favourite/widgets/pinterest_grid.dart';
import '../../features/restaurant/controllers/restaurant_controller.dart';
import '../../features/restaurant/screens/restaurant_screen.dart';
import '../../helper/route_helper.dart';
import 'custom_favourite_widget.dart';
import 'paginated_list_view_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final String restaurantImage;
  final String heroTag;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.restaurantImage,
    this.heroTag = '',
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _showPlayPauseIcon = false;
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();

    _initDataCall();
    if (widget.product.videoCount! > 0) {
      _videoPlayerController =
          VideoPlayerController.network(widget.product.videoFullUrl![0]);
      _videoPlayerController.initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            aspectRatio: _videoPlayerController.value.aspectRatio,
            showControls: false,
            autoPlay: true,
            customControls: _CustomProgressBar(
                videoPlayerController: _videoPlayerController),
            looping: true,
          );
        });
      });
    }
  }

  bool _isZoomed = false;
  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
  }
  // void _togglePlayPause() {
  //   if (_videoPlayerController.value.isPlaying) {
  //     _videoPlayerController.pause();
  //   } else {
  //     _videoPlayerController.play();
  //   }
  //   setState(() {}); // Update UI to reflect play/pause state
  // }

  void _togglePlayPause() {
    setState(() {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
      } else {
        _videoPlayerController.play();
      }
      _showPlayPauseIcon = true;
    });

    // Hide the icon after 1 second
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _showPlayPauseIcon = false;
        });
      }
    });
  }

  void _checkSwipeBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  final ScrollController scrollController = ScrollController();
  final ScrollController scrollController2 = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _transformationController.dispose();
    scrollController.dispose();
    scrollController2.dispose();
  }

  double _dragOffset = 0.0;

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    // Check if at the top of the scroll view
    if (scrollController2.position.pixels <= 0) {
      if (details.primaryDelta! > 0) {
        // Only update if dragging down (positive delta)
        setState(() {
          _dragOffset += details.primaryDelta!;
        });
      }
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    // Only pop if the drag offset exceeds the threshold
    if (_dragOffset > 50 && scrollController2.position.pixels <= 0) {
      Navigator.pop(context);
    } else {
      // Reset drag offset if threshold is not met
      setState(() {
        _dragOffset = 0.0;
      });
    }
  }

  Future<void> _initDataCall() async {
    // if (Get.find<RestaurantController>().isSearching) {
    //   Get.find<RestaurantController>().changeSearchStatus(isUpdate: false);
    // }
    // await Get.find<RestaurantController>().getRestaurantDetails(
    //     Restaurant(id: widget.restaurant!.id),
    //     slug: widget.slug);
    // if (Get.find<CategoryController>().categoryList == null) {
    //   Get.find<CategoryController>().getCategoryList(true);
    // }
    // Get.find<CouponController>().getRestaurantCouponList(
    //     restaurantId: widget.restaurant!.id ??
    //         Get.find<RestaurantController>().restaurant!.id!);
    // Get.find<RestaurantController>().getRestaurantRecommendedItemList(
    //     widget.product.restaurantId ??
    //         Get.find<RestaurantController>().restaurant!.id!,
    //     false);
    Get.find<RestaurantController>().getRestaurantProductList(
        widget.product.restaurantId ??
            Get.find<RestaurantController>().restaurant!.id!,
        1,
        'all',
        false);
  }

  void _showFullImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: InteractiveViewer(
              child: Image(
                image: CachedNetworkImageProvider(
                  imageUrl,
                ),
                fit: BoxFit.cover,
              ),
              // child: Image.network(
              //   imageUrl,
              //   fit: BoxFit.contain,
              // ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController2,
        slivers: [
          SliverToBoxAdapter(
            child: GestureDetector(
              // onVerticalDragUpdate: _onVerticalDragUpdate,
              // onVerticalDragEnd: _onVerticalDragEnd,
              onHorizontalDragEnd: (details) {
                Navigator.pop(context);
              },
              child: Transform.translate(
                offset: Offset(0, _dragOffset),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onVerticalDragUpdate: _onVerticalDragUpdate,
                      onVerticalDragEnd: _onVerticalDragEnd,
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          widget.product.videoCount! > 0
                              ? Hero(
                                  tag: widget.heroTag,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: constraints.maxWidth,
                                          ),
                                          child: _chewieController != null &&
                                                  _chewieController!
                                                      .videoPlayerController
                                                      .value
                                                      .isInitialized
                                              ? AspectRatio(
                                                  aspectRatio:
                                                      _chewieController!
                                                          .aspectRatio!,
                                                  child: GestureDetector(
                                                    onTap: _togglePlayPause,
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Chewie(
                                                            controller:
                                                                _chewieController!),
                                                        Positioned(
                                                          bottom: 0,
                                                          left: 0,
                                                          right: 0,
                                                          child: Container(
                                                            height: 10,
                                                            child:
                                                                VideoProgressIndicator(
                                                              _videoPlayerController,
                                                              allowScrubbing:
                                                                  true,
                                                              colors:
                                                                  VideoProgressColors(
                                                                playedColor:
                                                                    kSecondarycolor,
                                                                bufferedColor:
                                                                    Colors.grey,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        AnimatedOpacity(
                                                          opacity:
                                                              _showPlayPauseIcon
                                                                  ? 1.0
                                                                  : 0.0,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          child: Icon(
                                                            _videoPlayerController
                                                                    .value
                                                                    .isPlaying
                                                                ? Icons.pause
                                                                : Icons
                                                                    .play_arrow,
                                                            size: 50,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Image(
                                                        image: CachedNetworkImageProvider(
                                                            widget
                                                                .product
                                                                .imageFullUrl![
                                                                    0]
                                                                .toString()),
                                                      ),
                                                      Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ));
                                    },
                                  ),
                                )
                              : CarouselSlider(
                                  options: CarouselOptions(
                                    height: 600,
                                    aspectRatio: 1 / 1,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    //autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    enlargeFactor: 0.3,
                                    //pageSnapping: false,
                                    //onPageChanged: callbackFunction,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: widget.product.imageFullUrl!.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Hero(
                                          tag: widget.heroTag,
                                          child: GestureDetector(
                                            onTap: () {
                                              ;
                                            },
                                            child: SizedBox(
                                              height: 400,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(25),
                                                  bottomRight:
                                                      Radius.circular(25),
                                                ),
                                                child: Image(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          i.toString()),
                                                  fit: BoxFit.cover,
                                                ),
                                                // child: Image.network(
                                                //   i.toString(),
                                                //   fit: BoxFit.cover,
                                                // ),
                                              ),
                                            ),
                                          ),
                                        );
                                        // ),
                                      },
                                    );
                                  }).toList(),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 50),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                  radius: 24,
                                  child: Icon(
                                    FeatherIcons.chevronLeft,
                                    color: Colors.grey[500],
                                    size: 30,
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ClipRRect(
                    //   borderRadius: const BorderRadius.only(
                    //     bottomLeft: Radius.circular(25),
                    //     bottomRight: Radius.circular(25),
                    //   ),
                    //   child: Image.network(
                    //     widget.product.imageFullUrl![0].toString(),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          RouteHelper.getRestaurantRoute(
                                              widget.product.restaurantId),
                                          // arguments: RestaurantScreen(
                                          //     restaurant: restaurant),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              widget.product.restaurantLogo ??
                                                  '',
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              widget.product.restaurantName
                                                  .toString(),
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GetBuilder<FavouriteController>(
                                          builder: (favouriteController) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radiusDefault),
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.05),
                                          ),
                                          padding: const EdgeInsets.all(
                                              Dimensions.paddingSizeSmall),
                                          margin: EdgeInsets.only(
                                              top: GetPlatform.isAndroid
                                                  ? 0
                                                  : Dimensions
                                                      .paddingSizeLarge),
                                          child: CustomFavouriteWidget(
                                            isWished: favouriteController
                                                .wishProductIdList
                                                .contains(widget.product.id),
                                            product: widget.product,
                                            isRestaurant: false,
                                          ),
                                        );
                                      }),
                                      // IconButton(
                                      //   icon: Icon(Boxicons.bx_heart),
                                      //   onPressed: () {
                                      //     // Handle like action
                                      //   },
                                      // ),
                                      IconButton(
                                        icon: Icon(FeatherIcons.share),
                                        onPressed: () {
                                          Share.share('hehe');
                                          // Handle share action
                                        },
                                      ),
                                      // IconButton(
                                      //   icon: Icon(FeatherIcons.messageCircle),
                                      //   onPressed: () {
                                      //     // Handle comment action
                                      //   },
                                      // ),
                                      // IconButton(
                                      //   icon: Icon(Icons.bookmark_border),
                                      //   onPressed: () {
                                      //     // Handle save action
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                widget.product.name.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.product.description.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
                              Text(
                                'Related Products',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeSmall),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeExtraSmall),
                          child: _buildRelatedProducts(context),
                        ),
                        //SizedBox(height: 1000, child: PinterestGrid()),
                        //const SizedBox(height: Dimensions.paddingSizeSmall),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedProducts(
    BuildContext context,
  ) {
    return GetBuilder<RestaurantController>(builder: (restController) {
      bool isVideo = widget.product.videoCount! > 0;
      return Center(
          child: Container(
        width: Dimensions.webMaxWidth,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        child: PaginatedListViewWidget(
          scrollController: scrollController,
          onPaginate: (int? offset) {
            if (restController.isSearching) {
              restController.getRestaurantSearchProductList(
                restController.searchText,
                Get.find<RestaurantController>().restaurant!.id.toString(),
                offset!,
                restController.type,
              );
            } else {
              restController.getRestaurantProductList(
                  Get.find<RestaurantController>().restaurant!.id,
                  offset!,
                  restController.type,
                  false);
            }
          },
          totalSize: restController.isSearching
              ? restController.restaurantSearchProductModel?.totalSize
              : restController.restaurantProducts != null
                  ? restController.foodPageSize
                  : null,
          offset: restController.isSearching
              ? restController.restaurantSearchProductModel?.offset
              : restController.restaurantProducts != null
                  ? restController.foodPageOffset
                  : null,
          productView: ProductViewWidgetPinterest(
            chewieController: isVideo ? _chewieController : null,
            videoController: isVideo ? _videoPlayerController : null,
            restaurantImage: widget.restaurantImage,
            isRestaurant: false,
            restaurants: null,
            products: restController.isSearching
                ? restController.restaurantSearchProductModel?.products
                : restController.categoryList != null
                    ? restController.categoryList!.isNotEmpty
                        ? restController.restaurantProducts
                        : null
                    : null,
            inRestaurantPage: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 0,
            ),
          ),
        ),
      ));
    });
  }
}

// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;

//   VideoPlayerWidget({required this.videoUrl});

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _videoPlayerController;
//   ChewieController? _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
//     _videoPlayerController.initialize().then((_) {
//       setState(() {
//         _chewieController = ChewieController(
//           videoPlayerController: _videoPlayerController,
//           aspectRatio: _videoPlayerController.value.aspectRatio,
//           autoPlay: true,
//           looping: true,
//         );
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _chewieController != null &&
//             _chewieController!.videoPlayerController.value.isInitialized
//         ? Chewie(controller: _chewieController!)
//         : Center(child: CircularProgressIndicator());
//   }
// }

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          aspectRatio: _videoPlayerController.value.aspectRatio,
          autoPlay: true,
          looping: true,
        );
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
        ? AspectRatio(
            aspectRatio: _chewieController!.aspectRatio!,
            child: Chewie(controller: _chewieController!),
          )
        : Center(child: CircularProgressIndicator());
  }
}

class _CustomProgressBar extends StatelessWidget {
  final VideoPlayerController videoPlayerController;

  const _CustomProgressBar({Key? key, required this.videoPlayerController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: videoPlayerController,
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VideoProgressIndicator(
              padding: EdgeInsets.all(10),
              videoPlayerController,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: Colors.red,
                bufferedColor: Colors.grey,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
