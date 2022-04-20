import 'dart:convert';

import 'package:alsadhan/home/ProfileScreen.dart';
import 'package:alsadhan/home/home_screen.dart';
import 'package:alsadhan/login/login.dart';

import 'package:alsadhan/models/UserModel.dart';
import 'package:alsadhan/services/api_constants.dart';
import 'package:alsadhan/services/api_service.dart';
import 'package:alsadhan/widgets/RaisedGradientButton.dart';
// import 'package:alsadhan/widgets/CustomTextField.dart';
import 'package:alsadhan/widgets/ResponsiveWidget.dart';
import 'package:alsadhan/widgets/Validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

bool isArabic = false;
ApiConnector apiModel;
double _height;
double _width;
double _pixelRatio;
bool _large;
bool _medium;
UserModel userModel;
TextEditingController firstnameController = TextEditingController();
TextEditingController lastnameController = TextEditingController();
TextEditingController fullNameController = TextEditingController();
TextEditingController userNameController = TextEditingController();
TextEditingController contactNumberController = TextEditingController();
TextEditingController passWordController = TextEditingController();
TextEditingController confirmPassWordController = TextEditingController();

GlobalKey<FormState> key = new GlobalKey();
bool autovalidate = false;
ProgressDialog pr;
@override
void initState() {
  apiModel = new ApiConnector();
  userModel = new UserModel();

  
}

class SignupScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
      message: isArabic == true ? "ارجوك انتظر"  : "Please Wait.." ,
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInCirc,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 12.0,
      ),
      messageTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 14.0,
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Colors.blueAccent,
                Colors.blueAccent,
                Colors.blue[900]
              ])),
        ),
        title: new Text(isArabic == true ? "سجل"  : "Sign up"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Directionality( textDirection: isArabic == true ? TextDirection.rtl :TextDirection.ltr,child: SignupScreen1()),
    );
  }
}

class SignupScreen1 extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignupScreen1> {
  @override
  void initState() {
    super.initState();
    key = new GlobalKey();
     localData.isarabic().then((iseng) {
      setState(() {
        print('************ is Arabic : ' + isArabic.toString());
        isArabic = iseng;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              form(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget form(BuildContext context) {
  return Column(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(
            left: _width / 12.0, right: _width / 12.0, top: _height / 50.0),
        child: Form(
          key: key,
          autovalidate: autovalidate,
          child: Column(
            children: <Widget>[
              // logo,
              Image.asset(
                'images/Alsadhan-logo.png',
                height: 120,
              ),
              SizedBox(height: 10), 
              firstnamextField,
              SizedBox(height: 10),
              lastNameTextField,
              SizedBox(height: 10),
              userNameTextFormField,
              SizedBox(height: 10),
              phoneTextFormField,
              SizedBox(height: 10),
              passwordTextFormField,
              SizedBox(height: 10),
              confirmpasswordTextFormField,
              SizedBox(height: 10),
              RaisedGradientButton(
                  child: Text(
                    isArabic == true ? "سجل"  : "Sign up" ,
                    style: TextStyle(color: Colors.white),
                  ),
                  gradient: LinearGradient(
                    colors: <Color>[Colors.lightBlueAccent, Colors.blue[900]],
                  ),
                  onPressed: () {
                    if (key.currentState.validate()) {
                      key.currentState.save();
                      //pr.show();
                      if (validateData(context)) {
                        print(
                            '--- analysis ----- signup validation completed ');
                        signUpAPICAllCalling(context).then((code) {

                          
                          
                          pr.dismiss();
                        });
                      }
                    } else {
                      autovalidate = true; //enable realtime validation

                    }
                  }),
              SizedBox(height: 12),
              loginTextRow(context)
            ],
          ),
        ),
      ),
    ],
  );
}

final logo = Hero(
  tag: 'hero',
  child: CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: 48.0,
    child: Image.asset(
      'images/Alsadhan-logo.png',
      height: 150,
    ),
  ),
);

final firstnamextField = TextFormField(
  controller: firstnameController,
  autofocus: false,
  validator: (value) => value.isEmpty ? isArabic == true ? "الإسم الأول مطلوب"  : "First name is required"  : null,
  decoration: InputDecoration(
    labelText: isArabic == true ? "الاسم الاول *"  : "First name *" ,
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);

final lastNameTextField = TextFormField(
  controller: lastnameController,
  autofocus: false,
  validator: (value) => value.isEmpty ? isArabic == true ? "إسم العائلة مطلوب"  : "Last name is required" : null,
  decoration: InputDecoration(
    labelText: isArabic == true ? "الكنية *"  : "Last name *",
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);

final fullNameTextField = TextFormField(
  controller: fullNameController,
  autofocus: false,
  validator: (value) => value.isEmpty ? isArabic == true ? "الإسم الكامل ضروري"  : "Full name is required" : null,
  decoration: InputDecoration(
    labelText: isArabic == true ? "الاسم بالكامل *"  : "Full name *",
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);

final userNameTextFormField = TextFormField(
  controller: userNameController,
  autofocus: false,
  validator: (value) => value.isEmpty ? isArabic == true ? "اسم المستخدم مطلوب"  : "Username is required" : null,
  decoration: InputDecoration(
    labelText: isArabic == true ? "اسم المستخدم *"  : "Username *",
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);

final phoneTextFormField = TextFormField(
  keyboardType: TextInputType.number,
  controller: contactNumberController,
  autofocus: false,
  validator: (value) => value.isEmpty ? isArabic == true ? "رقم الجوال مطلوب"  : 'Mobile number is required' : null,
  decoration: InputDecoration(
    labelText: isArabic == true ? "رقم الهاتف المحمول *"  : 'Mobile number *',
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);
final passwordTextFormField = TextFormField(
  controller: passWordController,
  obscureText: true,
  autofocus: false,
  validator: (value) => value.isEmpty ? isArabic == true ? "كلمة المرور مطلوبة" : 'Password is required' : null,
  decoration: InputDecoration(
    labelText: isArabic == true ? "كلمه السر *" : 'Password *',
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);
final confirmpasswordTextFormField = TextFormField(
  controller: confirmPassWordController,
  autofocus: false,
  obscureText: true,
  validator: (value) => value.isEmpty ? isArabic == true ? "تأكيد كلمة المرور مطلوب" : 'Confirm password is required' : null,
  decoration: InputDecoration(
    labelText: isArabic == true ? "تأكيد كلمة المرور" : 'Confirm password *',
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);

Widget signUpButton(BuildContext context) {
  return MaterialButton(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        isArabic == true ? "سجل" :  "Sign Up",
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      color: Colors.blue[900],
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () async {
        if (key.currentState.validate()) {
          key.currentState.save();
          
          if (validateData(context)) {
            print('--- analysis ----- signup validation completed ');
            bool isNetworkavailable = await Validator.isNetAvailable();
            if (isNetworkavailable) {
              pr.show();
              signUpAPICAllCalling(context).then((code) {
                pr.dismiss();
              });
            } else {
              Toast.show(isArabic == true ? "يرجى التحقق من اتصال الإنترنت" : "please check internet connection", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            }
          }
        } else {
          autovalidate = true; //enable realtime validation

        }
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );
      });
}

Widget loginTextRow(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: _height / 120.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          isArabic == true ? "هل لديك حساب؟" : "Already have an account?",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => LoginScreen()));
                firstnameController.text = '';
                lastnameController.text = '';
                fullNameController.text = '';
                userNameController.text = '';
                contactNumberController.text = '';
                passWordController.text = '';
                confirmPassWordController.text = '';
            Navigator.of(context).pop();
            print("Routing to Sign up screen");
          },
          child: Text(
            isArabic == true ? "تسجيل الدخول" : "Login",
            style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.blue[900],
                fontSize: _large ? 19 : (_medium ? 17 : 15)),
          ),
        )
      ],
    ),
  );
}

Future<int> signUpAPICAllCalling(BuildContext context) async {
  int code = 101;
  final signUpAPI = BASEURL + SIGNUPURL;
  final headers = {'Content-Type': 'application/json'};

  Map<String, dynamic> body = {
    "Id": 0,
    "FirstName": firstnameController.value.text,
    "MiddleName": null,
    "LastName": lastnameController.value.text,
    "ContactNumber": contactNumberController.value.text,
    "UserName": userNameController.value.text,
    "Password": passWordController.value.text,
    "ConfirmPassword": confirmPassWordController.value.text,
    "Email": null
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  print('Request body -->> :' + jsonBody);

  Response response = await post(
    signUpAPI,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  int statusCode = response.statusCode;
  code = statusCode;
  String responseBody = response.body;

  //Map<String, dynamic> parsedMAP = json.decode(responseBody);

  print('RES :' + responseBody);

  if (statusCode == 200) {
    print('status code 200');
    var userresponce = json.decode(responseBody);
    print('status code 200 -- >> ' + userresponce.toString());
                firstnameController.text = '';
                lastnameController.text = '';
                fullNameController.text = '';
                userNameController.text = '';
                contactNumberController.text = '';
                passWordController.text = '';
                confirmPassWordController.text = '';
    if (userresponce["IsSuccess"] == true) {
// Toast.show(userresponce["IsSuccess"], context,
//                                 duration: Toast.LENGTH_LONG,
//                                 gravity: Toast.BOTTOM);
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(userresponce["EndUserMessage"].toString())));
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
 
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(userresponce["EndUserMessage"].toString())));
    }
  } else {
    print('status code not 200 -- >>');
  }
  return code;
}

bool validateData(BuildContext context) {
  if (Validator.validatefirstnameLength(
          context, firstnameController.value.text ) !=
      null) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(Validator.validatefirstnameLength(
            context, firstnameController.value.text))));
    return false;
  } else if (Validator.validateLstnameLength(
          context, lastnameController.value.text) !=
      null) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(Validator.validateLstnameLength(
            context, lastnameController.value.text))));
    return false;
  } else if (Validator.validateusernameLength(
          context, userNameController.value.text) !=
      null) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(Validator.validateusernameLength(
            context, userNameController.value.text))));
    return false;
  } else if (Validator.validateMobile(
          context, contactNumberController.value.text) !=
      null) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(Validator.validateMobile(
            context, contactNumberController.value.text))));
    return false;
  } else if (Validator.validatePasswordLength(
          context, passWordController.value.text) !=
      null) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(Validator.validatePasswordLength(
            context, passWordController.value.text))));
    return false;
  } else if (Validator.validateconfirmPasswordLength(
          context, confirmPassWordController.value.text) !=
      null) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(Validator.validateconfirmPasswordLength(
            context, confirmPassWordController.value.text))));

    return false;
  } else if (passWordController.value.text !=
      confirmPassWordController.value.text) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
      isArabic == true ? "يجب أن تتطابق كلمة المرور وتأكيد كلمة المرور" : "Password And Confirm Password Must Match",
      //'Password And Confirm Password Must Match'
    )));
    return false;
  } else {
    return true;
  }
}
