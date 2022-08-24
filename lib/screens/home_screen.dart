import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shop_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
    listener: (context, state){},
    builder: (context, state){
      return ShopCubit().get(context).HomeDataFinished ?
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bannerBuilder(ShopCubit().get(context).homeModel!),
            SizedBox(height: 15,),
            Text(
              'Categories',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 5,),
            buildCateItem(ShopCubit().get(context).categoriesModel!),
            SizedBox(height: 15,),
            Text(
              'New Products',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 5,),
            productItem(ShopCubit().get(context).homeModel!)
          ],
        ),
      )
          :Center(child: CircularProgressIndicator());
    },
    );
  }

Widget bannerBuilder(HomeModel model)=> CarouselSlider(
  items: model.data!.banners.map((e) =>Image(
  image:NetworkImage('${e.image}'),
  fit: BoxFit.cover,
  width: double.infinity,
  )).toList(),
  options: CarouselOptions(
    scrollDirection: Axis.horizontal,
    autoPlayCurve: Curves.fastOutSlowIn,
    autoPlayInterval: Duration(seconds: 2),
    autoPlay: true,
    viewportFraction: 1

  ),
);

  Widget buildCateItem(CategoriesModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 100,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>  Container(
              height: 100,
              width: 100,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image(
                    image:NetworkImage('${model.data!.data[index].image}'),
                    height: 100,
                    width: 100,
                  ),
                  Container(
                   // alignment: AlignmentDirectional.bottomCenter,
                    width: double.infinity,
                      color: Colors.black54.withOpacity(.3),
                      child: Text(
                        maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          '${model.data!.data[index].name}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white
                        ),
                      )
                  )
                ],
              ),
            ),
            separatorBuilder:(context, index) => SizedBox(width: 5,),
            itemCount: model.data!.data.length),
      ),


    ],
  ) ;

  Widget productItem(HomeModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        color: Colors.grey[100],
        child: GridView.count(
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1/1.34,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,

          children: List.generate(model.data!.products.length, (index) =>
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(
                          image: NetworkImage('${model.data!.products[index].image}'),
                          height: 150,
                          // width: 100,
                          //  fit: BoxFit.cover,
                        ),
                        if(model.data!.products[index].discount !=0)
                          Container(
                            color:Colors.deepOrange,
                            child: (
                                Text(
                                  'discount',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                            ),
                            height: 20,
                            width: 70,
                          )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            '${model.data!.products[index].name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                            style: TextStyle(
                                fontSize: 12

                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'price: ${model.data!.products[index].price.round()}',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 12
                                ),
                              ),
                              SizedBox(width: 5,),
                              if(model.data!.products[index].discount!=0)
                                Text(

                                  '${model.data!.products[index].old_price.round()}',
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 10

                                  ),
                                ),
                              Spacer(),
                              IconButton(
                                onPressed: (){},
                                icon:Icon(Icons.favorite_border),
                                iconSize: 14,
                              )

                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              )
          ),
        ),
      ),
    ],
  );
}
