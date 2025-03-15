import 'package:zenan/common/models/product_model.dart';
import 'package:zenan/common/models/response_model.dart';
import 'package:zenan/common/models/review_model.dart';
import 'package:zenan/features/product/domain/models/review_body_model.dart';

abstract class ReviewServiceInterface {
  Future<List<Product>?> getReviewedProductList({required String type});
  Future<ResponseModel> submitProductReview(ReviewBodyModel reviewBody);
  Future<ResponseModel> submitDeliverymanReview(ReviewBodyModel reviewBody);
  Future<List<ReviewModel>?> getRestaurantReviewList(String? restaurantID);
}
