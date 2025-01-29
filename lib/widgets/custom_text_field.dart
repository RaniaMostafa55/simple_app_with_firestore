import 'package:flutter/material.dart';

//a class contains the design of the "textFormField" used in the app
class CustomTextField extends StatelessWidget {
  //the variables required in this class and must send values to them using constructor
  final TextEditingController controller;
  final String label;
  final IconData prefix;
  final void Function()? onSuffixPressed;
  final bool? obscureText;
  final bool isPassword;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefix,
    this.onSuffixPressed,
    this.obscureText = false,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    //returns a "TextFormField" with specific values passed to the class
    return TextFormField(
        //if it's a password field it will check if it's secure or not, else it will be false by default
        obscureText: obscureText!,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: label,
            //if it's a password field an "eye" icon will be added as a suffix icon, otherwise, a "SizedBox" widget will be added which means nothing
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: onSuffixPressed,
                    icon: Icon(
                      //check which icon to add based on the the value of "obscureText" variable which detects if it's secure or not
                      obscureText! ? Icons.visibility : Icons.visibility_off,
                      color: Colors.indigo,
                    ),
                  )
                : const SizedBox(),
            prefixIcon: Icon(
              prefix,
              color: Colors.indigo,
            )),
        validator: (value) {
          if (value!.isEmpty) {
            return "please enter a valid data";
          } else {
            return null;
          }
        });
  }
}
