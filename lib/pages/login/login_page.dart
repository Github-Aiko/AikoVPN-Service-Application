import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:aiko/models/login_model.dart';
import 'package:aiko/models/user_model.dart';
import 'package:aiko/service/user_service.dart';
import 'package:aiko/utils/navigator_util.dart';
import 'package:aiko/constant/app_strings.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  Duration get loginTime => const Duration(milliseconds: 2250);

  late UserModel _userModel;
  late LoginModel _loginModel;

  static String? _emailValidator(value) {
    if (value.isEmpty || !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
      return 'Vui lòng nhập địa chỉ email chính xác!';
    }
    return null;
  }

  static String? _passwordValidator(String? value) {
    if (value?.isEmpty == true) {
      return 'Vui lòng nhập địa chỉ email chính xác!';
    }
    if (value?.length == null || value!.length < 6) {
      return 'Mật khẩu không được ít hơn 6 ký tự';
    }
    return null;
  }

  Future<String?> _login(LoginData data) async {
    String? result;

    try {
      await _loginModel.login(data.name, data.password);
    } catch (error) {
      result = 'Đăng nhập thất bại. Xin hãy thử lại';
    }

    return result;
  }

  Future<String?> _register(SignupData data) async {
    String? result;

    try {
      await UserService().register({'email': data.name, 'password': data.password});

      await _loginModel.login(data.name, data.password);
    } catch (error) {
      result = 'Đăng ký không thành công, vui lòng thử lại';
    }

    return result;
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    _userModel = Provider.of<UserModel>(context);
    _loginModel = LoginModel(_userModel);

    return FlutterLogin(
      title: AppStrings.appName,
      onLogin: _login,
      onSignup: _register,
      messages: LoginMessages(
          userHint: 'Mail',
          passwordHint: 'Mật Khẩu',
          confirmPasswordHint: 'Xác nhận mật khẩu',
          confirmPasswordError: 'Hai mật khẩu không khớp',
          forgotPasswordButton: 'Quên mật khẩu?',
          loginButton: 'Đăng Nhập',
          signupButton: 'Đăng Kí',
          recoverPasswordIntro: 'Đặt lại mật khẩu',
          recoverPasswordButton: 'Chắc chắn',
          recoverPasswordDescription: 'Hệ thống sẽ gửi email đặt lại mật khẩu vào hòm thư của bạn, hãy chú ý kiểm tra nhé',
          recoverPasswordSuccess: 'Gửi thành công',
          goBackButton: 'Trở lại'),
      onSubmitAnimationCompleted: () {
        NavigatorUtil.goHomePage(context);
      },
      onRecoverPassword: _recoverPassword,
      userValidator: _emailValidator,
      passwordValidator: _passwordValidator,
    );
  }
}
