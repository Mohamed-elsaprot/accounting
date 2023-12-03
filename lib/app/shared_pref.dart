import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static var name,mobile,location;
  static Future<bool> check()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.get('check')!=DateTime.now().month.toString()){
      return false;
    }else{
      return true;
    }
  }

  static getMarketData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      name = prefs.get('name').toString();
      location = prefs.get('loc').toString();
      mobile = prefs.get('num').toString();
      print(name);
      print(location);
      print(mobile);
  }
}
