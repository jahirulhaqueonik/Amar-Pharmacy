// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amar_pharmacy/screens/bottom_nav_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {


  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
          ),  onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavController()),
        ),
        ),
      ),

      /*body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children:<Widget> [
            Text("Shopping Cart",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21.0,
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20.0),
              ),

            )
          ],
        ),*/

        body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user-cart-items")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something is Wrong"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
                return Card(
                  elevation: 3,

                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(_documentSnapshot['name']),
                    ),
                    title: Text(
                      "\৳ ${_documentSnapshot['price']}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    trailing: GestureDetector(
                      child: CircleAvatar(
                        child: Icon(Icons.remove_circle),
                      ),
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection("user-cart-items")
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("items")
                            .doc(_documentSnapshot.id)
                            .delete();
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
