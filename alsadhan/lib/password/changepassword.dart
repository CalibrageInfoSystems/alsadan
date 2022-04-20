import 'dart:convert';
import 'package:alsadhan/SignUp/SignUpScreen.dart';
import 'package:alsadhan/localdb/LocalDb.dart';
import 'package:alsadhan/login/login.dart';

import 'package:alsadhan/models/ChPasswordModel.dart';
import 'package:alsadhan/models/UserInfoModel.dart';
import 'package:alsadhan/services/api_service.dart';
import 'package:alsadhan/widgets/RaisedGradientButton.dart';
import 'package:alsadhan/widgets/Validator.dart';
import 'package:flutter/material.dart';
import 'package:alsadhan/services/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

LocalData localData = new LocalData();
UserInfoModel userInfoModel = new UserInfoModel();
ProgressDialog pr;

String passward;
String userID;
GlobalKey<FormState> key = new GlobalKey();
TextEditingController oldpasswordController = new TextEditingController();
TextEditingController newpasswordController = new TextEditingController();
TextEditingController conpasswordController = new TextEditingController();

 ChPasswordModel chPasswordModel = new ChPasswordModel();

class ChangePasswordScreen extends StatefulWidget {
  // final GlobalKey<ScaffoldState> scaffoldKey;

  // const ChangePasswordScreen({Key key, this.scaffoldKey}) : super(key: key);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
 
  bool autovalidate = false;
  ApiConnector api = new ApiConnector();
  
  @override
  void initState() {
    super.initState();
    // key = new GlobalKey();
    oldpasswordController.text = "";
    newpasswordController.text = "";
    conpasswordController.text = "";
    chPasswordModel =new ChPasswordModel();
     userInfoModel =new UserInfoModel();
     getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          title: Text('Change Password',),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.blue[900],
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Form(
            key: key,
            autovalidate: autovalidate,
            child: Container(
              padding: EdgeInsets.only(top: 15.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(   
                      controller: oldpasswordController, 
                      obscureText: true,
                      validator: validateOldPassowrd,
                      // (value) =>
                      //     value.isEmpty ? 'Please Enter Old Password' : null,                                      
                      decoration: InputDecoration(
                          labelText: 'Old Password *',
                          // labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: newpasswordController, 
                      validator: validatePassowrd,                                             
                      decoration: InputDecoration(
                          labelText: 'New Password *',
                          // labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(   
                      obscureText: true,
                      
                      controller: conpasswordController, 
                      validator: validatePassowrd,                    
                      decoration: InputDecoration(
                          labelText: 'Confirm Password *',                          
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedGradientButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.lightBlueAccent,
                            Colors.blue[900]
                          ],
                        ),
                        onPressed: () {
                          if (key.currentState.validate()) {
                            key.currentState.save();  
                            //  if(validateData(context)){
                           if(newpasswordController.text==conpasswordController.text)
                             {
                            // pr.show();                            
                             changePasswordApiCalling(context).then((code){
                             oldpasswordController.clear();
                             newpasswordController.clear();
                             conpasswordController.clear();
                             pr.dismiss();
                             });                             
                             } 
                              else {
                   Toast.show("Old Password and New Password Should Match", context,
                   duration: Toast.LENGTH_LONG,
                   gravity: Toast.BOTTOM);
                   }                              
                            }   
                             // });
                           else {
                            autovalidate = true;
                          }
                        }),
                  ),
                ],
              ),
            ),
          )
        ])));
  }

 Future<void> getUserInformation() async {
    await localData.getIntToSF(LocalData.USERID).then((userID) {
      setState(() {
        api.getUserInfo(userID).then((response) {
          setState(() {
            if (response != null) {
              userInfoModel = response;
              print('::: Useinformation :::: ' +
              userInfoModel.listResult.toString());
             
              passward = userInfoModel.listResult[0].password;         

               print("--- PASSWORD --> " + passward);                
            }
           
          });
        });
      });
    });
  }

 }
 
  Future<int> changePasswordApiCalling(BuildContext context) async {
  int code = 101;
  final passwordAPI = BASEURL +CHANGE_PASSWORD;
  final headers = {'Content-Type': 'application/json'};

  Map<String, dynamic> body = {
  "UserId": userInfoModel.listResult[0].userId,
	"OldPassword": oldpasswordController.value.text,
	"NewPassword": newpasswordController.value.text,
	"ConfirmPassword":conpasswordController.value.text
   };

  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  print('Request body -->> :' + jsonBody);

  Response response = await post(
    passwordAPI,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );
  int statusCode = response.statusCode;
  code = statusCode;
  String responseBody = response.body;

  print('RES--------======--------> :' + responseBody);

  if (statusCode == 200) {
    print('status code 200');
    var userresponce = json.decode(responseBody);
    print('status code 200 -- >> ' + userresponce.toString());

    if (userresponce["IsSuccess"] == true) {
      Toast.show(userresponce["EndUserMessage"], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
           Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      
    } else {
      Toast.show(userresponce["EndUserMessage"], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  } else {
    print('status code not 200 -- >>');
  }
  return code;
}

  bool validateData(BuildContext context) {
  if (Validator.validatePasswordLength(
          context, oldpasswordController.value.text) !=
      null) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(Validator.validatePasswordLength(
            context, oldpasswordController.value.text))));
    return false;
    } else if (Validator.validateconfirmPasswordLength(
          context, newpasswordController.value.text) !=
      null) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(Validator.validateconfirmPasswordLength(
            context, newpasswordController.value.text))));
    return false;
  } else if (Validator.validateconfirmPasswordLength(
          context, conpasswordController.value.text) !=
      null) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(Validator.validateconfirmPasswordLength(
            context, conpasswordController.value.text))));

    return false;
  } else if (newpasswordController.text !=
      conpasswordController.text) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
      "New Password And Confirm Password Must Match",
      //'Password And Confirm Password Must Match'
    )));
    return false;
  } else {
    return true;
  }
}

  String validatePassowrd(String value) {
    if(value.isEmpty){
      return 'Password is required';
    }
    else if (value.length < 6)
      return 'Password must be more than 6 charater';   
    else
      return null;
  }

  String validateOldPassowrd(String value) {
    if(value.isEmpty){
      return 'Old Password is required';
    }    
    else if(oldpasswordController.value.text!=userInfoModel.listResult[0].password){
      return 'Incorrect Password';
    }
    else
      return null;
  }

// String validateConPassowrd(String value) {
//     if(value.isEmpty){
//       return 'Field is required';
//     }    
//     else if(newpasswordController.text!=conpasswordController.text){
//       return 'New Password and Old Password Must match';
//     }
//     else
//       return null;
//   }
