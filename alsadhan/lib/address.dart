import 'dart:convert';
import 'package:alsadhan/delivery/settings.dart';
import 'package:alsadhan/home/ProductsScreen.dart';
import 'package:alsadhan/home/home_screen.dart';
import 'package:alsadhan/localdb/LocalDb.dart';
import 'package:alsadhan/models/AreaNamesModel.dart';
import 'package:alsadhan/models/UserInfoModel.dart';
import 'package:alsadhan/services/api_service.dart';
import 'package:alsadhan/widgets/RaisedGradientButton.dart';
import 'package:flutter/material.dart';
import 'package:alsadhan/services/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:toast/toast.dart';

LocalData localData = new LocalData();
TextEditingController landmarkControler = new TextEditingController();
TextEditingController addressControler = new TextEditingController();

String firstName;
String mobileNumber;
String lastName;
String passward;
int selectedAreaId = 0;
String userID;
String userName;
String cityName;
List<ListResultAreaModel> areaNamesArray = [];
ListResultAreaModel selectedcity;
//List<ListResult> deliveryDaysArray = [];

UserInfoModel userInfoModel = new UserInfoModel();
AreaNamesModel cityNamesModel = new AreaNamesModel();

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;
  ApiConnector api = new ApiConnector();

  @override
  void initState() {
    super.initState();
    selectedcity = null;
    getUserInformation();

    // localData.getStringValueSF(LocalData.USER_ID).then((value) {
    //   userID = value;
    //   print("---->>>" + userID);
    // });

    // localData.getStringValueSF(LocalData.USER_FIRSTNAME).then((value) {
    //   firstName = value;
    //   print("==============" + firstName);
    // });

    // localData.getStringValueSF(LocalData.USER_LASTNAME).then((value) {
    //   lastName = value;
    //   print("+++++++++++++++++++" + lastName);
    // });

    // localData.getStringValueSF(LocalData.USER_MOBILENUMBER).then((value) {
    //   mobileNumber = value;
    //   print("---->>>" + mobileNumber);
    // });

    // localData.getStringValueSF(LocalData.USER_PASSWARD).then((value) {
    //   passward = value;
    //   print("---->>>" + passward);
    // });

    // localData.getStringValueSF(LocalData.USER_NAME).then((value) {
    //   userName = value;
    //   print("---->>>" + userName);
    // });
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
          title: Text('Address'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.blue[900],
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Form(
            key: formKey,
            autovalidate: autovalidate,
            child: Container(
              padding: EdgeInsets.only(top: 15.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      enabled: false,
                      initialValue: 'Saudi Arabia',
                      decoration: InputDecoration(
                          labelText: 'Country',
                          // labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      enabled: false,
                      initialValue: 'Riyadh',
                      decoration: InputDecoration(
                          labelText: 'City',
                          // labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(                    
                      alignment: Alignment(0.0, 0.0),                     
                      height: 60.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey)),
                      child: areaNamesArray == null
                          ? Text('')
                          :
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: DropdownButton<ListResultAreaModel>(
                               underline: Container(
                                 decoration: const BoxDecoration(
                                    border: Border(
                                       bottom: BorderSide(
                                        color: Colors.transparent
                                       )
                                    )
                                 )
                               ),
                                isExpanded: true,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 24,
                                ),
                                hint: Text(
                                  "Select Area",
                                  style: TextStyle(color: Color(0xFF9F9F9F)),
                                ),
                                items: areaNamesArray.map((foo) {
                                  return DropdownMenuItem(
                                    value: foo,
                                    child: Text(foo.areaName1),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedcity = value;
                                     selectedAreaId = selectedcity.cityId;
                                  });
                                },
                                value: selectedcity,
                              ),
                           ),
                          // DropdownButton(
                          //     underline: Container(
                          //       decoration: const BoxDecoration(
                          //           border: Border(
                          //               bottom: BorderSide(
                          //                   color: Colors.transparent))),
                          //     ),
                          //     hint: Text("  Select Area"),
                          //     isDense: true,
                          //     isExpanded: true,
                          //     value: selectedcity,
                          //     items: areaNamesArray.map((item) {
                          //       return new DropdownMenuItem(
                          //         child: Text(item.areaName1),
                          //         value: item.areaName1,
                          //       );
                          //     }).toList(),
                          //     onChanged: (newValue) {
                          //       print('---------------->Area ' +
                          //           newValue.toString());
                          //       setState(() {
                          //         selectedcity = newValue;
                          //         selectedAreaId = selectedcity.cityId;

                          //         print('-----City-----------> ' +
                          //             selectedcity.cityId.toString());
                          //       });
                          //     },
                              
                          //   ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: landmarkControler,
                      validator: (value) =>
                          value.isEmpty ? 'Land Mark is required' : null,
                      decoration: InputDecoration(
                          labelText: 'Land Mark',
                          // labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: addressControler,
                      validator: (value) =>
                          value.isEmpty ? 'Full Address is required' : null,
                      decoration: InputDecoration(
                          labelText: 'Full Address',
                          // labelStyle: textStyle,
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
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            // pr.show();
                            if (selectedAreaId != 0) {
                              postAddressApiCalling(context);
                            } else {
                              Toast.show("Please select Area", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            }

                            {
                              //pr.dismiss();
                            }
                            // });
                          } else {
                            autovalidate = true; //enable realtime validation

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

              cityName = userInfoModel.listResult[0].cityName1;
              addressControler.text = userInfoModel.listResult[0].address;
              landmarkControler.text = userInfoModel.listResult[0].landmark;

              firstName = userInfoModel.listResult[0].firstName;
              lastName = userInfoModel.listResult[0].lastName;
              mobileNumber = userInfoModel.listResult[0].contactNumber;
              userName = userInfoModel.listResult[0].userName;
              passward = userInfoModel.listResult[0].password;

              selectedAreaId = userInfoModel.listResult[0].locationId;

              
              //userID = userInfoModel.listResult[0].id;

              print("--- firstname --> " + firstName);
              print("--- lastName --> " + lastName);
              //print("--- userID --> " + userID.toString());

            
              
              // selectedcity = areaNamesArray.firstWhere((are)=> are.cityId == userInfoModel.listResult[0].cityId);
            }
            getAreaNamesAPICalling();
          });
        });
      });
    });
  }

  Future<void> getAreaNamesAPICalling() async {
    var cityName = "Riyadh";
    api.getAreaNames(cityName).then((response) {
      setState(() {
        cityNamesModel = response;
        print(
            '::: Useinformation :::: ' + cityNamesModel.listResult.toString());

        if (cityNamesModel.listResult.length > 0) {
          areaNamesArray = cityNamesModel.listResult;
          selectedcity = areaNamesArray[0];
          // var item = areaNamesArray.singleWhere((item)=> item.cityId == userInfoModel.listResult[0].cityId);
          // print('citymodel :'+item.cityId.toString());

        } else {}
      });
    });
  }
}

Future<int> postAddressApiCalling(BuildContext context) async {
  int code = 101;
  final addressAPI = BASEURL +ADDRESS_URL;
  final headers = {'Content-Type': 'application/json'};

  Map<String, dynamic> body = {
    "Id": userInfoModel.listResult[0].id,
    "FirstName": firstName,
    "MiddleName": null,
    "LastName": lastName,
    "ContactNumber": mobileNumber,
    "UserName": userName,
    "Password": passward,
    "ConfirmPassword": passward,
    "Email": null,
    "Address": addressControler.value.text,
    "Landmark": landmarkControler.value.text,
    "CountryId": 1,
    "CityId": selectedcity.cityId,
    "LocationId": selectedAreaId
  };

  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  print('Request body -->> :' + jsonBody);

  Response response = await post(
    addressAPI,
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
          Navigator.pop(context);
      
      // Scaffold.of(context).showSnackBar(
      //     SnackBar(content: Text(userresponce["EndUserMessage"].toString())));
     
    } else {
      // Scaffold.of(context).showSnackBar(
      //     SnackBar(content: Text(userresponce["EndUserMessage"].toString())));
      Toast.show(userresponce["EndUserMessage"], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  } else {
    print('status code not 200 -- >>');
  }
  return code;
}
