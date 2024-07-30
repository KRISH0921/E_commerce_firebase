import 'package:e_commerce_firebase/app/view/add_product_screen/add-product_screen.dart';
import 'package:e_commerce_firebase/app/view/home_screen/home.dart';
import 'package:e_commerce_firebase/app/view/intro_screen/intro_screen.dart';
import 'package:e_commerce_firebase/app/view/login_screen_view/sign_in.dart';
import 'package:e_commerce_firebase/app/view/login_screen_view/sign_up.dart';
import 'package:e_commerce_firebase/app/view/splash/splash.dart';
import 'package:e_commerce_firebase/app/view/update_screen/update_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB4wD57Ol6WMxHzcT-cpVKRXzhyUrse5tY",
          appId: "com.example.e_commerce_firebase",
          messagingSenderId: "",
          projectId: "e-commerce-63b76"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const Splash(),
          "intro": (context) => const IntroScreen(),
          "signin": (context) => const SignIn(),
          "signup": (context) => const SignUp(),
          "home": (context) => const Home(),
          "product": (context) => const AddProduct(),
          "update": (context) =>  UpdateProduct(),
        },
      ),
    );
  }
}
