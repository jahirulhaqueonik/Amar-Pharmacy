import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../utils/custom_theme.dart';

class ListCard extends StatelessWidget {
  final Cart cart;
  ListCard({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 123,
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      decoration: CustomTheme.getCardDecoration(),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: cart.image,
                      fit: BoxFit.cover,
                    ),
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            cart.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Qty: "+cart.count.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "\$ "+cart.price.toString(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
