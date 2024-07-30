import 'package:e_commerce_firebase/app/view/intro_screen/model/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class OnboardingController extends GetxController{
  RxInt currentIndex = 0.obs;

  List<OnboardingScreenModel> introList = <OnboardingScreenModel>[
    OnboardingScreenModel(
      image:"assets/images/OnboardingOne.png",
      title: "Purchase Online !!",
      description: "Lorem ipsum dolor sit amet, consectetur,",
      subDescription: "sed do eiusmod tempor ut labore"
    ),
    OnboardingScreenModel(
      image:"assets/images/OnboardingTwo.png",
      title: "Track order !!",
      description: "Lorem ipsum dolor sit amet, consectetur,",
      subDescription: "sed do eiusmod tempor ut labore"
    ),
    OnboardingScreenModel(
      image:"assets/images/OnboardingThree.png",
      title: "Get your order !!",
      description: "Lorem ipsum dolor sit amet, consectetur,",
      subDescription: "sed do eiusmod tempor ut labore"
    ),
  ];

  RxInt change = 0.obs;
  void colorChange(int value){
    change.value = value;
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}