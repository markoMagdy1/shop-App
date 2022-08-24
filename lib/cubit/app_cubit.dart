import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/app_states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/models/login_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  AppCubit get(context) => BlocProvider.of(context);

  LoginModel ? loginModel ;
  bool isPassword = true;

  void changePasswordSecure() {
    isPassword = !isPassword;
    print(isPassword);
    emit(ChangePasswordSecureState());
  }

  void userLogin(
  {
  required String email,
  required String password,
}
) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: 'login',
        data: {
          'email': email,
          'password': password
        }).then((value) {

         // print(value.data);

         loginModel= LoginModel.fromJson(value.data );


          // print(loginModel!.data!.email);
          //print('pleaaaaaase');
          emit(LoginSuccessedState(loginModel));

    }).catchError((error){
      emit(LoginErrorState());
      print('errrrrrrror heeeeeer eeeeeee');
      print(error.toString());}
      );
  }
}