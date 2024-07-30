import 'package:e_commerce_firebase/app/components/custom_button.dart';
import 'package:e_commerce_firebase/app/components/custom_text.dart';
import 'package:e_commerce_firebase/app/them/color_them.dart';
import 'package:e_commerce_firebase/app/utils/pref_utils/pref_utils.dart';
import 'package:e_commerce_firebase/app/view/intro_screen/controller/onboarding_controller.dart';
import 'package:e_commerce_firebase/app/view/intro_screen/model/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController pageController = PageController();

  OnboardingController controller = Get.put(OnboardingController());
  PrefUtils prefUtil = PrefUtils();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: OnboardingController().introList.length,
            itemBuilder: (context, index) {
              OnboardingScreenModel data =
              controller.introList[index];
              return Stack(
                children: [
                  Image.asset("${data.image}",fit: BoxFit.fill,width: double.infinity),
                  Padding(
                    padding: EdgeInsets.only(bottom: 140.h),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: customText(name: "${data.title}",fontSize: 26.sp,fontFamily: "PoppinsBold",color: primaryBlack)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 115.h),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: customText(name: "${data.description}",fontSize: 16.sp,fontFamily: "PoppinsLight",color: primaryBlack)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 95.h),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: customText(name: "${data.subDescription}",fontSize: 16.sp,fontFamily: "PoppinsLight",color: primaryBlack)),
                  ),
                ],
              );
            },
            onPageChanged: (value){
              controller.colorChange(value);
            },
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: 22.h,left:30.h,right: 30.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Obx(
                () =>  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                    controller.introList.length,
                          (index) => Padding(
                        padding: EdgeInsets.only(right: 15.h),
                        child: Container(
                          height: 9.h,
                          width:  9.h,
                          decoration: BoxDecoration(
                            color:  controller.change.value == index
                                ? primaryMitBlue
                                : primaryAshGrey,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: CustomButton(
                        name: "Get Started",
                        height: 55.h,
                        fontSize: 20.sp,
                        fontFamily: "PoppinsRegular",
                        onTap: () {
                          prefUtil.setOnboarding(true);
                          Get.toNamed("signin");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
