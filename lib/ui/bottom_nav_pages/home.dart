// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> _carouselImages = [];
  var _dotPosition = 0;
  final TextEditingController _searchController = TextEditingController();
  fetchCarouselImage()async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img-path"],
        );
        print(qn.docs[i]["img-path"]);
      }
    });
    return qn.docs;
  }
  @override
  void initState() {
    fetchCarouselImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
         child: Container(
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Row(
                children: [
                  Expanded(child: SizedBox(
                    height: 60.h,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(
                            color: Colors.blue
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(
                            color: Colors.grey
                          )
                        ),
                        hintText: "Search Products Here",
                        hintStyle: TextStyle(fontSize: 15.sp),
                        suffixIcon: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.search),
                        ),
                      ),
                  ))),

                 //searchIcon
                 /* GestureDetector(
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      color: Colors.red,
                      child: Center(
                        child: Icon(Icons.search,color: Colors.white),
                      ),
                    ),
                    onTap: (){},
                  )*/

                ],
              ),
            ),
            SizedBox(height: 10.h,),
            AspectRatio(
              aspectRatio: 3.5,
              child: CarouselSlider(items: _carouselImages.map((item) => Padding(
                padding: const EdgeInsets.only(left: 3,right: 3),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(item),fit: BoxFit.fitWidth)
                  ),
                ),
              )).toList(), options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (val, carouselPageChangedReason){
                  setState(() {
                    _dotPosition = val;
                  });
                }
              )),
            ),
            SizedBox(height: 10.h,),
            DotsIndicator(
              dotsCount: _carouselImages.isEmpty?1:_carouselImages.length,
              position: _dotPosition.toDouble(),
              decorator: DotsDecorator(
                activeColor: Colors.orange,
                color: Colors.orange.withOpacity(0.5),
                spacing:EdgeInsets.all(2),
                activeSize: Size(8,8),
                size: Size(6,6)
              ),
            )

          ],
        ),
      )),
    );
  }
}
