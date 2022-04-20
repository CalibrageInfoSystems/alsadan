import 'package:alsadhan/widgets/ResponsiveWidget.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  int maxLength;
  Widget suffixIcon;
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;
  GestureTapCallback onTap;
  FormFieldValidator<String> validator;
  //final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey;

  CustomTextField({
    this.hint,
    this.textEditingController,
    this.keyboardType,
    this.icon,
    this.suffixIcon,
    this.obscureText = false,
    this.maxLength,
    this.onTap,
    this.validator,
    this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large ? 12 : (medium ? 10 : 8),
      child: TextFormField(
          controller: textEditingController,
          keyboardType: keyboardType,
          cursorColor: Colors.purple,
          obscureText: obscureText,
          maxLength: maxLength,
          onTap: onTap,

          // decoration: InputDecoration(
          //   prefixIcon: Icon(icon, color: Colors.redAccent, size: 20),
          //   hintText: hint,
          //   border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(30.0),
          //       borderSide: BorderSide.none),
          // ),

          decoration: InputDecoration(
            labelText: hint,
            counterText: '',
            fillColor: Colors.white,
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(30.0),
              borderSide: new BorderSide(),
            ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: new BorderRadius.circular(30.0),
            //   borderSide: BorderSide(width: 1, color: Colors.red),
            // ),
            //fillColor: Colors.green
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          }),
    );
  }
}
