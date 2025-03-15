import 'package:zenan/common/models/product_model.dart';
import 'package:zenan/common/models/response_model.dart';
import 'package:zenan/common/models/review_model.dart';
import 'package:zenan/features/product/domain/models/review_body_model.dart';
import 'package:zenan/interface/repository_interface.dart';

abstract class ReviewRepositoryInterface extends RepositoryInterface {
  @override
  Future<List<Product>?> getList({int? offset, String type});
  Future<ResponseModel> submitReview(
      ReviewBodyModel reviewBody, bool isProduct);
  Future<List<ReviewModel>?> getRestaurantReviewList(String? restaurantID);
}
