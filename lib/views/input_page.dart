import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_app_with_firestore/constants.dart';
import 'package:simple_app_with_firestore/views/user_details.dart';
import 'package:simple_app_with_firestore/widgets/custom_button.dart';
import 'package:simple_app_with_firestore/widgets/custom_text_field.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String userId = "";
  bool isDataSaved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Form(
          key: Constants.formKey,
          child: Column(children: [
            Image.asset(
              "assets/data.png",
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15),
              //use CustomTextField to ask the user to enter data
              child: CustomTextField(
                  controller: Constants.nameController,
                  label: "Username",
                  prefix: Icons.person),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: CustomTextField(
                  controller: Constants.ageController,
                  label: "Age",
                  prefix: Icons.settings_accessibility),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: CustomTextField(
                  controller: Constants.hobbyController,
                  label: "Favorite Hobby",
                  prefix: Icons.pool),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //use CustomButton to add user data to database
                CustomButton(
                    onPressed: () {
                      if (Constants.formKey.currentState!.validate()) {
                        var db = FirebaseFirestore.instance;
                        final data = {
                          "name": Constants.nameController.text,
                          "age": Constants.ageController.text,
                          "hobby": Constants.hobbyController.text
                        };
                        //add the entered data to database
                        db
                            .collection("users")
                            .add(data)
                            .then((documentSnapshot) {
                          setState(() {
                            isDataSaved = true;

                            userId = documentSnapshot.id;
                          });
                        });
                      }
                    },
                    text: "Submit"),
                //if data is saved in database, the other button will show up
                if (isDataSaved) ...{
                  SizedBox(
                    width: 15,
                  ),
                  //use CustomButton to navigate to second page
                  CustomButton(
                      onPressed: () {
                        if (Constants.formKey.currentState!.validate()) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return UserDetails(
                                userId: userId,
                              );
                            },
                          ));
                          isDataSaved = false;
                          Constants.nameController.clear();
                          Constants.ageController.clear();
                          Constants.hobbyController.clear();
                        }
                      },
                      text: "Next")
                },
              ],
            )
          ]),
        ),
      ),
    ));
  }
}
