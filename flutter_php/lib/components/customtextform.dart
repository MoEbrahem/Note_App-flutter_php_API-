import 'package:flutter/material.dart';
class CustomTextFormSign extends StatelessWidget {
  final String? hint ;
  final TextEditingController mycontroller;
  final String? Function(String?)? valid ;

  const CustomTextFormSign({super.key, required this.hint, required this.mycontroller,required this.valid});
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 10 ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 1),
            borderRadius: BorderRadius.circular(10)
          )
        ),
      ),
    );
  }
}
