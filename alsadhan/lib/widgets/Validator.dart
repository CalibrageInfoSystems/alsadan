import 'dart:io';
import 'package:flutter/material.dart';



class Validator {
 
 static String validateemptyString(BuildContext ctx, String _inputvalue)
 {
   if(_inputvalue.length <1)
   {
     return "Fiels cannot be empty";
     
   }else{
return null;
   } 

 }
 static String validateName(BuildContext ctx, String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Fiels cannot be empty";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

 static String validateMobile(BuildContext ctx, String value) {
   String pattern = r'^(?:(?:\(?(?:00|\+)([1-4]\d\d|[1-9]\d?)\)?)?[\-\.\ \\\/]?)?((?:\(?\d{1,}\)?[\-\.\ \\\/]?){0,})(?:[\-\.\ \\\/]?(?:#|ext\.?|extension|x)[\-\.\ \\\/]?(\d+))?$';
    // String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Mobile number isRequired";
    } else if (value.length < 10 || value.length > 15) {
      return "Mobile number must be 10 to 15 digits";
    } 
    else if (!regExp.hasMatch(value)) {
      return "Mobile number Must be Digits";
    }
    return null;
  }

  static String validatePasswordLength(BuildContext ctx, String value) {
    if (value.length == 0) {
      return "Password can't be Empty";
      
    } else if (value.length < 5) {
      return "Password Must be Longer Than 5 Characters";
    }
    return null;
  }
    static String validateconfirmPasswordLength(BuildContext ctx, String value) {
    if (value.length == 0) {
      return "Confirm Password can't be Empty";
    } else if (value.length < 5) {
      return "Confirm password Must be Longer Than 5 Characters";
    }
    return null;
  }
  static String validatefirstnameLength(BuildContext ctx, String value) {
    if (value.length == 0) {
      return "Full Name Can't be Empty";
    } else if (value.length < 3) {
      return "Full Name must be Longer Than 3 Characters";
    }
    return null;
  }

  static String validateLstnameLength(BuildContext ctx, String value) {
    if (value.length == 0) {
      return "Last Name Can't be Empty";
    } else if (value.length < 3) {
      return "Lst Name must be Longer Than 3 Characters";
    }
    return null;
  }

  static String validateusernameLength(BuildContext ctx,String value) {
    if (value.length == 0) {
      //return "Username Can't be Empty";
      return "Please Enter Username";
    } else if (value.length < 5) {
      return "Username must be Longer Than 5 Characters";
    }
    return null;
  }

  static String validateEmail(BuildContext ctx, String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email"; 
    } else {
      return null;
    }
  }

  static Future<bool> isNetAvailable() async {
    try {
      final result = await  InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
         return true;
      }
    } on SocketException catch (_) {
       return false;
    }
  }


}
