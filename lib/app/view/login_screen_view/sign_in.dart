import 'package:e_commerce_firebase/app/components/custom_button.dart';
import 'package:e_commerce_firebase/app/components/custom_text.dart';
import 'package:e_commerce_firebase/app/components/custom_textfield.dart';
import 'package:e_commerce_firebase/app/them/color_them.dart';
import 'package:e_commerce_firebase/app/utils/pref_utils/pref_utils.dart';
import 'package:e_commerce_firebase/app/utils/service/firebase_helper.dart';
import 'package:e_commerce_firebase/app/view/login_screen_view/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  var txtKey = GlobalKey<FormState>();

  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWight,
      body: SafeArea(
        child: Form(
          key: txtKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.h, top: 32.h),
                      child: customText(
                          name: "Welcome Back!",
                          color: primaryBlack,
                          fontFamily: "PoppinsBold",
                          fontSize: 30.h),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.h, top: 10.h),
                      child: customText(
                          name: "Sign in to your account",
                          color: primaryAshGrey,
                          fontSize: 18.sp,
                          fontFamily: "PoppinsRegular"),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFromField(
                        labelText: "Email",
                        textColor: primaryAshGrey,
                        textInputType: TextInputType.emailAddress,
                        controller: txtEmail,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          String emailPattern =
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          RegExp regExp = RegExp(emailPattern);
                          if (!regExp.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Obx(
                       () => CustomTextFromField(
                          labelText: "Password",
                          obscureText: controller.show.value,
                          textInputType: TextInputType.number,
                          textColor: primaryAshGrey,
                          controller: txtPassword,
                          validator: (value) {
                            if (value == "") {
                              return "Please enter valid password";
                            }
                            if (txtPassword.text.length <= 5) {
                              return "Please enter max 6 digit password";
                            }
                          },
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.show.value == true ? Icons.visibility_off : Icons.visibility,color: primaryAshGrey,),
                            onPressed: () {
                              setState(
                                    () {
                                      controller.show.value = ! controller.show.value;
                                },
                              );
                            },
                            color: Color(0xff9E9E9E),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:10.h,right: 10.h),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {},
                            child: customText(
                                name: "Forgot your password ?",
                                color: primaryAshGrey,
                                fontSize: 18.sp)),
                      ),
                    ),
                    SizedBox(height: 40.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Obx(
                        () =>  CustomButton(
                              process: controller.process.value,
                              name: "Login",
                              fontFamily: "PoppinsRegular",
                              fontSize: 22.sp,
                              onTap: () async {
                                controller.process.value = true;
                                if (txtKey.currentState!.validate()) {
                                  String  msg = await FirebaseHelper().signInEmail(txtEmail.text, txtPassword.text);
                                  if(msg == "SignIn Successfully"){

                                    Get.toNamed("home");
                                    txtEmail.clear();
                                    txtPassword.clear();
                                  }
                                  else{
                                    Get.snackbar("Message", "User does not exist...?"
                                        "\nPlease enter your valid Email Id and Password....",duration: Duration( seconds: 3));
                                  }
                                }
                                controller.process.value = false;
                              },
                          ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Center(
                      child: customText(
                        name: "Or Continue With",
                        color: primaryAshGrey,
                        fontFamily: "PoppinsRegular",
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 66.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: primaryBrickRed,
                                  borderRadius: BorderRadius.all(Radius.circular(10.r))
                              ),
                              child: Center(child: Image.asset("assets/images/google.png",height: 32.h,)),
                            ),
                          ),
                          SizedBox(width: 20.h,),
                          Expanded(
                            child: Container(
                              height: 66.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: primaryMitBlue,
                                  borderRadius: BorderRadius.all(Radius.circular(10.r))
                              ),
                              child: Center(child: Image.asset("assets/images/facebook.png",height: 32.h,)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customText(
                      name: "Not A Member ? ",
                      color: primaryAshGrey,
                      fontFamily: "PoppinsRegular",
                      fontSize: 20.sp),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "signup");
                    },
                    child: customText(
                      name: " Join Now",
                      fontSize: 20.sp,
                      fontFamily: "PoppinsRegular",
                      color: primaryMitBlue,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
