import 'package:amar_pharmacy/const/AppColors.dart';
import 'package:amar_pharmacy/screens/bottom_nav_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "name": _nameController.text,
          "phone": _phoneController.text,
          "dob": _dobController.text,
          "gender": _genderController.text,
          "age": _ageController.text,
          "address": _addressController.text,
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (_) => BottomNavController())))
        .catchError((error) => print("Something is Wrong"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg_red,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Submit the Form to Continue.",
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Name",
                    hintStyle: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Phone Number",
                    hintStyle: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  controller: _dobController,
                  decoration: InputDecoration(
                    hintText: "Date of Birth",
                    hintStyle: TextStyle(color: Colors.grey[300]),
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: const Icon(Icons.calendar_today_outlined),
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  controller: _genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Choose Your Gender",
                    hintStyle: TextStyle(color: Colors.grey[300]),
                    prefixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Age",
                    hintStyle: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Address",
                    hintStyle: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  width: 1.sw,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      sendUserDataToDB();
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.btn_color,
                      elevation: 3,
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
