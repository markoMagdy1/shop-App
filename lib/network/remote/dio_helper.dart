import 'package:dio/dio.dart';

import '../../component.dart';

class DioHelper {
  static Dio ? dio;

  static init()
  {
    dio = Dio(
        BaseOptions(
            baseUrl:'https://student.valuxapps.com/api/',
            receiveDataWhenStatusError: true,

        )
    );
  }

 static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',

  }) async{
    dio!.options.headers=
   {
     'lang':lang,
     'Authorization': token??'',
     'Content-Type': 'application/json',
   };
  return await  dio!.post(
        url=url,
    queryParameters: query,
    data: data


  );
  }


  static Future<Response> getData({
  required String url,
  String lang = 'en',

})

  async{
    dio!.options.headers=
    {
      'lang':lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };
   return await dio!.get(url);
  }

}