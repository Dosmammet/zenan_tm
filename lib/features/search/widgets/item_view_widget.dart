import 'package:zenan/features/search/controllers/search_controller.dart'
    as search;
import 'package:zenan/util/dimensions.dart';
import 'package:zenan/common/widgets/footer_view_widget.dart';
import 'package:zenan/common/widgets/product_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemViewWidget extends StatelessWidget {
  final bool isRestaurant;
  const ItemViewWidget({super.key, required this.isRestaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<search.SearchController>(builder: (searchController) {
        return SingleChildScrollView(
          child: FooterViewWidget(
            child: Center(
                child: SizedBox(
                    width: Dimensions.webMaxWidth,
                    child: ProductViewWidget(
                      isRestaurant: isRestaurant,
                      products: searchController.searchProductList,
                      restaurants: searchController.searchRestList,
                      noDataText: isRestaurant
                          ? 'no_restaurant_found'.tr
                          : 'no_food_found'.tr,
                      fromSearch: true,
                    ))),
          ),
        );
      }),
    );
  }
}
