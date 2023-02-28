import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  final String hint;
  final bool isReadOnly;
  final Icon? icon;
  final TextEditingController? controller;
   final String? Function(String?)? validate ;
   final Function()? onTap;


   const InputField({
  super.key,
  required this.hint,
  this.icon,
  this.controller,
  required this.isReadOnly,
  required this.validate ,
   this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: TextFormField(
        onTap: onTap,
        validator: validate,
        readOnly: isReadOnly ? true : false,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          icon: icon,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
