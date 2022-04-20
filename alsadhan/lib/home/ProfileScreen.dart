import 'dart:convert';
import 'package:alsadhan/SignUp/SignUpScreen.dart';
import 'package:alsadhan/delivery/settings.dart';
import 'package:alsadhan/home/home_screen.dart';
import 'package:alsadhan/localdb/LocalDb.dart';
import 'package:alsadhan/login/login.dart';
import 'package:alsadhan/models/UserInfoModel.dart';
import 'package:alsadhan/password/changepassword.dart';
import 'package:alsadhan/services/api_constants.dart';
import 'package:alsadhan/services/api_service.dart';
import 'package:alsadhan/widgets/RaisedGradientButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';

TextEditingController userNameController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController landmarkController = TextEditingController();
TextEditingController surnameController = TextEditingController();
TextEditingController mobileNumberController = TextEditingController();
TextEditingController addressController = TextEditingController();
// TextEditingController oldpasswordController = TextEditingController();
// TextEditingController newpasswordController = TextEditingController();
String firstName;
String mobileNumber;
String lastName;
String passward;
String roleID;
String userID;
String userName;
String id;

LocalData localData = new LocalData();

UserInfoModel userInfoModel = new UserInfoModel();
bool isSwitched = true;
ApiConnector api = new ApiConnector();

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
  
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;
  @override
  void initState() {
    super.initState();
    getUserInformation();
    // userNameController.text = "Abcd@gmail.com";
    // genderController.text = "Mr";
    // languageController.text = "English";

    // localData.getStringValueSF(LocalData.USER_NAME).then((value) {
    //   userName = value;      
    //   setState(() {
    //     userNameController.text = value;
    //     print("==============" + value);
    //   });
    // });

    // localData.getStringValueSF(LocalData.USER_FIRSTNAME).then((value) {    
    //    firstName = value;
    //   setState(() {
    //     nameController.text = value;
    //     print("+++++++++++++++++++ firstname " + firstName);
    //   });
    // });

    // localData.getStringValueSF(LocalData.USER_LASTNAME).then((value) {      
    //   // print("---->>>" + lastName);
    //   setState(() {
    //     surnameController.text = value;
    //     // print("---->>>" + mobileNumber);
    //   });
    // });

    // localData.getStringValueSF(LocalData.USER_MOBILENUMBER).then((value) {    
    //   setState(() {
    //     mobileNumberController.text = value;        
    //   });
    // });
    
    // localData.getStringValueSF(LocalData.USER_PASSWARD).then((value) {    
    //   passward = value;
    //   setState(() {
    //     print("---->>> Password" + passward);     
    //   });
    // });

    // localData.getStringValueSF(LocalData.USER_ROLEID).then((value) {
    //   roleID = value;
    //   print("---->>>" + roleID);

    //   setState(() {
    //     print("---->>>" + roleID);
    //   });
    // });

    // localData.getIntToSF(LocalData.USERID).then((value) {
    //   userID = value.toString();
    //   print("---->>>" + userID);

    //   setState(() {
    //     print("---->>>" + userID);
    //   });
    // });


  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
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
          title: Text("My Profile"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pushReplacement(
                new MaterialPageRoute(builder: (context) => HomeScreen())),
          )),
      body: SingleChildScrollView(
        child: 
    Column(
      children: <Widget>[
        Form(
          key: formKey,
          autovalidate: autovalidate,
          child: Container(  
                  padding: EdgeInsets.only(left: 30, right: 30),  
                  child: Column(children: <Widget>[  
                    SizedBox(height: 50),  
                    emailTextField(),  
                    SizedBox(height: 15),  
                    nameTextField(),  
                    SizedBox(height: 15),  
                    surNameTextField(),  
                    SizedBox(height: 15),  
                    mobileNumberTextField(),  
                    SizedBox(height: 15),  
                    // oldpasswordTextField(),  
                    // SizedBox(height: 15),  
                    // newpasswordTextField(),  
                    // SizedBox(height: 15),
                    updateButton(context),
                    SizedBox(height: 15), 
                    changePasswordButton(context), 
                  ])),
    )
      ],
    ),

      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.transparent,
      //   child: updateButton(context),
      // ),
    ));
  }

  emailTextField() {
    final username = TextFormField(
      keyboardType: TextInputType.text,
      controller: userNameController,
      autofocus: false,
      enabled: false,
      decoration: InputDecoration(
        hintText: 'User Name *',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.account_circle),
      ),
    );

    return username;
  }

  nameTextField() {
    final name = TextFormField(
      keyboardType: TextInputType.text,
      controller: nameController,
      autofocus: false,
      validator: validateFirstName,
      //enabled: false,
      decoration: InputDecoration(
        hintText: 'First Name *',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.account_circle),
      ),
    );

    return name;
  }

  surNameTextField() {
    final surName = TextFormField(
      keyboardType: TextInputType.text,
      controller: surnameController,
      autofocus: false,
      validator: validateLastName,
      // (value) => value.isEmpty ? 'Last name is required' : null,
      //enabled: false,
      decoration: InputDecoration(
        hintText: 'Last Name *',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.account_circle),
      ),
    );
    return surName;
  }

  landmarkTextField() {
    final gender = TextFormField(
      keyboardType: TextInputType.text,
      controller: landmarkController,
      autofocus: false,
      //enabled: false,
      decoration: InputDecoration(
        hintText: 'Landmark',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.group),
      ),
    );
    return gender;
  }

  mobileNumberTextField() {
    final mobileNumber = TextFormField(
      keyboardType: TextInputType.number,
      controller: mobileNumberController,
      autofocus: false,
      //enabled: false,
      validator: validateMobile,
      decoration: InputDecoration(
        hintText: 'Mobile number *',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.call),
      ),
    );
    return mobileNumber;
  }

  // oldpasswordTextField() {
  //   final oldpassword = TextFormField(
  //     keyboardType: TextInputType.text,
  //     controller: oldpasswordController,
  //     autofocus: false,
  //     //enabled: false,
  //     validator: (value) => value.isEmpty ? 'Old Password is required' : null,
  //     decoration: InputDecoration(
  //       hintText: 'Old password',
  //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
  //       prefixIcon: Icon(Icons.vpn_key),
  //     ),
  //   );
  //   return oldpassword;
  // }

  // newpasswordTextField() {
  //   final newpassword = TextFormField(
  //     keyboardType: TextInputType.text,
  //     controller: newpasswordController,
  //     autofocus: false,
  //     //enabled: false,
  //     validator: (value) => value.isEmpty ? 'New Password is required' : null,
  //     decoration: InputDecoration(
  //       hintText: 'New Password',
  //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
  //       prefixIcon: Icon(Icons.vpn_key),
  //     ),
  //   );
  //   return newpassword;
  // }

  addressTextField() {
    final language = TextFormField(
      keyboardType: TextInputType.text,
      controller: addressController,
      autofocus: false,
     // enabled: false,
      decoration: InputDecoration(
        hintText: 'Address',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.language),
      ),
    );
    return language;
  }

  subscribeemail() {
    bool isSwitched = true;
    Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
        });
      },
      activeTrackColor: Colors.lightGreenAccent,
      activeColor: Colors.green,
    );
  }

changePasswordButton(BuildContext context){
    return Container(     
      child: FlatButton(          
      color: Colors.transparent,     
        child: Text('Change Password', 
        style: new TextStyle(
            fontSize: 14.0,
            color: Colors.blueAccent,
          ),
        ),
        onPressed: () {           
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
        );     
         
        },
      ),
    );
  }

  updateButton(BuildContext context){
    return Container(
      // padding: EdgeInsets.all(8),
      child: RaisedGradientButton(
        // padding: EdgeInsets.all(12),  
        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.lightBlueAccent,
                            Colors.blue[900]
                          ],
                        ),      
        child: Text('Update', style: TextStyle(color: Colors.white)),
        onPressed: () {
           if (formKey.currentState.validate()) {
                            formKey.currentState.save();
          //Navigator.of(context).pop();
          // if(oldpasswordController.text==userInfoModel.listResult[0].password)
          // {
            updateProfileAPICAlling(context);
          //   oldpasswordController.clear();
          //   newpasswordController.clear();
          // }
          // else {
          //          Toast.show("Please Enter Correct Old Password", context,
          //          duration: Toast.LENGTH_LONG,
          //          gravity: Toast.BOTTOM);
          //          }          
           }
           else{
             autovalidate = true;
           }
        },
      ),
    );
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
              userNameController.text = userInfoModel.listResult[0].userName;
              nameController.text = userInfoModel.listResult[0].firstName;
              surnameController.text = userInfoModel.listResult[0].lastName;
              mobileNumberController.text = userInfoModel.listResult[0].contactNumber;
              surnameController.text = userInfoModel.listResult[0].lastName;
              // mobileNumberController.text = userInfoModel.listResult[0].contactNumber; 
              passward = userInfoModel.listResult[0].password;

              //userID = userInfoModel.listResult[0].id;

              print("--- firstname --> " + firstName);
              print("--- lastName --> " + lastName);
              //print("--- userID --> " + userID.toString());
                          
              // selectedcity = areaNamesArray.firstWhere((are)=> are.cityId == userInfoModel.listResult[0].cityId);
            }
           
          });
        });
      });
    });
  }

}


Future<void> updateProfileAPICAlling(BuildContext context) async {
  final updateprofileURL = BASEURL + UPDATEPROFILE;

  //MyordersModel productsModel = new MyordersModel();
  print('*************API CALL :' + updateprofileURL);

  final headers = {'Content-Type': 'application/json'};

  Map<String, dynamic> body = {
    "Id": userInfoModel.listResult[0].id,
    "UserId":userInfoModel.listResult[0].userId,
    "FirstName": nameController.value.text,
    "MiddleName": null,
    "LastName": surnameController.value.text,
    "FullName":userInfoModel.listResult[0].fullName,    
    "UserName": userInfoModel.listResult[0].userName,
    "ContactNumber": mobileNumberController.value.text,
    "Password": userInfoModel.listResult[0].password,
    "RoleId": userInfoModel.listResult[0].roleId,
    "RoleName":userInfoModel.listResult[0].roleName,
    "Email": null,
    "CreatedByUserId": null,
    "CreatedDate": userInfoModel.listResult[0].createdDate.toString(),
    "UpdatedByUserId": null,
    "UpdatedDate": DateTime.now().toString(),
    "Address": userInfoModel.listResult[0].address,
    "Landmark": userInfoModel.listResult[0].landmark,
    "CountryId": userInfoModel.listResult[0].countryId,
    "CityId": userInfoModel.listResult[0].cityId,
    "LocationId": userInfoModel.listResult[0].locationId
  };

  print('*************API CALL :' + body.toString());

  String jsonBody = json.encode(body);
  print('*************API CALL :' + updateprofileURL);
  print('*************API CALL :' + jsonBody);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    updateprofileURL,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  int statusCode = response.statusCode;
  String responseBody = response.body;

  if (statusCode == 200) {
    var userresponce = json.decode(responseBody);
    //productsModel = MyordersModel.fromJson(userresponce);

    print('::: User Profile Status :::: Success : 200');
    print('::: User Profile Response :::: ' + userresponce.toString());
    Toast.show(userresponce["EndUserMessage"], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      Navigator.pop(context);

    //return productsModel;
  } else {
    print('::: placeOrder Response :::: error : ');
    return null;
  }
}

 String validateFirstName(String value) {
    if(value.isEmpty){
      return 'First Name is required';
    }
    else if (value.length < 3)
      return 'First Name must be more than 3 charater';   
    else
      return null;
  }

  String validateLastName(String value) {
    if(value.isEmpty){
      return 'Last Name is required';
    }
    else if (value.length < 3)
      return 'Last Name must be more than 3 charater';   
    else
      return null;
  }

  String validateMobile(String value) {
    if(value.isEmpty){
      return 'Mobile Number is required';
    }    
    else if((value.length < 10) || (value.length > 15)){
      return 'Mobile Number must betwen 10 to 15 digits';
    }
    else
      return null;
  }
