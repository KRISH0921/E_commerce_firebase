import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase/app/utils/pref_utils/pref_utils.dart';
import 'package:e_commerce_firebase/app/view/add_product_screen/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseHelper {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  PrefUtils prefUtil = PrefUtils();

  User? users = FirebaseAuth.instance.currentUser;

  bool checkUser() {
    User? user = auth.currentUser;
    return user != null;
  }

  Future<String> signInEmail(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      prefUtil.setUid(users!.uid);
      prefUtil.setLogin(true);
      return "SignIn Successfully";
    } catch (e) {
      return "$e";
    }
  }

  Future<String> signUpEmail(email, password) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? users = credential.user;
      print("hello : ${credential.user?.uid.toString()}");
      await FirebaseFirestore.instance.collection('users').doc(users!.uid).set({
        'email': email,
        'password': password,
        'uid': users.uid,
      });
      prefUtil.setUid(users.uid);
      return "SignUp Successfully";
    } catch (e) {
      return "$e";
    }
  }

  Future<String> signOut() async {
    try {
      await auth.signOut();
      return "LogOut Successfully";
    } catch (e) {
      return "$e";
    }
  }

  Map<String, String?> userDetails() {
    User? user = auth.currentUser;

    return {
      "name": user!.displayName,
      "email": user.email,
      "phone": user.phoneNumber,
      "photo": user.photoURL,
    };
  }



  Future<void> insertData(ProductModel model) async {
    String uid = await PrefUtils().getUid();
    firestore.collection("products").add({
      "name": model.name,
      "image": model.image,
      "price": model.price,
      "description": model.description,
      "category": model.category,
      "uid": uid

    });
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> selectData()  {
    return firestore.collection("products").where( "uid",isEqualTo: users!.uid).snapshots();
  }

  void deleteData(id) {
    firestore.collection("products").doc("$id").delete();
  }

  void updateData(ProductModel model) {
    firestore.collection("products").doc("${model.id}").update({
      "name": model.name,
      "price": model.price,
      "category": model.category,
      "description": model.description,
      "image": model.image,
    }).then((_) {
      Get.snackbar("Message","Product successfully updated!",);
    }).catchError((error) {
      print("Error updating document: $error");
    });
  }


}
