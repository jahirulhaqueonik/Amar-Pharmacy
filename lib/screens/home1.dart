// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amar_pharmacy/screens/login.dart';
import 'package:amar_pharmacy/screens/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/grid_card.dart';
import '../../components/loader.dart';
import '../../models/product.dart';
import '../utils/firestore.dart';
//import 'package:get/get_core/src/get_main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _carouselImages = [];
  Future<List<Product>>? products;
  final _firestoreInstance = FirebaseFirestore.instance;

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

  @override
  void initState() {
    fetchCarouselImage();
    products = FirestoreUtil.getProducts([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    onCardPress(Product product) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductScreen(product: product)));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [

                //CarouselSlider part
                CarouselSlider(
                  options: CarouselOptions(
                      //height: 250.0,
                      autoPlay: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
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
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Covid-19 Special",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                FutureBuilder<List<Product>>(
                    future: products,
                    builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return AspectRatio(
                          aspectRatio: 2,
                          child: GridView.builder(
                              primary: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.length,
                              padding: const EdgeInsets.all(15),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      //  childAspectRatio: 1,
                                      mainAxisSpacing: 0,
                                      crossAxisSpacing: 0),
                              itemBuilder: (BuildContext context, int index) {
                                return GridCard(
                                    product: snapshot.data![index],
                                    index: index,
                                    onPress: () {
                                      onCardPress(snapshot.data![index]);
                                    });
                              }),
                        );
                      } else {
                        return const Center(child: Loader());
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
