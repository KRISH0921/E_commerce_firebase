import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase/app/components/custom_button.dart';
import 'package:e_commerce_firebase/app/components/custom_text.dart';
import 'package:e_commerce_firebase/app/them/color_them.dart';
import 'package:e_commerce_firebase/app/utils/service/firebase_helper.dart';
import 'package:e_commerce_firebase/app/view/add_product_screen/model/product_model.dart';
import 'package:e_commerce_firebase/app/view/home_screen/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.usersDetail = FirebaseHelper().userDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: primaryBluishGrey,
                child: Column(
                  children: [
                    SizedBox(height: 20.h,),
                    Center(
                      child: CircleAvatar(
                        radius: 55.r,
                        backgroundColor: primaryWight,
                        backgroundImage: AssetImage("assets/images/person.png"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon:  Icon(
                            Icons.camera,
                            color: primaryAshGrey,
                            size: 28.h,
                          ),
                        ),
                        SizedBox(
                          width: 2.h,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon:  Icon(
                            Icons.photo,
                            color: primaryAshGrey,
                            size: 28.h,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 5.h,top: 25.h),
                child: Icon(Icons.person,color: primaryAshGrey,),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.h,top: 25.h),
                child: Icon(Icons.mail,color: primaryAshGrey,),
              ),

              Padding(
                padding: EdgeInsets.only(left: 5.h,top: 25.h),
                child: Icon(Icons.call,color: primaryAshGrey,),
              ),
              SizedBox(
                height: 100.h,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryMitBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.r))
                      )
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircleAvatar(
                                radius: 35,
                                child: Icon(Icons.admin_panel_settings_outlined),
                              ),
                              const Text(
                                "Firebase App !",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              customText(name: "Are you sure to sign out\n the Firebase app",fontSize: 16.sp,color: primaryAshGrey,textAlign: TextAlign.center),
                              const SizedBox(height: 10),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 30.h),
                                child: CustomButton(
                                    name: "Log Out",
                                    height: 50.h,
                                    fontSize: 20.sp,
                                    fontColor: primaryWight,
                                    onTap: () async {
                                      String msg = await FirebaseHelper().signOut();
                                      if(msg == "LogOut Successfully"){
                                        Get.toNamed("signin");
                                      }else{
                                        Get.snackbar("Message", "LogOut Successfully",duration: Duration(seconds: 3));
                                      }
                                    }
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child:  customText(name: "Log Out",fontSize: 16.sp,color: primaryWight),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title:
          Text(
            "Shopify",
            style: TextStyle(fontSize: 24.sp, color: Colors.black,fontFamily: "PoppinsRegular"),
          ),
          leading: IconButton(onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          }, icon: SvgPicture.asset("assets/images/menu.svg",height: 32.h,)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_rounded,
                size: 30.h,
                color: primaryBlack,
              ),
            ),
          ],
        ),
          body: StreamBuilder(
      stream: FirebaseHelper().selectData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else if (snapshot.hasData) {
          QuerySnapshot<Map<String, dynamic>>? qs = snapshot.data;

          List<ProductModel> productList = [

          ];

          for (var x in snapshot.data!.docs) {
            ProductModel model = ProductModel(
              name: x['name'],
              image: x['image'],
              price: x['price'],
              description: x['description'],
              category: x['category'],
              id: x.id,
            );

            productList.add(model);
          }

          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              print(productList[index].id);
              return Container(
                width: 100.w,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            "${productList[index].image}",
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(
                            width: 15.h,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(name: "${productList[index].name}",fontSize: 20.sp, color: primaryBlack,fontFamily: "PoppinsSemiBold"),
                              customText(name: "₹ ${productList[index].price}",fontSize: 18.sp, color: primaryBlack,fontFamily: "PoppinsRegular"),
                              customText(name: "${productList[index].category}",fontSize: 15.sp, color: primaryBlack,fontFamily: "PoppinsRegular"),

                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5.h,
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              onTap: () {
                                controller.deleteData(productList[index].id);
                              },
                              child:  Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                   Icon(
                                    Icons.delete,
                                    color: primaryBrickRed,
                                  ),
                                   SizedBox(
                                    width: 10.h,
                                  ),
                                   customText(name: "Delete",fontSize:18.sp,fontFamily: "PoppinsRegular"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                Get.toNamed("update",arguments: productList[index]);
                              },
                              child:  Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                   Icon(
                                    Icons.delete,
                                    color: primaryBrickRed,
                                  ),
                                   SizedBox(
                                    width: 10.h,
                                  ),
                                   customText(name: "update",fontSize:18.sp,fontFamily: "PoppinsRegular"),
                                ],
                              ),
                            ),
                          ];
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return  Center(child: CircularProgressIndicator(
          color: primaryWight,
        ));
      },
    ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("product")
;
          },
          child: Container(
            height: 70.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: primaryMitBlue,
                borderRadius: BorderRadius.all(Radius.circular(10.r),
                ),
            ),
            child: Icon(Icons.add,color: primaryWight,size: 38.sp,),
          ),
        ),
      ),
    );
  }
}
