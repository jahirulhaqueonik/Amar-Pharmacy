// ignore_for_file: prefer_const_constructors

import 'package:amar_pharmacy/widgets/app_icon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/AppColors.dart';
import 'bottom_nav_pages/cart.dart';

class ProductDetails extends StatefulWidget {
  var _product;
  ProductDetails(this._product);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("user-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],
    }).then((value) => print('Added to Cart'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: AppIcon(icon: Icons.arrow_back_ios),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cart()),
              ),
              icon: AppIcon(icon: Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      height: 360.0,
                      //  autoPlay: true,
                      viewportFraction: 1,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          //_dotPosition = val;
                        });
                      }),
                  items: widget._product['product-img']
                      .map<Widget>((item) => Container(
                            padding: EdgeInsets.only(left: 3, right: 3),
                            width: double.maxFinite,
                            //height: 400,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.cover)),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    widget._product['product-name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*Text(
                          widget._product['product-name'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),*/
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 100,
                          width: double.maxFinite,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.redAccent,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15,top: 15,bottom: 0),
                              child: Column(
                              //  crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Price",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12),
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        widget._product['product-price']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0.w),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.grey[300],
                                            ),
                                            child: Row(
                                              children: const [
                                                    Icon(Icons.remove,color: Colors.black,),
                                                    Text("0"),
                                                    Icon(Icons.add,color: Colors.black,),
                                                  ],
                                            ),
                                          )
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () => addToCart(),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            )
                                            //primary: AppColors.bg_red,
                                            //  elevation: 0,
                                            ),
                                        child: Text(
                                          "Add to Cart",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.sp),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.description_rounded,color: Colors.redAccent,),
                            SizedBox(width: 5),
                            Text("Description: ",style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                          ],
                        ),
                        SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            widget._product['product-description'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
