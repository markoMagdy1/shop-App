import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/categories_screen.dart';
import 'package:shop_app/screens/favourites_screen.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/setting_screen.dart';

import '../models/categories_model.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());
  ShopCubit get(context)=>BlocProvider.of(context);
   int currentIndex=0;

   List<Widget> currentBody=[
     HomeScreen(),
     CategoriesScreen(),
     favouritesScreen(),
     SettingScreen()
   ];

   void changeBottomNavBar(int index){
     currentIndex=index;
     emit(ShopChangeBottomNavBarState());
  }
HomeModel ? homeModel;
   bool HomeDataFinished=false ;
void getHomeData(){
     emit(ShopLoadingHomeDataModelState());
     DioHelper.getData(url: 'home')
         .then((value){

           homeModel = HomeModel.fromJson(value.data);
           print('Data Model is heeeeeeeeeer');
           print(homeModel!.data!.banners[0].image);
           HomeDataFinished=homeModel!.status;
           emit(ShopSucceededHomeDataModelState());
     }).catchError((error){
       print(error.toString());
       emit(ShopErrorHomeDataModelState());
     });
}

  CategoriesModel ? categoriesModel ;
void getCategories(){
emit(ShopLoadingGetCategoriesState());
  DioHelper.getData(url:'categories')
      .then((value) {
        categoriesModel=CategoriesModel.fromJson(value.data);
        print('helllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllo');
        print(categoriesModel);
        emit(ShopSucceededGetCategoriesState());
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorGetCategoriesState());
  }
      );
}


}