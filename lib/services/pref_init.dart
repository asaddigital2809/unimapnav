import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyPrefs{
  static Future setStringShared(String key,String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
    debugPrint('=====>shared${preferences.containsKey(key)}');
  }
  static Future setBoolShared(String key,bool value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
    debugPrint('=====>shared${preferences.containsKey(key)}');
  }
  static Future setIntShared(String key,int value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(key, value);
  }


  static Future<String?> getStringShared(String key) async{
     SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString(key);
  }

  static Future<bool?> getBoolShared(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getBool(key);
  }
  static Future<int?> getIntShared(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getInt(key);
  }
}
