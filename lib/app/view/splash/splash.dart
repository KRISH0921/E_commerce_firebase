import 'package:e_commerce_firebase/app/utils/pref_utils/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}
class _SplashState extends State<Splash> {

  bool isLogin = false;
  bool isOnboarding = false;

  @override
  void initState() {
    super.initState();
    getData();

  }
  Future<void> getData() async {
    PrefUtils prefUtil = PrefUtils();
    isOnboarding  = await prefUtil.getOnboarding();
    isLogin = await prefUtil.getLogin();
  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 3),() {
      isOnboarding == true ? Navigator.pushNamed(context, "intro") : isLogin == true ? Navigator.pushNamed(context, "home") : Navigator.pushNamed(context, "signin");
    },);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/shopify.png",height: 200.h,width: 200.h,),
            Image.asset("assets/images/shopifyWord.png",height: 150.h),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(backgroundColor: Colors.white,color: Colors.lightBlue,),
            )
          ],
        ),
      ),
    );
  }
}
