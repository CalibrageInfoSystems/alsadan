import 'dart:convert';

import 'package:alsadhan/cart/cart_screen.dart';

import 'package:alsadhan/localdb/LocalDb.dart';
import 'package:alsadhan/login/login.dart';
import 'package:alsadhan/models/CartModel_data.dart';
import 'package:alsadhan/models/PostCartModel.dart';
import 'package:alsadhan/models/ProductsModel.dart';
import 'package:alsadhan/services/api_service.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

import 'home_screen.dart';

ProgressDialog pr;

class Example extends StatefulWidget {
  String catids;
  String from;
  String searchtext;

  Example({Key key, this.catids, this.from, this.searchtext}) : super(key: key);
  @override
  _MyHomeState createState() => new _MyHomeState();
}

class _MyHomeState extends State<Example> {
  ScrollController controller;
  LocalData localData;
  int uSERIDFROMLOCAL;
  TextEditingController Searchcontroller = new TextEditingController();
  List<String> items = new List.generate(100, (index) => 'Hello $index');
  List<ListResultProduct> products = [];
  List<ListResultProduct> cartProducts = [];
  ApiConnector apiModel;
  var pageNumber = 1;
  var pagesize = 20;
  int totalCount = 0;
  int cartitemcount = 0;
  bool isnomoreproducts = false;
  String parameterPrice = 'Price';
  String parameterASC = 'ASC';
  String hinttext = 'Feching Data..';
  CartModel cartModelfromAPI;
  BuildContext ctx;
  @override
  Future<void> initState() {
    super.initState();
    localData = LocalData();
    apiModel = new ApiConnector();
    controller = new ScrollController()..addListener(_scrollListener);
    if (this.widget.searchtext != null) {
      print('---->> Searching Products');
      getserchproducts(this.widget.searchtext);
      Searchcontroller.text = this.widget.searchtext;
    } else {
      print('---->> Products catids :' + this.widget.catids);
      getProductsAPICall();
    }
    geitemsFromCart();

    localData.getIntToSF(LocalData.USERID).then((userid) {
      uSERIDFROMLOCAL = userid;
      apiModel.getCartInfo(userid).then((cartinfo) {
        setState(() {
          if (cartinfo.result != null) {
            // Do Something ...
            cartModelfromAPI = cartinfo;
            cartitemcount = cartinfo.result.productsList.length;
            for (int i = 0; i < cartinfo.result.productsList.length; i++) {
              cartProducts.add(new ListResultProduct(
                  productId: cartinfo.result.productsList[i].productId,
                  code: cartinfo.result.productsList[i].code,
                  itemCount: cartinfo.result.productsList[i].quantity,
                  price: cartinfo.result.productsList[i].price));
            }
            print('****** items Count *** :' + cartProducts.length.toString());
          }
        });
      });
    });
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
      message: 'Please Wait',
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

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height) / 3;
    final double itemWidth = size.width / 2;
    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = FlatButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      );
      Widget continueButton = FlatButton(
        child: Text("Continue"),
        onPressed: () {
          localData.getBoolValuesSF(LocalData.ISLOGIN).then((islogin) {
            if (islogin == null || !islogin) {
              Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => LoginScreen()));
            } else {
              if (cartProducts.length > 0) {
                PostCartModel cartModel = new PostCartModel();

                if (cartModelfromAPI != null) {
                  cartModel.cart = new CartPostInfo(
                      id: cartModelfromAPI.result.cart.id,
                      userId: cartModelfromAPI.result.cart.userId,
                      name: cartModelfromAPI.result.cart.name);
                } else {
                  cartModel.cart = new CartPostInfo(
                      id: null, userId: uSERIDFROMLOCAL, name: 'cart');
                }
                List<ProductsListModelCart> productsforpost = [];
                for (int i = 0; i < cartProducts.length; i++) {
                  productsforpost.add(new ProductsListModelCart(
                      productId: cartProducts[i].productId,
                      quantity: cartProducts[i].itemCount));
                }
                cartModel.productsList = productsforpost;
                apiModel.postCartUpdate(cartModel).then((cartResponce) {
                  if (cartResponce == 200) {
                    // Navigator.of(context).pushReplacement(
                    //     new MaterialPageRoute(
                    //         builder: (context) =>
                    //             CartItemsScreen()));
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        builder: (context) => HomeScreen()));
                  } else {
                    Toast.show('Unable to Proceed', context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  }
                });
              } else {
                Toast.show('Please Add Atlest One Product', context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              }
            }
          });
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("AlertDialog"),
        content: Text("Are Want to Save Items in Cart ..?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return WillPopScope(
      onWillPop: () {
        if (cartProducts.length > 0) {
          showAlertDialog(ctx);
        } else {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        // showAlertDialog(ctx);
        return Future.value(false);
      },
      child: new Scaffold(
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
            title: new Text('Select Products'),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                if (cartProducts.length > 0) {
                  showAlertDialog(ctx);
                } else {
                  Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => HomeScreen()));
                }
              },
            ),
            backgroundColor: Colors.blue[900],
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 8.0),
                child: Badge(
                  badgeContent: Text(cartitemcount.toString()),
                  child: GestureDetector(
                      onTap: () {
                        // Check user Login Or Not
                        saveCart(context);
                        //  saveallproductsincart(cartProducts);
                      },
                      child: Icon(Icons.add_shopping_cart)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: Icon(Icons.home)),
              )
            ],
          ),
          body: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(8),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.blue[900])),
                          child: new ListTile(
                            // leading: new Icon(Icons.search),
                            title: new TextField(
                              controller: Searchcontroller,
                              decoration: new InputDecoration(
                                  hintText: 'Search', border: InputBorder.none),
                              // onChanged: onSearchTextChanged,
                            ),
                            trailing: new IconButton(
                              icon: new Icon(
                                Icons.search,
                                color: Colors.blue[900],
                              ),
                              onPressed: () {
                                //Searchcontroller.clear();
                                resetCount();
                                getserchproducts(Searchcontroller.value.text);
                              },
                            ),
                          ))),
                  _paddingPopup(),
                ],
              ),
              products == null || products.length == 0
                  ? Center(
                      child: Text(hinttext),
                    )
                  : Expanded(
                      child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (itemWidth / itemHeight),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          controller: controller,
                          padding: const EdgeInsets.all(10.0),
                          children: products.map((value) {
                            return Material(
                              elevation: 10,
                              child: GridTile(
                                  footer: value.itemCount == 0
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: RaisedButton(
                                            textColor: Colors.white,
                                            color: Colors.blue[800],
                                            child: Text('Add'),
                                            onPressed: () {
                                              setState(() {
                                                value.itemCount++;
                                                saveproducts(value);
                                                // updateCartData();
                                              });
                                            },
                                          ))
                                      : Container(
                                          margin: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border: Border.all(
                                                  color: Colors.blue[900])),
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(width: 30, height: 30),

                                              GestureDetector(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.blue[900],
                                                    size: 15,
                                                  ),
                                                ),
                                                onTap: () {
                                                  if (value.itemCount > 0) {
                                                    setState(() {
                                                      value.itemCount--;
                                                      removefromcart(value);

                                                      //updateCartData();
                                                    });
                                                  }
                                                },
                                              ),
                                              // RaisedButton(
                                              //   child: Text('+'),
                                              //   onPressed: () {
                                              //     setState(() {
                                              //       value.itemCount++ ;
                                              //     });
                                              //   },
                                              // ),
                                              SizedBox(width: 20),
                                              Text(value.itemCount.toString()),
                                              SizedBox(width: 20),
                                              GestureDetector(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.blue[900],
                                                    size: 15,
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    value.itemCount++;
                                                    saveproducts(value);
                                                    // updateCartData();
                                                  });
                                                },
                                              ),
                                              // RaisedButton(
                                              //   child: Text('-'),
                                              //   onPressed: () {},
                                              // )
                                            ],
                                          ),
                                        ),
                                  child: GestureDetector(
                                    child: Container(
                                      height: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.white,
                                              spreadRadius: 1),
                                        ],
                                      ),

                                      // color: Colors.grey,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Image(
                                              height: 70,
                                              image:
                                                  NetworkImage(value.filepath),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              value.name1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.blue[900],
                                                  //fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          SizedBox(height: 1),
                                          Divider(),
                                          RichText(
                                            text: new TextSpan(
                                              text: 'SAR : ',
                                              style: new TextStyle(
                                                color: Colors.grey,
                                                decoration: TextDecoration.none,
                                              ),
                                              children: <TextSpan>[
                                                new TextSpan(
                                                  text: value.discountedPrice
                                                      .toString(),
                                                  style: new TextStyle(
                                                    color: Colors.green,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                                new TextSpan(
                                                  text: value.price <
                                                          value.discountedPrice
                                                      ? value.price
                                                      : '',
                                                  style: new TextStyle(
                                                    color: Colors.red,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Text(value.name1),
                                          // Text(value.name1),
                                          // Text(value.name1),
                                          // Text(value.name1),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      // setState(() {});

                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             ProductDetailsScreen(
                                      //                 productsArry: value)));
                                    },
                                  )),
                            );
                          }).toList()),
                    ),
            ],
          )),
    );
  }

  void saveCart(BuildContext context) {
    localData.getBoolValuesSF(LocalData.ISLOGIN).then((islogin) {
      if (islogin == null || !islogin) {
        Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        if (cartProducts.length > 0) {
          PostCartModel cartModel = new PostCartModel();

          if (cartModelfromAPI != null) {
            cartModel.cart = new CartPostInfo(
                id: cartModelfromAPI.result.cart.id,
                userId: cartModelfromAPI.result.cart.userId,
                name: cartModelfromAPI.result.cart.name);
          } else {
            cartModel.cart = new CartPostInfo(
                id: null, userId: uSERIDFROMLOCAL, name: 'cart');
          }
          List<ProductsListModelCart> productsforpost = [];
          for (int i = 0; i < cartProducts.length; i++) {
            productsforpost.add(new ProductsListModelCart(
                productId: cartProducts[i].productId,
                quantity: cartProducts[i].itemCount));
          }
          cartModel.productsList = productsforpost;
          apiModel.postCartUpdate(cartModel).then((cartResponce) {
            if (cartResponce == 200) {
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (context) => CartItemsScreen()));
            } else {
              Toast.show('Unable to Proceed', context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }
          });
        } else {
          Toast.show('Please Add Atlest One Product', context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }
    });
  }

  Widget _paddingPopup() => PopupMenuButton<int>(
        icon: Icon(
          Icons.sort,
          color: Colors.blue[900],
        ),
        onSelected: (val) {
          print('*********** selected value ' + val.toString());
          if (val == 1) {
            parameterASC = 'ASC';
            resetCount();
            getProductsAPICall();
          } else {
            parameterASC = 'DESC';
            resetCount();
            getProductsAPICall();
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: InkWell(
              child: Text(
                "Price Low To High",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: InkWell(
              child: Text(
                "Price High To Low",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
        elevation: 4,
        padding: EdgeInsets.symmetric(horizontal: 3),
      );
  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      setState(() {
        items.addAll(new List.generate(42, (index) => 'Inserted $index'));
        print('***********************************');
        if (Searchcontroller.value.text.isEmpty) {
          if (!isnomoreproducts) {
            pageNumber++;
            getProductsAPICall();
          } else {
            print('***************************** No more Files');
          }
        } else {
          //getserchproducts(Searchcontroller.value.text);
        }
      });
    }
  }

  Future<void> getProductsAPICall() async {
    await apiModel
        .productsAPICall(this.widget.catids, pageNumber, pagesize,
            parameterPrice, parameterASC)
        .then((response) {
      setState(() {
        //print("---->>>>>" + response.toString());
        if (response.listResult != null && response.listResult.length > 0) {
          products.addAll(response.listResult);
        }
        if (response.listResult == null ||
            response.listResult.length < pagesize) {
          isnomoreproducts = true;
        }
        //totalCount = response.affectedRecords;
        totalCount = 56;

        hinttext = 'No Products Available';
      });
    });
  }

  Future<void> getserchproducts(String val) async {
    await apiModel
        .getSearchproducts(
            val, pageNumber, pagesize, parameterPrice, parameterASC)
        .then((response) {
      setState(() {
        products.addAll(response.listResult);
        if (response.listResult.length < pagesize) {
          isnomoreproducts = true;
        }

        //totalCount = response.affectedRecords;
        totalCount = 56;
      });
    });
  }

  void resetCount() {
    setState(() {
      isnomoreproducts = false;
      pageNumber = 1;
      products = [];
    });
  }

  void updateCartData() {
    // saveproducts();
    // getcartitems();

    var productsitems = products.where((item) => item.itemCount > 0).toList();
    setState(() {
      cartitemcount = productsitems.length;
    });
  }

  void saveproducts(ListResultProduct additem) {
    setState(() {
      var items =
          cartProducts.where((p) => p.productId == additem.productId).toList();

      if (items != null && items.length > 0) {
        additem.itemCount = items[0].itemCount;
        cartProducts.removeWhere((item) => item.productId == additem.productId);

        cartProducts.add(additem);
        print('Item Update   (+++)**************************** ID :' +
            additem.productId.toString());
      } else {
        cartProducts.add(additem);
        print('Item Added   (+++)**************************** ID :' +
            additem.productId.toString());
      }

      cartitemcount = cartProducts.length;
    });
  }

  void removefromcart(ListResultProduct removeitem) {
    setState(() {
      var items = cartProducts
          .where((p) => p.productId == removeitem.productId)
          .toList();
      if (items != null && items.length > 0) {
        cartProducts
            .removeWhere((pro) => pro.productId == removeitem.productId);
        if (removeitem.itemCount > 0) {
          cartProducts.add(removeitem);
        } else {
          print("not more than One");
        }
        print('Removed item ');
      } else {
        print('Not exist in list  ');
      }

      cartitemcount = cartProducts.length;
    });
  }

  void makecartnull() {
    cartProducts.clear();
    localData.addStringToSF('cartitem', json.encode(cartProducts));
  }

  List<ListResultProduct> geitemsFromCart() {
    List<ListResultProduct> productsinfo = new List<ListResultProduct>();
    localData.getStringValueSF(LocalData.CARTINFO).then((cartinfo) {
      if (cartinfo.isEmpty) {
      } else {
        print('------> orders String From Local :' + cartinfo);
        productsinfo = placeOrdermodelFromJson(cartinfo);
        setState(() {
          cartProducts = productsinfo;
          cartitemcount = cartProducts.length;
          print('---> Local items Count :' + cartProducts.length.toString());
        });
      }
    });

    return productsinfo;
  }

  List<ListResultProduct> placeOrdermodelFromJson(String str) =>
      List<ListResultProduct>.from(
          json.decode(str).map((x) => ListResultProduct.fromJson(x)));

  void saveallproductsincart(List<ListResultProduct> data) {
    String dataString = placeOrdermodelToJson(data);
    print('------> orders String :' + dataString);
    localData.addStringToSF(LocalData.CARTINFO, dataString);
  }

  String placeOrdermodelToJson(List<ListResultProduct> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
