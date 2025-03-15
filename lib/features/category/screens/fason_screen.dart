import 'package:zenan/common/models/product_model.dart';
import 'package:zenan/common/models/restaurant_model.dart';
import 'package:zenan/common/widgets/product_view_widget.dart';
import 'package:zenan/common/widgets/product_view_widget_pinterest.dart';
import 'package:zenan/common/widgets/search_text_field.dart';
import 'package:zenan/features/category/controllers/category_controller.dart';
import 'package:zenan/features/category/controllers/fason_category_controller.dart';
import 'package:zenan/features/search/screens/search_screen.dart';
import 'package:zenan/helper/responsive_helper.dart';
import 'package:zenan/helper/route_helper.dart';
import 'package:zenan/util/dimensions.dart';
import 'package:zenan/util/styles.dart';
import 'package:zenan/common/widgets/cart_widget.dart';
import 'package:zenan/common/widgets/footer_view_widget.dart';
import 'package:zenan/common/widgets/menu_drawer_widget.dart';
import 'package:zenan/common/widgets/veg_filter_widget.dart';
import 'package:zenan/common/widgets/web_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FasonScreen extends StatefulWidget {
  final String? categoryID;
  final String categoryName;
  const FasonScreen(
      {super.key, required this.categoryID, required this.categoryName});

  @override
  FasonScreenState createState() => FasonScreenState();
}

class FasonScreenState extends State<FasonScreen>
    with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    Get.find<FasonCategoryController>().getSubCategoryList(widget.categoryID);
    scrollController.addListener(() {
      print('AAAAAAAAAAAAAAAAAAAAA');
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          Get.find<FasonCategoryController>().categoryProductList != null &&
          !Get.find<FasonCategoryController>().isLoading) {
        int pageSize =
            (Get.find<FasonCategoryController>().pageSize! / 10).ceil();
        if (Get.find<FasonCategoryController>().offset < pageSize) {
          debugPrint('end of the page');
          Get.find<FasonCategoryController>().showBottomLoader();
          Get.find<FasonCategoryController>().getCategoryProductList(
            Get.find<FasonCategoryController>().subCategoryIndex == 0
                ? widget.categoryID
                : Get.find<FasonCategoryController>()
                    .subCategoryList![
                        Get.find<FasonCategoryController>().subCategoryIndex]
                    .id
                    .toString(),
            Get.find<FasonCategoryController>().offset + 1,
            Get.find<FasonCategoryController>().type,
            false,
          );
        }
      }
    });
  }

  late ScrollController _scrollController;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FasonCategoryController>(builder: (catController) {
      List<Product>? products;
      List<Restaurant>? restaurants;
      if (catController.categoryProductList != null &&
          catController.searchProductList != null) {
        products = [];
        if (catController.isSearching) {
          products.addAll(catController.searchProductList!);
        } else {
          products.addAll(catController.categoryProductList!);
        }
      }
      if (catController.categoryRestaurantList != null &&
          catController.searchRestaurantList != null) {
        restaurants = [];
        if (catController.isSearching) {
          restaurants.addAll(catController.searchRestaurantList!);
        } else {
          restaurants.addAll(catController.categoryRestaurantList!);
        }
      }
      return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: CustomScrollView(
            //physics: NeverScrollableScrollPhysics(),
            controller: scrollController,
            slivers: [
              // Sliver AppBar with Instagram-style search bar
              SliverAppBar(
                // pinned: true,
                floating: true,

                expandedHeight: 130, // Adjust based on UI needs
                backgroundColor: Theme.of(context).colorScheme.background,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      //const SizedBox(height: 20), // Spacing at top
                      InstagramStyleSearchBar(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      SearchScreen(
                                isHomePage: false,
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      (catController.subCategoryList != null &&
                              !catController.isSearching)
                          ? SizedBox(
                              height: 50,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                color: Theme.of(context).cardColor,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      catController.subCategoryList!.length,
                                  padding: const EdgeInsets.only(left: 8),
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () =>
                                          catController.setSubCategoryIndex(
                                              index, widget.categoryID),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        margin: const EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: index ==
                                                  catController.subCategoryIndex
                                              ? Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.1)
                                              : Colors.transparent,
                                        ),
                                        child: Center(
                                          child: Text(
                                            catController
                                                .subCategoryList![index].name!,
                                            style:
                                                index ==
                                                        catController
                                                            .subCategoryIndex
                                                    ? TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600)
                                                    : TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSecondary),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),

              // Category list as a SliverPersistentHeader
              // SliverPersistentHeader(
              //   pinned: false,
              //   floating: false,
              //   delegate: _SliverAppBarDelegate(
              //     minHeight: 40,
              //     maxHeight: 50,
              //     child:
              //   ),
              // ),

              // Main content section
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        ProductViewWidgetPinterest(
                          isRestaurant: false,
                          products: products,
                          restaurants: null,
                          noDataText: 'no_category_food_found'.tr,
                        ),
                        if (catController.isLoading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      );
      return Scaffold(
        body: Column(children: [
          SizedBox(
            height: 50,
          ),
          InstagramStyleSearchBar(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      SearchScreen(
                    isHomePage: false,
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            // onTap: () => Get.toNamed(
            //   RouteHelper.getSearchRoute(),
            // ),
          ),
          (catController.subCategoryList != null && !catController.isSearching)
              ? Center(
                  child: Container(
                  height: 40,
                  width: Dimensions.webMaxWidth,
                  color: Theme.of(context).cardColor,
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeExtraSmall),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: catController.subCategoryList!.length,
                    padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeSmall),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => catController.setSubCategoryIndex(
                            index, widget.categoryID),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                              vertical: Dimensions.paddingSizeExtraSmall),
                          margin: const EdgeInsets.only(
                              right: Dimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusSmall),
                            color: index == catController.subCategoryIndex
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1)
                                : Colors.transparent,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  catController.subCategoryList![index].name!,
                                  style: index == catController.subCategoryIndex
                                      ? robotoMedium.copyWith(
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: Theme.of(context).primaryColor)
                                      : robotoRegular.copyWith(
                                          fontSize: Dimensions.fontSizeSmall),
                                ),
                              ]),
                        ),
                      );
                    },
                  ),
                ))
              : const SizedBox(),
          SizedBox(
            height: 12,
          ),
          Expanded(
              child: NotificationListener(
            onNotification: (dynamic scrollNotification) {
              if (scrollNotification is ScrollEndNotification) {
                if ((_tabController!.index == 1 &&
                        !catController.isRestaurant) ||
                    _tabController!.index == 0 && catController.isRestaurant) {
                  catController.setRestaurant(_tabController!.index == 1);
                  if (catController.isSearching) {
                    catController.searchData(
                      catController.searchText,
                      catController.subCategoryIndex == 0
                          ? widget.categoryID
                          : catController
                              .subCategoryList![catController.subCategoryIndex]
                              .id
                              .toString(),
                      catController.type,
                    );
                  } else {
                    if (_tabController!.index == 1) {
                      catController.getCategoryRestaurantList(
                        catController.subCategoryIndex == 0
                            ? widget.categoryID
                            : catController
                                .subCategoryList![
                                    catController.subCategoryIndex]
                                .id
                                .toString(),
                        1,
                        catController.type,
                        false,
                      );
                    } else {
                      catController.getCategoryProductList(
                        catController.subCategoryIndex == 0
                            ? widget.categoryID
                            : catController
                                .subCategoryList![
                                    catController.subCategoryIndex]
                                .id
                                .toString(),
                        1,
                        catController.type,
                        false,
                      );
                    }
                  }
                }
              }
              return false;
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView(
                controller: scrollController,
                child: FooterViewWidget(
                  child: Center(
                    child: SizedBox(
                      // width: Dimensions.webMaxWidth,
                      child: Column(
                        children: [
                          ProductViewWidgetPinterest(
                            isRestaurant: false,
                            products: products,
                            restaurants: null,
                            noDataText: 'no_category_food_found'.tr,
                          ),
                          catController.isLoading
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeSmall),
                                    child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            Theme.of(context).primaryColor)),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
        ]),
      );
    });
  }
}

// SliverPersistentHeader Delegate for the category list
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
