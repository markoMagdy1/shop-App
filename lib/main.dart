import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/screens/home_layout.dart';
import 'package:shop_app/screens/onboarding.dart';

import 'component.dart';
import 'cubit/bloc_observer.dart';
import 'network/remote/dio_helper.dart';
import 'network/local/caech_helper.dart';
import 'screens/login_Screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () async {
      DioHelper.init();
    await  CacheHelper.init();

      bool onBoarding=CacheHelper.getData(key:'onBoarding')??false;
      token=CacheHelper.getData(key:'token')??'';
      Widget ? widget;

      print(onBoarding);
      print(token);

      if(onBoarding){
        if(token=='') widget=LoginScreen();
        else widget=HomeLayout();
      }else {
        widget = OnBoardingScreen();
      }
      runApp(MyApp(onBoarding: onBoarding,
        startWidget: widget,
      ));
      },

    blocObserver: SimpleBlocObserver(),

  );

}

class MyApp extends StatelessWidget {
   bool  ? onBoarding ;
   Widget  ? startWidget;

   MyApp({
     this.onBoarding,
     this.startWidget,
});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:startWidget
    );
  }
}

