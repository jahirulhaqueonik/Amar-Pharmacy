// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:amar_pharmacy/screens/product_detail_screen.dart';
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
  final List<String> _carouselImages = [];
  var _dotPosition = 0;
  final List _products = [];
  final _firestoreInstance = FirebaseFirestore.instance;

  final TextEditingController _searchController = TextEditingController();
  fetchCarouselImage() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
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

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          //"product-price":qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImage();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                //Home Page Header Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                        ),
                      ),
                      SizedBox(
                        width: 70.w,
                      ),
                      Container(
                        // width: SizeConfig.screenWidth*0.6,
                        width: 375 * 0.6.w,
                        // height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            //TODO Search Value
                          },
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "Search Product",
                              prefixIcon: Icon(Icons.search),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                //Discount Banner Section
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  width: double.infinity,
                  //height: 90,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: "On First Order\n",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      children: [
                        TextSpan(
                          text: "Cashback 15%",
                          style: TextStyle(
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Carousel Slider Section

                CarouselSlider(
                  options: CarouselOptions(
                      //height: 250.0,
                      autoPlay: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      }),
                  items: _carouselImages
                      .map((item) => Padding(
                            padding: EdgeInsets.only(left: 3, right: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.fitWidth)),
                            ),
                          ))
                      .toList(),
                ),
                //Carousel Slider Dot Indicator
                DotsIndicator(
                  dotsCount:
                      _carouselImages.isEmpty ? 1 : _carouselImages.length,
                  position: _dotPosition.toDouble(),
                  decorator: DotsDecorator(
                      activeColor: Colors.red,
                      color: Colors.red.withOpacity(0.5),
                      spacing: EdgeInsets.all(2),
                      activeSize: Size(8, 8),
                      size: Size(6, 6)),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        "Covid-19 Special",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                AspectRatio(
                  aspectRatio: 6 / 3,
                  // height: 500,
                  //color: Colors.blue,
                  child: GridView.builder(
                    //  crossAxisCount: 3,
                    primary: true,
                    padding: const EdgeInsets.all(10),
                    // crossAxisSpacing: 10,
                    // mainAxisSpacing: 10,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: false,
                    itemCount: _products.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetails(_products[index]))),
                        child: Card(
                          elevation: 3,
                          margin: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Center(
                                  child: Builder(builder: (context) {
                                    return AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        //height: 500,
                                        margin: EdgeInsets.all(1),
                                        color: Colors.transparent,
                                        padding: EdgeInsets.all(2),
                                        child: Image.network(
                                          _products[index]["product-img"][0],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    "${_products[index]["product-name"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Center(
                                child: Text(
                                  _products[index]["product-price"].toString(),
                                  //textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 5 / 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
