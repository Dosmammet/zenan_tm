import 'package:zenan/features/coupon/domain/models/coupon_model.dart';
import 'package:zenan/interface/repository_interface.dart';
import 'package:get/get_connect/http/src/response/response.dart';

abstract class CouponRepositoryInterface extends RepositoryInterface {
  @override
  Future<List<CouponModel>?> getList(
      {int? offset,
      int? customerId,
      int? restaurantId,
      bool fromRestaurant = false});
  Future<Response> applyCoupon(String couponCode, int? restaurantID);
}
