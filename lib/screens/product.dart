//import 'package:amar_pharmacy/components/app_icon.dart';
import 'package:amar_pharmacy/components/custom_button.dart';
import 'package:amar_pharmacy/screens/checkout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../utils/app_icon.dart';
import '../utils/application_state.dart';
import '../utils/firestore.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool addButtonLoad = false;

  void onAddToCart() async {
    setState(() {
      addButtonLoad = true;
    });

    await FirestoreUtil.addToCart(
        Provider.of<ApplicationState>(context, listen: false).user,
        widget.product.id);

    //add to cart
    setState((){
      addButtonLoad = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: SizedBox(
                          height: 400,
                          width: double.infinity,
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.product.image),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.headlineLarge!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 22,
                            ),
                            child: Text(
                              widget.product.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                Text(
                                  "MRP: ৳" + widget.product.price.toString(),
                                  style: Theme.of(context).textTheme.titleMedium,
                                )
                              ],
                            ),
                          ),
                          CustomButton(
                            text: "Add to Cart",
                            onPress: onAddToCart,
                            loading: addButtonLoad,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(Icons.description_rounded,
                                  color: Colors.redAccent),
                              const SizedBox(width: 10.0),
                              Text(
                                "Description",
                                style:
                                Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              widget.product.description,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                      icon: const AppIcon(icon: Icons.arrow_back),
                    //  icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
              ],
            ),
            /*Positioned(
              top: 10,
              right: 20,
              child: IconButton(
                icon: const AppIcon(icon: Icons.shopping_bag_outlined),
                //icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CheckoutScreen()),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
