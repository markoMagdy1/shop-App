import 'package:flutter/material.dart';
import 'package:shop_app/network/local/caech_helper.dart';
import 'package:shop_app/screens/home_layout.dart';
import 'package:shop_app/screens/login_Screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {

  var pageController= PageController();
  bool isLast=false;

  @override
  Widget build(BuildContext context) {
    List <OnBoardingModel> onbordingList=[
      OnBoardingModel(
          image: 'assets/a39aed6ff9a134ed6245a1279aa1e8a6.png',
          title: 'title 1 ',
          body: 'body 1'),
      OnBoardingModel(
          image: 'assets/a39aed6ff9a134ed6245a1279aa1e8a6.png',
          title: 'title 2 ',
          body: 'body 2'),
      OnBoardingModel(
          image: 'assets/a39aed6ff9a134ed6245a1279aa1e8a6.png',
          title: 'title 3 ',
          body: 'body 3'),
    ];

    void submit(){
      CacheHelper.saveData(key:'onBoarding', value: true).then((value){
        if(value){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
        }
      }).catchError((error){print(error.toString());});
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('onBoarding'),
        actions: [
          TextButton(onPressed: (){
            submit();
          },
               child: Text('SKIP',
                 style: TextStyle(
                   color: Colors.white
                 ),
               ),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(itemBuilder:(context, index) => onBoardingItem(onbordingList[index]),
                itemCount: onbordingList.length,
                scrollDirection: Axis.horizontal,
                controller: pageController,
                onPageChanged: (index){
                if(index==2)
                  {
                    isLast=true ;
                  }
                },
              ),
            ),
            SizedBox(height: 15,),
            Row(children: [
              SmoothPageIndicator(
                controller: pageController,
                count: onbordingList.length,
                axisDirection: Axis.horizontal,
                effect: SlideEffect(
                    spacing:  30.0,
                    radius:  8.0,
                    dotWidth:  24.0,
                    dotHeight:  16.0,
                    paintStyle:  PaintingStyle.stroke,
                    strokeWidth:  1.5,
                    dotColor:  Colors.grey,
                    activeDotColor:  Colors.indigo
                ),
              ),
              Spacer(),
              FloatingActionButton(
                child:Icon(Icons.chevron_right_outlined),
                  onPressed: (){
                  if(isLast){
                    submit();
                  }else{
                    pageController.nextPage(
                        duration:Duration(milliseconds: 500) ,
                        curve:Curves.fastOutSlowIn );
                  }

                  })
            ],)

          ],
        ),
      ),
    );

  }
}

Widget onBoardingItem(OnBoardingModel model)=> Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Image.asset(
      '${model.image}',
      height: 400,
      width: 240,
      fit: BoxFit.fill,
      alignment: AlignmentDirectional.center,
    ),
    SizedBox(
      height: 15,
    ),
    Text('${model.title}'),
    SizedBox(
      height: 15,
    ),
    Text('${model.body}'),
  ],

);



class OnBoardingModel{
   String ? image ;
   String ? title ;
   String ? body ;
   OnBoardingModel({
     required this.image,
     required this.title,
     required this.body,
}) {}


}
