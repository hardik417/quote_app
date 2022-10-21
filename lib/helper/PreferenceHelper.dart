import 'package:shared_preferences/shared_preferences.dart';

import '../utils/PrefUtils.dart';

class PreferenceHelper {

  static Future<SharedPreferences> get _instance async => _prefsInstance
        ??= await SharedPreferences.getInstance();
   static  SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {

    _prefsInstance = await _instance;
    return _prefsInstance;
  }

 static void saveIsUserNew(bool isLoggedIn) {
    _prefsInstance!.setBool(PrefUtils.IS_USERNEW, isLoggedIn);
  }

 static bool getIsUserNew() {
    return _prefsInstance!.getBool(PrefUtils.IS_USERNEW) ?? true;
  }

  static void saveisliked(String index,bool value){
    _prefsInstance!.setBool("${index}", value);
  }

  static bool getisliked(String index){
   return _prefsInstance!.getBool("${index}")??false;
  }
}
