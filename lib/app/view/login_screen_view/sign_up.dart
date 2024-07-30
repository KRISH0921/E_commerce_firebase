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

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  PrefUtils prefUtil = PrefUtils();

  var txtKey = GlobalKey<FormState>();

  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryWight,
        body: Form(
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
                         name: "Sign Up!",
                         color: primaryBlack,
                         fontFamily: "PoppinsBold",
                         fontSize: 30.sp
                     ),
                   ),
                   Padding(
                     padding: EdgeInsets.only(left: 20.h, top: 10.h),
                     child: customText(
                         name: "Create an account add to cart "
                             "\nproduct easily and Quickly",
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
                       labelText: "Username",
                       textColor: primaryAshGrey,
                     ),
                   ),
                   SizedBox(height: 10.h,),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 10.h),
                     child: CustomTextFromField(
                       labelText: "Email",
                       textInputType: TextInputType.emailAddress,
                       textColor: primaryAshGrey,
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
                   SizedBox(height: 10.h,),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 10.h),
                     child: CustomTextFromField(
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
                                   controller.show.value = !controller.show.value;
                             },
                           );
                         },
                         color: Color(0xff9E9E9E),
                       ),
                     ),
                   ),
                   // SizedBox(height: 10.h,),
                   // Padding(
                   //   padding: EdgeInsets.symmetric(horizontal: 10.h),
                   //   child: CustomTextFromField(
                   //     labelText: "Confirm Password",
                   //     obscureText: true,
                   //     textInputType: TextInputType.number,
                   //     textColor: primaryGrey,
                   //   ),
                   // ),
                   SizedBox(height: 40.h,),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 10.h),
                     child: CustomButton(
                       process:controller.process.value,
                       name: "Register Now",
                       fontFamily: "PoppinsRegular",
                       fontSize: 22.sp,
                       onTap: () async {
                         controller.process.value = true;
                         if (txtKey.currentState!.validate()) {
                           String msg =   await FirebaseHelper().signUpEmail(txtEmail.text, txtPassword.text);
                           if(msg == "SignUp Successfully"){
                             prefUtil.setLogin(true);
                             Get.toNamed("home");
                             txtEmail.clear();
                             txtPassword.clear();
                             } else{
                             Get.snackbar("Message", "User Already exist...."
                                 "\nPlease enter your Different Email Id",duration: Duration(seconds: 3));
                               }
                            }
                         controller.process.value = false;
                       },
                     ),
                   ),
                   SizedBox(height: 40.h,),
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
                  customText(name: "Already Have An Account ? ",
                      color: primaryAshGrey,
                      fontFamily: "PoppinsRegular",
                      fontSize: 20.sp
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "signin");
                    },
                    child: customText(
                      name: "Log In",
                      fontSize: 20.sp,
                      fontFamily: "PoppinsRegular",
                      color: primaryMitBlue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
            ],
          ),
        ),
      ),
    );
  }
}
