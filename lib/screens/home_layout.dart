import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shop_states.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // ShopCubit cubit =ShopCubit().get(context);
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getCategories(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Store App'),
            ),
            body: ShopCubit().get(context).currentBody[ShopCubit().get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex:ShopCubit().get(context).currentIndex,
              onTap: (index){
                ShopCubit().get(context).changeBottomNavBar(index);
              },

              items: [
                BottomNavigationBarItem(
                    label: 'home',
                    icon: Icon(Icons.home)),
                BottomNavigationBarItem(
                    label: 'Categories' ,
                    icon: Icon(Icons.category_outlined)),
                BottomNavigationBarItem(
                    label: 'Favourites' ,
                    icon: Icon(Icons.favorite)),
                BottomNavigationBarItem(
                    label: 'settings' ,
                    icon: Icon(Icons.settings)),
              ],
            ),
          );
        },
      ),
    );
  }
}
