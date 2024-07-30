import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils{

  static String isOnboarding = "onboarding";
  static String isLogin = "login";
  static String isUid = "uid";

  Future<void> setOnboarding(bool onBoarding) async{
    SharedPreferences onboarding = await SharedPreferences.getInstance();
    onboarding.setBool(isOnboarding,onBoarding);
  }

  Future<bool> getOnboarding() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bool onboarding = shr.getBool(isOnboarding) ?? false;
    return onboarding;
  }


  Future<void> setLogin(bool login) async{
    SharedPreferences loGin = await SharedPreferences.getInstance();
    loGin.setBool(isLogin,login);
  }


  Future<bool> getLogin() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bool login = shr.getBool(isLogin) ?? false;
    return login;
  }

  Future<void> setUid(String uid)async{
    SharedPreferences getUid = await SharedPreferences.getInstance();
    getUid.setString(isUid, uid);
  }

  getUid() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    String uid = shr.getString(isUid) ?? "";
    print("sbygsgfasgtgt $uid");
    return uid;
  }
}