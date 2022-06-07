import 'package:amar_pharmacy/models/product.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../utils/custom_theme.dart';

class GridCard extends StatelessWidget {
  final int index;
  final void Function() onPress;
  final Product product;
  const GridCard({Key? key, required this.index, required this.onPress, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(top: 5),
        decoration: CustomTheme.getCardDecoration(),

        child: GestureDetector(

          onTap: onPress,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl:product.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )),
                Expanded(flex: 2, child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding:const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Text(
                        product.price.toString(),
                        style: Theme.of(context).textTheme.headlineSmall,)

                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
