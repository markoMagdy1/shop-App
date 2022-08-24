import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper{

 static SharedPreferences ? sharedPrefer;
 static init()async{
  sharedPrefer=await SharedPreferences.getInstance();
 }

static Future<bool> saveData({
 required String  key,
 required dynamic value
})async
{
if(value is bool)  return await sharedPrefer!.setBool(key, value);
if(value is String) return await sharedPrefer!.setString(key, value);
if(value is int) return await sharedPrefer!.setInt(key, value);
return await sharedPrefer!.setBool(key, value);

}


static dynamic getData({
 required key
}){
return  sharedPrefer!.get(key);
}

}