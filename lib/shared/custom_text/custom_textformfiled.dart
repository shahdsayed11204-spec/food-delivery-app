import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextformfiled extends StatefulWidget {
  const CustomTextformfiled({
    super.key,
    required this.hint,
    required this.controller,
    required this.isPassword,
    this.color,
    this.textcolor,
    this.type,
  });

  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final Color ? color;
  final Color ? textcolor;
  final TextInputType ? type;

  @override
  State<CustomTextformfiled> createState() => _CustomTextformfiledState();
}

class _CustomTextformfiledState extends State<CustomTextformfiled> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: widget.controller,
      cursorColor: Colors.black,
      cursorHeight: 20,
      obscureText: _obscureText,
      validator: (value) {
        if(value==null||value.isEmpty){
          return 'please fill ${widget.hint}';
        }
        return null;
      },
      keyboardType: widget.type,
      decoration: InputDecoration(
        suffix: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(CupertinoIcons.eye_slash_fill,color: Colors.white,),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),

        hintText: widget.hint,
        hintStyle: TextStyle(
          color: widget.textcolor??Colors.white
        ),
        fillColor: Colors.transparent,
        filled: true,


      ),
    );
  }
}
