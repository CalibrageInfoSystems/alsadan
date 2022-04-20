import 'dart:convert';
import 'package:alsadhan/home/home_screen.dart';
import 'package:alsadhan/localdb/LocalDb.dart';
import 'package:alsadhan/models/MyordersModel.dart';
import 'package:alsadhan/services/api_constants.dart';

import 'package:alsadhan/services/api_service.dart';
import 'package:alsadhan/widgets/RaisedGradientButton.dart';
import 'package:alsadhan/widgets/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'orderDetail_screen.dart';


TextEditingController commentsController = new TextEditingController();
String commentsStr;

class MyOrders extends StatefulWidget {
  
  final void Function(int index) onChanged;
  final int value;
  final IconData filledStar;
  final IconData unfilledStar;

  const MyOrders({
    Key key,
    @required this.onChanged,
    this.value = 0,
    this.filledStar,
    this.unfilledStar,
  })  : assert(value != null),
        super(key: key);
 
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
 
  LocalData localData = new LocalData();
  ApiConnector apiConnector = new ApiConnector();
  MyordersModel myOrders = new MyordersModel();
  String userid;
  String searchingString = 'Fetching Data';
  var formatter = new DateFormat('dd-MM-yyyy HH:mm aa');
  bool noOrdersrightnow = false;
  @override
  void initState() {
    super.initState();
//  localData.getIntToSF(LocalData.USERID).then((userID){
//         setState(() {
//             userid = userID.toString() ;
//         });

//       });
    getorders();
  }

  Future<void> getorders() async {
    await localData.getIntToSF(LocalData.USERID).then((userID) {
      setState(() {
        userid = userID.toString();
        apiConnector.gtOrers(userID, 1, 100).then((myordersData) {
          setState(() {
            myOrders = myordersData;
            searchingString = 'No Orders Available';
            if (myordersData.listResult == null) {
              noOrdersrightnow = true;
            } else {
              noOrdersrightnow = false;
            }
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Colors.blue,
                  Colors.blueAccent,
                  Colors.blue[900]
                ])),
          ),
          title: new Text('My Orders'),
          backgroundColor: Colors.blue[900],
        ),
        body: noOrdersrightnow == true
            ? Center(
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: RaisedGradientButton(
                      width: 200,
                      child: Text(
                        'Start Shopping',
                        style: TextStyle(color: Colors.white),
                      ),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.lightBlueAccent,
                          Colors.blue[900]
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }),
                ),
              )
            : Container(
                color: Colors.black12,
                child: myOrders.listResult == null
                    ? Center(child: Text(searchingString))
                    : ListView.builder(
                        itemCount: myOrders.listResult.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 7,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            OrderDetailViewScreen(
                                                order: myOrders
                                                    .listResult[index])));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Order Id : '),
                                        Text(
                                          myOrders.listResult[index].code
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.blue[900]),
                                        ),
                                      ],
                                    ),
                                      Divider(
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Order Date : '),
                                        Text(
                                          formatter.format(myOrders
                                              .listResult[index].createdDate),
                                          style: TextStyle(
                                              color: Colors.blue[900]),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Delivery Date : '),
                                        Text(
                                          formatter.format(myOrders
                                              .listResult[index].deliveryDate),
                                          style: TextStyle(
                                              color: Colors.blue[900]),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Status :  '),
                                            Text(
                                              myOrders.listResult[index].status,
                                              style: TextStyle(
                                                  color: Colors.blue[900]),
                                            )
                                          ],
                                        ),
                                        Container(
                                            child: myOrders.listResult[index]
                                                        .status ==
                                                    'Processed'
                                                ? RaisedButton(
                                                    color: Colors.blue,
                                                    onPressed: () {
                                                      commentsController.text =
                                                          "";

                                                      onCancelTap(
                                                          context,
                                                          myOrders
                                                              .listResult[index]
                                                              .id,
                                                          myOrders
                                                              .listResult[index]
                                                              .userId, 4);
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                : myOrders.listResult[index]
                                                        .status ==
                                                    'Delivered' ? RaisedButton(
                                                    color: Colors.blue,
                                                    onPressed: () {
                                                      deliveredOrderAPICalling(context, myOrders
                                                              .listResult[index]
                                                              .id, "", myOrders
                                                              .listResult[index]
                                                              .userId, 5);
                                                    },
                                                    child: Text(
                                                      'Deliverd',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                   : Text(''))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })));
  }

  Future<int> cancelOrderAPICalling(
      BuildContext context, int orderID, String commentsStr, int userID, int orderStatusID) async {
    int code = 101;
    final signUpAPI = BASEURL + CANCELORDERURL;
    final headers = {'Content-Type': 'application/json'};

    Map<String, dynamic> body = {
      "OrderId": orderID,
      "StatusTypeId": 4,
      "Comments": commentsStr,
      "UpdatedByUserId": userID,
      "UpdatedDate": DateTime.now().toString()
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

    print('RES :' + responseBody);

    if (statusCode == 200) {
      commentsStr = "";

      print('status code 200');
      var userresponce = json.decode(responseBody);
      print('status code 200 -- >> ' + userresponce.toString());

      if (userresponce["IsSuccess"] == true) {
        getorders();
                    Toast.show("Your orders is sucessfully cancelled", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
        // Scaffold.of(context).showSnackBar(
        //     SnackBar(content: Text("Your orders is sucessfully cancelled")));
      } else {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(userresponce["EndUserMessage"].toString())));
      }
    } else {
      print('status code not 200 -- >>');
    }
    return code;
  }

    Future<int> deliveredOrderAPICalling(
      BuildContext context, int orderID, String commentsStr, int userID, int orderStatusID) async {
    int code = 101;
    final signUpAPI = BASEURL + CANCELORDERURL;
    final headers = {'Content-Type': 'application/json'};

    Map<String, dynamic> body = {
      "OrderId": orderID,
      "StatusTypeId": orderStatusID,
      "Comments": "",
      "UpdatedByUserId": userID,
      "UpdatedDate": DateTime.now().toString()
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

    print('RES :' + responseBody);

    if (statusCode == 200) {
      commentsStr = "";

      print('status code 200');
      var userresponce = json.decode(responseBody);
      print('status code 200 -- >> ' + userresponce.toString());

      if (userresponce["IsSuccess"] == true) {
        getorders();
                    Toast.show("Your orders is sucessfully cancelled", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
        // Scaffold.of(context).showSnackBar(
        //     SnackBar(content: Text("Your orders is sucessfully cancelled")));
      } else {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(userresponce["EndUserMessage"].toString())));
      }
    } else {
      print('status code not 200 -- >>');
    }
    return code;
  }


  void onCancelTap(BuildContext context, int orderID, int userID, int orderStatusID) {
    final color = Theme.of(context).accentColor;
    final size = 36.0;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Reson for Cancel order"),
                Divider(),
                 Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          controller: commentsController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: ' Please enter comments *',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                          ),
                          textInputAction: TextInputAction.newline,
                          maxLines: 1,
                          scrollPhysics: ScrollPhysics(),
                        ),
                      ),
 
               
                Divider(),

                // Divider(
                //   height: 25,
                //   color: Colors.grey,
                // ),
                // Text(
                //   'Are you sure you want to donate blood ?',
                //   style: TextStyle(
                //       color: Colors.black, fontWeight: FontWeight.w500),
                // ),
                // Divider(
                //   height: 25,
                //   color: Colors.grey,
                // ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Colors.red,
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 20),
                  RaisedButton(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text('OK',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400)),
                    onPressed: () {
                      // setState(() {
                      commentsStr = commentsController.value.text;
                      print("--->>>" + commentsStr);

                      if (commentsStr.isEmpty) {
            Toast.show("Please enter comments", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                      } else {
                        cancelOrderAPICalling(
                            context, orderID, commentsStr, userID, 4);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }
}
