import 'package:e_commerce_firebase/app/utils/service/firebase_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  Map? usersDetail;

  void deleteData(id){
    FirebaseHelper().deleteData(id);
    update();
  }
}
