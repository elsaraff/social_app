import 'package:flutter/material.dart';

Widget customTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  Function? validate,
  Function? onSubmit,
  String? label,
  String? hint,
  IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white30, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        validator: (v) {
          validate!(v);
          return null;
        },
        onFieldSubmitted: (s) {
          onSubmit!(s);
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(
            prefix,
            color: Colors.blueGrey,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: Icon(
                    suffix,
                    color: Colors.blueGrey,
                  ),
                )
              : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
