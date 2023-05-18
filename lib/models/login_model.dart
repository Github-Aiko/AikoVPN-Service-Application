import 'package:aiko/models/base_model.dart';
import 'package:aiko/models/user_model.dart';
import 'package:aiko/service/user_service.dart';

class LoginModel extends BaseModel {
  final UserService _userService = UserService();
  final UserModel _userModel;

  LoginModel(this._userModel);

  // 登陆方法
  login(String? account, String? passWord) async {
    var parameters = {'email': account, 'password': passWord};

    return _userService.login(parameters)?.then((loginEntity) async {
      _userModel.setToken(loginEntity);

      return _userService.info();
    }).then((userEntity) {
      _userModel.setUserInfo(userEntity);
      notifyListeners();

      return userEntity;
    });
  }
}
