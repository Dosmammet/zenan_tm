import 'package:zenan/common/models/product_model.dart';
import 'package:zenan/interface/repository_interface.dart';

abstract class ProductRepositoryInterface implements RepositoryInterface {
  @override
  Future<List<Product>?> getList({int? offset, String? type});

  @override
  Future<Product?> get(String? id, {bool isCampaign = false});
}
