import 'package:shop_app/models/login_model.dart';

abstract class AppStates{}

class AppInitialStates extends AppStates{}

class ChangePasswordSecureState extends AppStates {}

class LoginLoadingState extends AppStates {}
class LoginSuccessedState extends AppStates {
  LoginModel ? model;
  LoginSuccessedState(this.model);

}
class LoginErrorState extends AppStates {}
