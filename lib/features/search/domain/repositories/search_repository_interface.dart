import 'package:zenan/common/models/product_model.dart';
import 'package:zenan/features/search/domain/models/search_suggestion_model.dart';
import 'package:zenan/interface/repository_interface.dart';
import 'package:get/get_connect/http/src/response/response.dart';

abstract class SearchRepositoryInterface extends RepositoryInterface {
  Future<List<Product>?> getSuggestedFoods();
  Future<SearchSuggestionModel?> getSearchSuggestions(String searchText);
  Future<Response> getSearchData(String query, bool isRestaurant);
  Future<bool> saveSearchHistory(List<String> searchHistories);
  List<String> getSearchHistory();
  Future<bool> clearSearchHistory();
}
