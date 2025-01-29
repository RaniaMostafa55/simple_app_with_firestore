import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_app_with_firestore/constants.dart';
import 'package:simple_app_with_firestore/models/user_model.dart';
import 'package:simple_app_with_firestore/widgets/user_detail_item.dart';

class UserDetails extends StatefulWidget {
  final String userId;
  const UserDetails({required this.userId, super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  User data = User();
  //a function to get user data from database
  Future<void> getData() async {
    var db = FirebaseFirestore.instance;
    var userData = await db.collection("users").doc(widget.userId).get();
    data = User.fromFirestore(userData);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Constants.mainColor,
        title: Text(
          "User Details",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/556669/pexels-photo-556669.jpeg?auto=compress&cs=tinysrgb&w=600'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 15),
              child: Text(
                data.name ?? "Loading..",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            //use UserDetailItem to view user info
            UserDetailItem(title: "Name", data: data.name ?? "Loading.."),
            UserDetailItem(title: "Age", data: data.age ?? "Loading.."),
            UserDetailItem(
                title: "Favorite Hobby", data: data.hobby ?? "Loading.."),
          ],
        ),
      ),
    );
  }
}
