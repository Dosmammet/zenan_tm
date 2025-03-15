import 'package:zenan/common/models/response_model.dart';
import 'package:zenan/features/profile/domain/models/userinfo_model.dart';
import 'package:zenan/interface/repository_interface.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileRepositoryInterface extends RepositoryInterface {
  Future<ResponseModel> updateProfile(
      UserInfoModel userInfoModel, XFile? data, String token);
  Future<ResponseModel> changePassword(UserInfoModel userInfoModel);
}
