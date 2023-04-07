import 'package:flutter/material.dart';

class CustomizedTextfield extends StatefulWidget {
  final TextEditingController myController;
  final String? hintText;
  final bool? isPassword;
  const CustomizedTextfield({
    Key? key,
    required this.myController,
    this.hintText,
    this.isPassword,
  }) : super(key: key);

  @override
  CustomizedTextfieldState createState() => CustomizedTextfieldState();
}

class CustomizedTextfieldState extends State<CustomizedTextfield> {
  // hide contect using _obscureText.
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // adding padding to textField.
      padding: const EdgeInsets.all(10.0), //10
      child: TextField(
        // if it is a password change the keyboardType.
        keyboardType: widget.isPassword!
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        // if isPassword is true, disable suggestions, otherwise suggest.
        enableSuggestions: widget.isPassword! ? false : true,
        // if isPassword is true, disable autocorrect.
        autocorrect: widget.isPassword! ? false : true,
        // if isPassword is true, obscureText. otherwise show content.
        obscureText: widget.isPassword! ? _obscureText : !_obscureText,
        // set controller.
        controller: widget.myController,
        // input decoration.
        decoration: InputDecoration(
          // if isPassword is true, then show the icon to show and hide password.
          // otherwise show nothing.
          suffixIcon: widget.isPassword!
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  // if this password show/hide button pressed,
                  onPressed: () {
                    setState(() {
                      widget.isPassword!
                          ? _obscureText = !_obscureText
                          : _obscureText = _obscureText;
                    });
                  },
                )
              : null,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffe8ecf4), width: 1),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffe8ecf4), width: 1),
              borderRadius: BorderRadius.circular(10)),
          fillColor: const Color(0xffe8ecf4),
          filled: true,
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
