import 'package:e_commerce_firebase/app/components/custom_button.dart';
import 'package:e_commerce_firebase/app/components/custom_text.dart';
import 'package:e_commerce_firebase/app/them/color_them.dart';
import 'package:e_commerce_firebase/app/utils/service/firebase_helper.dart';
import 'package:e_commerce_firebase/app/view/add_product_screen/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtImage = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtCategory = TextEditingController();
  String? image;
  String? id = "";

  @override
  void initState() {
    super.initState();
    ProductModel model = Get.arguments;

    txtName = TextEditingController(text: "${model.name}");
    txtPrice = TextEditingController(text: "${model.price}");
    txtDescription = TextEditingController(text: "${model.description}");
    txtCategory = TextEditingController(text: "${model.category}");
    image= model.image;
    id = model.id;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,size: 32.h),
            onPressed: () {
              Get.back();
            },
          ),
          title:
          Text(
            "Shopify",
            style: TextStyle(fontSize: 24.sp, color: Colors.black,fontFamily: "PoppinsRegular"),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 25.h,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                    child: buildTextFormField("Name", txtName, 1),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                    child: buildTextFormField("Image", txtImage, 1),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                    child: buildTextFormField("Price", txtPrice, 1),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                    child: buildTextFormField("Category", txtCategory, 1),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                    child:
                    buildTextFormField("Description,", txtDescription, 4),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.h),
              child: CustomButton(
                  height: 55.h,
                  name: "Update Product",
                  fontFamily: "PoppinsRegular",
                  fontSize: 20.sp,
                  onTap: (){
                    ProductModel model= ProductModel(
                      name: txtName.text,
                      image: txtImage.text,
                      price: txtPrice.text,
                      description: txtDescription.text,
                      category: txtCategory.text,
                      id: id,
                    );
                    FirebaseHelper().updateData(model);
                    Get.back();
                  }
              ),
            ),
            SizedBox(height: 10.h,)
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField(name, text, maxLines) {
    return TextFormField(
      controller: text,
      maxLines: maxLines,
      decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.r)),
            borderSide: BorderSide(color: primaryMitBlue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.r)),
            borderSide: BorderSide(color: primaryMitBlue, width: 2.h),
          ),
          contentPadding: EdgeInsets.all(16.h),
          label: customText(
              name: "Product $name",
              color: primaryGrey,
              fontSize: 18.sp,
              fontFamily: "PoppinsRegular"),
          hintText: "Product $name",
          hintStyle: TextStyle(
              color: primaryAshGrey,
              fontSize: 18.sp,
              fontFamily: "PoppinsRegular"),
      ),
    );
  }
}
