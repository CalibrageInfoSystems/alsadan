import 'dart:convert';
import 'package:alsadhan/SignUp/SignUpScreen.dart';
import 'package:alsadhan/home/home_screen.dart';
import 'package:alsadhan/localdb/LocalDb.dart';
import 'package:alsadhan/services/api_constants.dart';
import 'package:alsadhan/widgets/RaisedGradientButton.dart';
import 'package:alsadhan/widgets/Validator.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

//final globalKey = GlobalKey<ScaffoldState>();
ProgressDialog pr;
bool isArabic = false;

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginScreenState createState() => new _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
   LocalData localData = new LocalData();

  @override
  void initState() {
    super.initState();

    localData.isarabic().then((iseng) {
      setState(() {
        print('************ is Arabic : ' + isArabic.toString());
        isArabic = iseng;
      });
    });

  }
  
  GlobalKey<FormState> _globalKey = GlobalKey();
  bool autovalidate = false;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScaffoldState scaffoldState;
 

  @override
  Widget build(BuildContext context) {

    
    
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
      message:  isArabic == true ? "ارجوك انتظر"  : "Please Wait.." ,
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
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

    final email = TextFormField(
      keyboardType: TextInputType.text,
      controller: userNameController,
      autofocus: false,
      validator: (value) => value.isEmpty ?  isArabic == true ? "اسم المستخدم مطلوب"  : "Username is required"  : null,
      decoration: InputDecoration(
        labelText: isArabic == true ? "اسم المستخدم *" : "Username *" ,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );

    final password = TextFormField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? isArabic == true ? "اسم المستخدم مطلوب"  : "Password is required" : null,
      decoration: InputDecoration(
        labelText: isArabic == true ? "كلمه السر *"  : "Password *" ,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );

    final forgotLabel = FlatButton(
      child: RichText(
        text: new TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: new TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            new TextSpan(text: isArabic == true ? "خلق جديد إبداع جديد "  : "Create New "),
            new TextSpan(
                text: isArabic == true ? "الحساب ?"  : "Account",
                style: new TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignupScreen()));
      },
    );

    return Container(
      child: Scaffold(
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
          title: new Text(isArabic == true ? "تسجيل الدخول" : "Login"),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.blue[900],
        ),
        body: Directionality(textDirection: isArabic == true ? TextDirection.rtl :TextDirection.ltr,
                  child: Center(
            child: Form(
              key: _globalKey,
              autovalidate: autovalidate,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  logo,
                  SizedBox(height: 48.0),
                  email,
                  SizedBox(height: 8.0),
                  password,
                  SizedBox(height: 24.0),
                  RaisedGradientButton(
                      child: Text(isArabic == true ? "تسجيل الدخول" : "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      gradient: LinearGradient(
                        colors: <Color>[Colors.lightBlueAccent, Colors.blue[900]],
                      ),
                      onPressed: () async {
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          bool isNetworkavailable =
                              await Validator.isNetAvailable();
                          if (isNetworkavailable) {
                            
                            loginAPICAllCalling(context);
                          } else {
                            
                            Toast.show(
                                isArabic == true ? "يرجى التحقق من اتصال الإنترنت" : "please check internet connection", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.CENTER);
                          }

                          //               Navigator.push(context,
                          // MaterialPageRoute(builder: (context) => CategoryListScreen()));
                        } else {
                          setState(() {
                            autovalidate = true; //enable realtime validation
                          });
                        }
                      }),
                  forgotLabel
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future loginAPICAllCalling(BuildContext context) async {
    final loginAPI = BASEURL + LOGINURL;
    final headers = {'Content-Type': 'application/json'};

    Map<String, dynamic> body = {
      "UserName": userNameController.value.text,
      "Password": passwordController.value.text
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    print('Request body -->> :' + jsonBody);

    Response response = await post(
      loginAPI,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    //Map<String, dynamic> parsedMAP = json.decode(responseBody);

    print('RES :' + responseBody);
    
    if (statusCode == 200) {
      print('status code 200');
      var userresponce = json.decode(responseBody);
      print('status code 200 -- >> ' + userresponce.toString());

      if (userresponce["IsSuccess"] == true) {
        int userid = userresponce['Result']['UserInfos']['Id'];

        // localData.addStringToSF(LocalData.USERINFO, inputValue)
        localData.addStringToSF(LocalData.USER_FIRSTNAME,
            userresponce['Result']['UserInfos']['Lastname']);
        localData.addStringToSF(LocalData.USER_NAME,
            userresponce['Result']['UserInfos']['UserName']);
        localData.addStringToSF(LocalData.USER_MOBILENUMBER,
            userresponce['Result']['UserInfos']['ContactNumber'].toString());
        localData.addStringToSF(LocalData.USER_LASTNAME,
            userresponce['Result']['UserInfos']['Lastname']);
        localData.addStringToSF(LocalData.USER_PASSWARD,
            userresponce['Result']['UserInfos']['Password']);
        localData.addIntToSF(LocalData.USERID, userid);
        localData.addStringToSF(LocalData.USER_ROLEID,
            userresponce['Result']['UserInfos']['RoleId'].toString());
        localData.addStringToSF(LocalData.USER_ID,
            userresponce['Result']['UserInfos']['Id'].toString());
        print(' -- >> ContactNumber ' +
            userresponce['Result']['UserInfos']['ContactNumber']);
        print(' -- >> ContactNumber ' +
            userresponce['Result']['UserInfos']['Lastname']);

        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => HomeScreen()));
        localData.addBoolToSF(LocalData.ISLOGIN, true);
      } else {
        

        Toast.show(userresponce["EndUserMessage"].toString(), context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            print(' -- >> IsSuccess ' + userresponce["EndUserMessage"].toString());
        
      }
    } else {
      
      print('status code not 200 -- >> + responseBody');
    }
  }

  void _showDialog(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alsadhan"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                pr.dismiss();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
