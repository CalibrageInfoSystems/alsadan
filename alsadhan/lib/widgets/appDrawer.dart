import 'package:alsadhan/allcategories/allcategories_screen.dart';
import 'package:alsadhan/cart/cart_screen.dart';
import 'package:alsadhan/home/home_screen.dart';
import 'package:alsadhan/localdb/LocalDb.dart';
import 'package:alsadhan/localization/app_translations.dart';
import 'package:alsadhan/localization/application.dart';
import 'package:alsadhan/login/login.dart';
import 'package:alsadhan/myorders/myorder_screen.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';



ProgressDialog progressDialog;

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  LocalData localData = new LocalData();

  bool islogin = false;
  String username = '';
  String mobilenumber = '';
  @override
  void initState() {
    super.initState();
    localData.getBoolValuesSF(LocalData.ISLOGIN).then((islogindata) {
      setState(() {
        if (islogindata != null) {
          islogin = islogindata;
          if (islogin) {
            localData.getStringValueSF(LocalData.USER_NAME).then((name) {
              setState(() {
                username = name;
              });
            });
            localData
                .getStringValueSF(LocalData.USER_MOBILENUMBER)
                .then((mobile) {
              setState(() {
                mobilenumber = mobile;
              });
            });
          }
        } else {
          islogindata = false;
        }
      });
    });

            progressDialog =
        new ProgressDialog(context, type: ProgressDialogType.Normal);

    progressDialog.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.black54,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInCubic,
      progressTextStyle: TextStyle(
          color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.white,
              Colors.grey[200],
              Colors.blue[200],
              Colors.blue[400],
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => AllCategoriesScreennew()));
                },
                child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 2, color: Colors.blue[900])),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'ALL CATEGORIES',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ),
                        Image(
                          height: 30,
                          image: AssetImage('images/right.png'),
                        )
                      ],
                    )),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.blue[900]),
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.blue[900]),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (context) => HomeScreen()));
                },
                // onTap: () {
                //   Navigator.of(context)
                //       .pushReplacementNamed(Constants.HOME_SCREEN);
                // },
              ),
             islogin == true? Column(children: <Widget>[
               Divider(),
               ListTile(
                leading: Icon(Icons.add_shopping_cart, color: Colors.blue[900]),
                title: Text(
                  'Cart',
                  style: TextStyle(color: Colors.blue[900]),
                ),
                onTap: () {
                     Navigator.of(context).pushReplacement(new MaterialPageRoute(
                                builder: (context) => CartItemsScreen(
                                     
                                    )));
                },// onTap: () {
                //   Navigator.of(context)
                //       .pushReplacementNamed(Constants.HOME_SCREEN);
                // },
              ),
              Divider(),
              ],): Text(''),
             
             
              Container(
                  child: islogin == true
                      ? ListTile(
                          onTap: () {
                             Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                              builder: (context) => MyOrders()));
                          },
                          title: Text('My Orders',
                              style: TextStyle(color: Colors.blue[900])),
                          leading: Icon(Icons.person, color: Colors.blue[900]),
                        )
                      : Text('')),
              Container(
                
                child: islogin == true ? Divider() : Text(''),
              ),
              Container(
                  child: islogin == true
                      ? ListTile(
                          onTap: () {
                            // Navigator.of(context).pushReplacement(
                            //     new MaterialPageRoute(
                            //         builder: (context) => ProfileScreen()));
                          },
                          title: Text(username,
                              style: TextStyle(color: Colors.blue[900])),
                          leading: Icon(Icons.person, color: Colors.blue[900]),
                        )
                      : Text('')),
              Container(
                  child: islogin == true
                      ? ListTile(
                          title: Text(mobilenumber,
                              style: TextStyle(color: Colors.blue[900])),
                          leading: Icon(Icons.phone_android,
                              color: Colors.blue[900]),
                        )
                      : Text('')),
              Divider(),
              Container(
                              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text( "Language"
                  //AppTranslations.of(context).text("key_Language"),
                ),
                onTap: () {
                  // Navigator.pop(context);
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext bc) {
                        return Container(
                          child: new Wrap(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                     
                                      setState(() {
                                        localData.addBoolToSF(LocalData.IS_ARABIC, false);
                                       
                                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                                      });
                                  
                                    },
                                    child: Container(
                                      width: 300,
                                      child: Card(
                                          elevation: 5,
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'English',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ))),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                       
                                      setState(() {

                                        localData.addBoolToSF(LocalData.IS_ARABIC, true);
                                       
                                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                                      
                                      });
                                    },
                                    child: Container(
                                      width: 300,
                                      child: Card(
                                          elevation: 5,
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'Arabic',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ))),
                                    ),
                                  ),
                                  
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 300,
                                      child: Card(
                                          elevation: 5,
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.red),
                                            ),
                                          ))),
                                    ),
                                  ),
                                ],
                              ),
    
                            ],
                          ),
                        );
                      });
                },
            ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      Colors.blue,
                      Colors.blue[500],
                      Colors.blue[700],
                      Colors.blue[900],
                    ],
                  ),
                ),
                child: ListTile(
                  leading: Icon(Icons.person, color: Colors.white),
                  title: Text(
                    islogin == false ? 'Login/Register' : 'LogOut',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    if (islogin) {
                     // localData.clearLocalDta();
                      localData.addBoolToSF(LocalData.ISLOGIN, false);
                     // localData.clearLocalDta();
                      Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    } else {
                      localData.addBoolToSF(LocalData.ISLOGIN, false);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    }
                  },
                  // onTap: () {
                  //   Navigator.of(context)
                  //       .pushReplacementNamed(Constants.HOME_SCREEN);
                  // },
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

}
