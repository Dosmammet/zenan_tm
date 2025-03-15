// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:flutter_boxicons/flutter_boxicons.dart';
// import 'package:zenan/features/cart/screens/cart_screen.dart';
// import 'package:zenan/features/checkout/widgets/congratulation_dialogue.dart';
// import 'package:zenan/features/dashboard/widgets/registration_success_bottom_sheet.dart';
// import 'package:zenan/features/home/screens/home_screen.dart';
// import 'package:zenan/features/menu/screens/menu_screen.dart';
// import 'package:zenan/features/order/controllers/order_controller.dart';
// import 'package:zenan/features/order/screens/order_screen.dart';
// import 'package:zenan/features/splash/controllers/splash_controller.dart';
// import 'package:zenan/features/order/domain/models/order_model.dart';
// import 'package:zenan/features/auth/controllers/auth_controller.dart';
// import 'package:zenan/features/dashboard/controllers/dashboard_controller.dart';
// import 'package:zenan/features/dashboard/widgets/address_bottom_sheet.dart';
// import 'package:zenan/features/dashboard/widgets/bottom_nav_item.dart';
// import 'package:zenan/features/dashboard/widgets/running_order_view_widget.dart';
// import 'package:zenan/features/favourite/screens/favourite_screen.dart';
// import 'package:zenan/features/loyalty/controllers/loyalty_controller.dart';
// import 'package:zenan/helper/responsive_helper.dart';
// import 'package:zenan/helper/route_helper.dart';
// import 'package:zenan/util/dimensions.dart';
// import 'package:zenan/common/widgets/cart_widget.dart';
// import 'package:zenan/common/widgets/custom_dialog_widget.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class DashboardScreen extends StatefulWidget {
//   final int pageIndex;
//   final bool fromSplash;
//   const DashboardScreen(
//       {super.key, required this.pageIndex, this.fromSplash = false});

//   @override
//   DashboardScreenState createState() => DashboardScreenState();
// }

// class DashboardScreenState extends State<DashboardScreen> {
//   PageController? _pageController;
//   int _pageIndex = 0;
//   late List<Widget> _screens;
//   final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
//   bool _canExit = GetPlatform.isWeb ? true : false;
//   late bool _isLogin;
//   bool active = false;

//   @override
//   void initState() {
//     super.initState();

//     _isLogin = Get.find<AuthController>().isLoggedIn();

//     _showRegistrationSuccessBottomSheet();

//     if (_isLogin) {
//       if (Get.find<SplashController>().configModel!.loyaltyPointStatus == 1 &&
//           Get.find<LoyaltyController>().getEarningPint().isNotEmpty &&
//           !ResponsiveHelper.isDesktop(Get.context)) {
//         Future.delayed(const Duration(seconds: 1),
//             () => showAnimatedDialog(context, const CongratulationDialogue()));
//       }
//       _suggestAddressBottomSheet();
//       Get.find<OrderController>().getRunningOrders(1, notify: false);
//     }

//     _pageIndex = widget.pageIndex;

//     _pageController = PageController(
//       initialPage: widget.pageIndex,
//     );

//     _screens = [
//       const HomeScreen(),
//       const FavouriteScreen(),
//       const CartScreen(fromNav: true),
//       const OrderScreen(),
//       const MenuScreen()
//     ];

//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {});
//     });
//   }

//   _showRegistrationSuccessBottomSheet() {
//     bool canShowBottomSheet =
//         Get.find<DashboardController>().getRegistrationSuccessfulSharedPref();
//     if (canShowBottomSheet) {
//       Future.delayed(const Duration(seconds: 1), () {
//         ResponsiveHelper.isDesktop(context)
//             ? Get.dialog(const Dialog(child: RegistrationSuccessBottomSheet()))
//                 .then((value) {
//                 Get.find<DashboardController>()
//                     .saveRegistrationSuccessfulSharedPref(false);
//                 Get.find<DashboardController>()
//                     .saveIsRestaurantRegistrationSharedPref(false);
//                 setState(() {});
//               })
//             : showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 backgroundColor: Colors.transparent,
//                 builder: (con) => const RegistrationSuccessBottomSheet(),
//               ).then((value) {
//                 Get.find<DashboardController>()
//                     .saveRegistrationSuccessfulSharedPref(false);
//                 Get.find<DashboardController>()
//                     .saveIsRestaurantRegistrationSharedPref(false);
//                 setState(() {});
//               });
//       });
//     }
//   }

//   Future<void> _suggestAddressBottomSheet() async {
//     active = await Get.find<DashboardController>().checkLocationActive();
//     if (widget.fromSplash &&
//         Get.find<DashboardController>().showLocationSuggestion &&
//         active) {
//       Future.delayed(const Duration(seconds: 1), () {
//         showModalBottomSheet(
//           context: context,
//           isScrollControlled: true,
//           backgroundColor: Colors.transparent,
//           builder: (con) => const AddressBottomSheet(),
//         ).then((value) {
//           Get.find<DashboardController>().hideSuggestedLocation();
//           setState(() {});
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
//     return PopScope(
//       canPop: Navigator.canPop(context),
//       onPopInvoked: (val) {
//         debugPrint('$_canExit');
//         if (_pageIndex != 0) {
//           _setPage(0);
//         } else {
//           if (_canExit) {
//             if (GetPlatform.isAndroid) {
//               SystemNavigator.pop();
//             } else if (GetPlatform.isIOS) {
//               exit(0);
//             }
//           }
//           if (!ResponsiveHelper.isDesktop(context)) {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text('back_press_again_to_exit'.tr,
//                   style: const TextStyle(color: Colors.white)),
//               behavior: SnackBarBehavior.floating,
//               backgroundColor: Colors.green,
//               duration: const Duration(seconds: 2),
//               margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//             ));
//           }
//           _canExit = true;

//           Timer(const Duration(seconds: 2), () {
//             _canExit = false;
//           });
//         }
//       },
//       child: Scaffold(
//         key: _scaffoldKey,
//         // floatingActionButton: GetBuilder<OrderController>(
//         //   builder: (orderController) {
//         //     return ResponsiveHelper.isDesktop(context) || keyboardVisible
//         //         ? const SizedBox()
//         //         : (orderController.showBottomSheet &&
//         //                 orderController.runningOrderList != null &&
//         //                 orderController.runningOrderList!.isNotEmpty &&
//         //                 _isLogin)
//         //             ? const SizedBox.shrink()
//         //             : Material(
//         //                 elevation: 3,
//         //                 shape: const CircleBorder(),
//         //                 child: FloatingActionButton(
//         //                   backgroundColor: _pageIndex == 2
//         //                       ? Theme.of(context).primaryColor
//         //                       : Theme.of(context).cardColor,
//         //                   onPressed: () {
//         //                     // _setPage(2);
//         //                     Get.toNamed(RouteHelper.getCartRoute());
//         //                   },
//         //                   child: CartWidget(
//         //                       color: _pageIndex == 2
//         //                           ? Theme.of(context).cardColor
//         //                           : Theme.of(context).disabledColor,
//         //                       size: 30),
//         //                 ),
//         //               );
//         //   },
//         // ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: ResponsiveHelper.isDesktop(context)
//             ? const SizedBox()
//             : GetBuilder<OrderController>(builder: (orderController) {
//                 return (orderController.showBottomSheet &&
//                         (orderController.runningOrderList != null &&
//                             orderController.runningOrderList!.isNotEmpty &&
//                             _isLogin))
//                     ? const SizedBox()
//                     : BottomAppBar(
//                         elevation: 5,
//                         notchMargin: 0,
//                         padding: EdgeInsets.all(0),
//                         height: 40,
//                         clipBehavior: Clip.antiAlias,
//                         shape: const CircularNotchedRectangle(),
//                         shadowColor: Theme.of(context).disabledColor,
//                         color: Theme.of(context).cardColor,
//                         child: Padding(
//                           padding: const EdgeInsets.all(
//                               Dimensions.paddingSizeExtraSmall),
//                           child: Row(children: [
//                             BottomNavItem(
//                                 iconData: Boxicons.bxs_home,
//                                 isSelected: _pageIndex == 0,
//                                 onTap: () => _setPage(0)),
//                             BottomNavItem(
//                                 iconData: Boxicons.bxs_heart,
//                                 isSelected: _pageIndex == 1,
//                                 onTap: () => _setPage(1)),
//                             // const Expanded(child: SizedBox()),
//                             // BottomNavItem(
//                             //     iconData: Icons.shopping_bag,
//                             //     isSelected: _pageIndex == 3,
//                             //     onTap: () => _setPage(3)),
//                             BottomNavItem(
//                                 iconData: Icons.menu,
//                                 isSelected: _pageIndex == 4,
//                                 onTap: () => _setPage(4)),
//                           ]),
//                         ),
//                       );
//               }),
//         body: GetBuilder<OrderController>(builder: (orderController) {
//           List<OrderModel> runningOrder =
//               orderController.runningOrderList != null
//                   ? orderController.runningOrderList!
//                   : [];

//           List<OrderModel> reversOrder = List.from(runningOrder.reversed);
//           return ExpandableBottomSheet(
//             background: PageView.builder(
//               controller: _pageController,
//               itemCount: _screens.length,
//               physics: const NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return _screens[index];
//               },
//             ),
//             persistentContentHeight: 100,
//             onIsContractedCallback: () {
//               if (!orderController.showOneOrder) {
//                 orderController.showOrders();
//               }
//             },
//             onIsExtendedCallback: () {
//               if (orderController.showOneOrder) {
//                 orderController.showOrders();
//               }
//             },
//             enableToggle: true,
//             expandableContent: (ResponsiveHelper.isDesktop(context) ||
//                     !_isLogin ||
//                     orderController.runningOrderList == null ||
//                     orderController.runningOrderList!.isEmpty ||
//                     !orderController.showBottomSheet)
//                 ? const SizedBox()
//                 : Dismissible(
//                     key: UniqueKey(),
//                     onDismissed: (direction) {
//                       if (orderController.showBottomSheet) {
//                         orderController.showRunningOrders();
//                       }
//                     },
//                     child: RunningOrderViewWidget(
//                         reversOrder: reversOrder,
//                         onMoreClick: () {
//                           if (orderController.showBottomSheet) {
//                             orderController.showRunningOrders();
//                           }
//                           _setPage(3);
//                         }),
//                   ),
//           );
//         }),
//       ),
//     );
//   }

//   void _setPage(int pageIndex) {
//     setState(() {
//       _pageController!.jumpToPage(pageIndex);
//       _pageIndex = pageIndex;
//     });
//   }
// }

import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:zenan/features/cart/screens/cart_screen.dart';
import 'package:zenan/features/category/screens/fason_screen.dart';
import 'package:zenan/features/checkout/widgets/congratulation_dialogue.dart';
import 'package:zenan/features/dashboard/widgets/registration_success_bottom_sheet.dart';
import 'package:zenan/features/home/screens/home_screen.dart';
import 'package:zenan/features/menu/screens/menu_screen.dart';
import 'package:zenan/features/order/controllers/order_controller.dart';
import 'package:zenan/features/order/screens/order_screen.dart';
import 'package:zenan/features/splash/controllers/splash_controller.dart';
import 'package:zenan/features/order/domain/models/order_model.dart';
import 'package:zenan/features/auth/controllers/auth_controller.dart';
import 'package:zenan/features/dashboard/controllers/dashboard_controller.dart';
import 'package:zenan/features/dashboard/widgets/address_bottom_sheet.dart';
import 'package:zenan/features/dashboard/widgets/bottom_nav_item.dart';
import 'package:zenan/features/dashboard/widgets/running_order_view_widget.dart';
import 'package:zenan/features/favourite/screens/favourite_screen.dart';
import 'package:zenan/features/loyalty/controllers/loyalty_controller.dart';
import 'package:zenan/helper/responsive_helper.dart';
import 'package:zenan/helper/route_helper.dart';
import 'package:zenan/util/dimensions.dart';
import 'package:zenan/common/widgets/cart_widget.dart';
import 'package:zenan/common/widgets/custom_dialog_widget.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  final bool fromSplash;
  const DashboardScreen(
      {super.key, required this.pageIndex, this.fromSplash = false});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  PersistentTabController? _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;
  late bool _isLogin;
  bool active = false;

  @override
  void initState() {
    super.initState();

    _isLogin = Get.find<AuthController>().isLoggedIn();

    _showRegistrationSuccessBottomSheet();

    if (_isLogin) {
      if (Get.find<SplashController>().configModel!.loyaltyPointStatus == 1 &&
          Get.find<LoyaltyController>().getEarningPint().isNotEmpty &&
          !ResponsiveHelper.isDesktop(Get.context)) {
        Future.delayed(const Duration(seconds: 1),
            () => showAnimatedDialog(context, const CongratulationDialogue()));
      }
      _suggestAddressBottomSheet();
      Get.find<OrderController>().getRunningOrders(1, notify: false);
    }

    _pageIndex = widget.pageIndex;

    _pageController = PersistentTabController(
      initialIndex: widget.pageIndex,
    );

    _screens = [
      const HomeScreen(),
      FasonScreen(categoryID: '6', categoryName: 'Tikinchi'),
      //const FavouriteScreen(),
      const MenuScreen()
    ];

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
  }

  _showRegistrationSuccessBottomSheet() {
    bool canShowBottomSheet =
        Get.find<DashboardController>().getRegistrationSuccessfulSharedPref();
    if (canShowBottomSheet) {
      Future.delayed(const Duration(seconds: 1), () {
        ResponsiveHelper.isDesktop(context)
            ? Get.dialog(const Dialog(child: RegistrationSuccessBottomSheet()))
                .then((value) {
                Get.find<DashboardController>()
                    .saveRegistrationSuccessfulSharedPref(false);
                Get.find<DashboardController>()
                    .saveIsRestaurantRegistrationSharedPref(false);
                setState(() {});
              })
            : showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (con) => const RegistrationSuccessBottomSheet(),
              ).then((value) {
                Get.find<DashboardController>()
                    .saveRegistrationSuccessfulSharedPref(false);
                Get.find<DashboardController>()
                    .saveIsRestaurantRegistrationSharedPref(false);
                setState(() {});
              });
      });
    }
  }

  Future<void> _suggestAddressBottomSheet() async {
    active = await Get.find<DashboardController>().checkLocationActive();
    if (widget.fromSplash &&
        Get.find<DashboardController>().showLocationSuggestion &&
        active) {
      Future.delayed(const Duration(seconds: 1), () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (con) => const AddressBottomSheet(),
        ).then((value) {
          Get.find<DashboardController>().hideSuggestedLocation();
          setState(() {});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return PopScope(
      canPop: Navigator.canPop(context),
      onPopInvoked: (val) {
        debugPrint('$_canExit');
        if (_pageIndex != 0) {
          _setPage(0);
        } else {
          if (_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
            } else if (GetPlatform.isIOS) {
              exit(0);
            }
          }
          if (!ResponsiveHelper.isDesktop(context)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr,
                  style: const TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
              margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            ));
          }
          _canExit = true;
          Timer(const Duration(seconds: 2), () {
            _canExit = false;
          });
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: PersistentTabView(
          context,
          controller: _pageController,
          screens: _screens,
          items: [
            PersistentBottomNavBarItem(
              icon: Icon(FeatherIcons.home),
              // title: "Home",
              activeColorPrimary: Theme.of(context).primaryColor,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(FeatherIcons.search),
              // title: "Favorites",
              activeColorPrimary: Theme.of(context).primaryColor,
              inactiveColorPrimary: Colors.grey,
            ),
            // PersistentBottomNavBarItem(
            //   icon: Icon(Icons.shopping_bag),
            //   title: "Cart",
            //   activeColorPrimary: Colors.blue,
            //   inactiveColorPrimary: Colors.grey,
            // ),
            PersistentBottomNavBarItem(
              icon: Icon(FeatherIcons.user),
              // title: "Menu",
              activeColorPrimary: Theme.of(context).primaryColor,

              inactiveColorPrimary: Colors.grey,
            ),
          ],
          //confineInSafeArea: true,

          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          navBarHeight: 45.0,

          // padding: EdgeInsets.only(bottom: 12),
          // margin: EdgeInsets.only(
          //   bottom: 1,
          // ),
          navBarStyle: NavBarStyle.style11,
          onItemSelected: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToTab(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
