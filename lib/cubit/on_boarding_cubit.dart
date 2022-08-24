
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'on_boarding_states.dart';

class OnBoardingCubit extends Cubit{
  OnBoardingCubit():super(OnBoardingIntilialState);

 static OnBoardingCubit get(context)=>BlocProvider.of(context);






}