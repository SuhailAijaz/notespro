import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customLargeText({
  required String textValue,
double? fontSize
}){
  return Text(textValue,style: TextStyle(fontSize: fontSize ?? 20,color: Colors.black,
  fontWeight: FontWeight.w600),);
}

Widget customMediumText({
  required String textValue,
  double? fontSize,Color? color
}){
  return Text(textValue,style: TextStyle(fontSize: fontSize ?? 16,color: color ?? Colors.black,
      fontWeight: FontWeight.w500),);
}

Widget customTextField({
  required String hintText,
  String? Function(String?)? validator,
  int? maxLines,
  TextEditingController? controller

}){
  return TextFormField(controller:controller ,
    maxLines:maxLines ?? 1,validator:validator,decoration: InputDecoration(hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),)
  ),);
}

Widget customElevatedButton({
  required void Function()? onTap,required String textValue
}){
  return ElevatedButton(
      onPressed: onTap, child: customMediumText(textValue: textValue));
}


Widget spaceY({required double? height}){
  return SizedBox(height: height);
}

Widget spaceX({required double? width}){
  return SizedBox(width: width);
}