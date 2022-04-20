import 'dart:convert';

import 'package:alsadhan/allcategories/allcategories_screen.dart';
import 'package:alsadhan/cart/PlaceOrdermodelLocalModel.dart';
import 'package:alsadhan/cart/cart_screen.dart';
import 'package:alsadhan/delivery/settings.dart';

import 'package:alsadhan/localdb/LocalDb.dart';
import 'package:alsadhan/models/homecategoryitemsmodel.dart';
import 'package:alsadhan/services/api_service.dart';
import 'package:alsadhan/widgets/appDrawer.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'FlutterExample.dart';
import 'catogory_list_screen.dart';

bool isUserLogin = false ;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ItemModel> items = new List<ItemModel>();
  List<String> bannerslist = new List<String>();
  TextEditingController controller = new TextEditingController();
  LocalData localData = new LocalData();
  ApiConnector api;
  int productsCount = 0;
  @override
  void initState() {
    super.initState();
    api = new ApiConnector();
    items.add(new ItemModel(id: 0, name: 'Hot Deals', bannerurl: 'url'));
    items.add(new ItemModel(id: 1, name: 'FRESH', bannerurl: 'url'));
    items
        .add(new ItemModel(id: 38, name: 'Food & Beverages', bannerurl: 'url'));
    items.add(new ItemModel(id: 97, name: 'Healthy Living', bannerurl: 'url'));
    items
        .add(new ItemModel(id: 115, name: 'Health & Beauty', bannerurl: 'url'));
    items.add(new ItemModel(id: 164, name: 'HouseHold', bannerurl: 'url'));
    items.add(new ItemModel(id: 217, name: 'Baby', bannerurl: 'url'));
    items.add(new ItemModel(id: 228, name: 'Pets', bannerurl: 'url'));

    bannerslist.add('images/fresh_food.jpg');
    bannerslist.add('images/frozen_food.jpg');
    bannerslist.add('images/non_food.jpg'); //others
    //  bannerslist.add('images/others.jpg');  //others

    List<PlaceOrdermodelLocalModel> placeorderlist =
        new List<PlaceOrdermodelLocalModel>();
    placeorderlist.add(new PlaceOrdermodelLocalModel(
        productId: 123, price: 25.5, quantity: 10));
    placeorderlist.add(new PlaceOrdermodelLocalModel(
        productId: 124, price: 20.5, quantity: 12));
    placeorderlist.add(new PlaceOrdermodelLocalModel(
        productId: 125, price: 29.5, quantity: 7));

    localData.getBoolValuesSF(LocalData.ISLOGIN).then((islogindata) {

      isUserLogin = islogindata;
      localData.getIntToSF(LocalData.USERID).then((userid) {
        api.getCartInfo(userid).then((cartinfo) {
          setState(() {
            if(cartinfo.result != null){
   productsCount = cartinfo.result.productsList.length;
            }
            
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.blue[900]),
          backgroundColor: Colors.white,
          title: Image(
            height: 45,
            image: AssetImage("images/sadhan_land.png"),
          ),
          actions: <Widget>[
            isUserLogin == true ? 
            IconButton(
              icon: Icon(
                Icons.settings,
                size: 25.0,
                color: Colors.blue[800],
              ),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen())),
            ) : Text("")
          ],
        ),
        drawer: AppDrawer(),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 20, right: 20),
          child: FloatingActionButton(
              elevation: 8,
              backgroundColor: Colors.blue[800],
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => CartItemsScreen(
                                     
                                    )));
              },
              child: Badge(
                badgeColor: Colors.red,
                badgeContent: Text(
                  productsCount.toString(),
                  style: TextStyle(fontSize: 12),
                ),
                child: Icon(
                  Icons.add_shopping_cart,
                  size: 30,
                ),
              )),
        ),
        body: Directionality(textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Colors.blue[900])),
                    height: 50,
                    child: new ListTile(
                      // leading: new Icon(Icons.search),
                      title: new TextField(
                        controller: controller,
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
                          // controller.clear();
                          // onSearchTextChanged('');
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => Example(
                                    from: 'SEARCH',
                                    catids: null,
                                    searchtext: controller.value.text,
                                  )));
                        },
                      ),
                    )),
                    
                Container(
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) =>
                                CategoryListScreen(focusposition: 1)));
                      },
                      child: Image(
                        image: AssetImage("images/main_banner.jpg"),
                      ),
                    )),
                    Container(
              width:380,
              height: 40,
  decoration: BoxDecoration(
  color: Colors.blue[900],
  
),

child: Padding(
  padding: const EdgeInsets.all(5.0),
  child: Center(
    child: Text(
      'Items are Inclusive VAT',
      style: TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.bold),
      ),
  ),
  ),
), 
                Container(height: 120, child: listBanners(bannerslist)),
                Container(
                  height: 260,
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints.expand(height: 50),
                          child: TabBar(
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Colors.blue[900],
                              labelColor: Colors.blue[900],
                              isScrollable: true,
                              tabs: [
                                Tab(text: "       FRESH     "),
                                Tab(text: "     FMCG     "),
                                Tab(text: "    NON Food   "),
                                // Tab(text: "    OTHERS    "),
                              ]),
                        ),
                        Expanded(
                          child: Container(
                            child: TabBarView(children: [
                              Container(
                                  padding: EdgeInsets.all(4),
                                  child: Material(
                                      elevation: 3,
                                      child: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          CategoryListScreen(
                                                              focusposition: 0)));
                                            },
                                            child: Image(
                                              height: 120,
                                              image: AssetImage(
                                                  'images/fresh_food.jpg'),
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: Image(
                                                    height: 80,
                                                    image: AssetImage(
                                                        'images/fruits_vegs.jpg'),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                Example(
                                                                    from: null,
                                                                    catids:
                                                                        "2,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43, 3,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64",
                                                                    searchtext:
                                                                        null)));
                                                  },
                                                ),
                                                Container(
                                                    height: 80,
                                                    child: VerticalDivider(
                                                        color: Colors.blue[900])),
                                                GestureDetector(
                                                  child: Image(
                                                    height: 80,
                                                    image: AssetImage(
                                                        'images/bakery.jpg'),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                Example(
                                                                    from: null,
                                                                    catids:
                                                                        "11,123,124,125,126,127,128,129",
                                                                    searchtext:
                                                                        null)));
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ))),
                              Container(
                                  padding: EdgeInsets.all(4),
                                  child: Material(
                                      elevation: 4,
                                      child: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                              child: Image(
                                                height: 120,
                                                image: AssetImage(
                                                    'images/food-beverages.jpg'),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    new MaterialPageRoute(
                                                        builder: (context) =>
                                                            CategoryListScreen(
                                                                focusposition:
                                                                    1)));
                                              }),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: Image(
                                                    height: 80,
                                                    image: AssetImage(
                                                        'images/breakfast.jpg'),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                Example(
                                                                    from: null,
                                                                    catids:
                                                                        "179,215,216,217,218,219,220",
                                                                    searchtext:
                                                                        null)));
                                                  },
                                                ),
                                                Container(
                                                    height: 80,
                                                    child: VerticalDivider(
                                                        color: Colors.blue[900])),
                                                GestureDetector(
                                                  child: Image(
                                                    height: 80,
                                                    image: AssetImage(
                                                        'images/snacks.jpg'),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                Example(
                                                                    from: null,
                                                                    catids:
                                                                        "189,281,282,283,284,285,286,287,288",
                                                                    searchtext:
                                                                        null)));
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ))),
                              Container(
                                  padding: EdgeInsets.all(4),
                                  child: Material(
                                      elevation: 4,
                                      child: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          CategoryListScreen(
                                                              focusposition: 2)));
                                            },
                                            child: Image(
                                              height: 120,
                                              image: AssetImage(
                                                  'images/non_food.jpg'),
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: Image(
                                                    height: 80,
                                                    image: AssetImage(
                                                        'images/electronics.jpg'),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                Example(
                                                                    from: null,
                                                                    catids:
                                                                        "318,328,329,330,331,332,333",
                                                                    searchtext:
                                                                        null)));
                                                  },
                                                ),
                                                Container(
                                                    height: 80,
                                                    child: VerticalDivider(
                                                        color: Colors.blue[900])),
                                                GestureDetector(
                                                  child: Image(
                                                    height: 80,
                                                    image: AssetImage(
                                                        'images/luggage.jpg'),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                Example(
                                                                    from: null,
                                                                    catids:
                                                                        "325,367",
                                                                    searchtext:
                                                                        null)));
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ))),
                              // Container(
                              //     padding: EdgeInsets.all(4),
                              //     child: Material(
                              //         elevation: 4,
                              //         child: Column(
                              //           children: <Widget>[
                              //             GestureDetector(
                              //               child: Image(
                              //                 height: 120,
                              //                 image: AssetImage(
                              //                     'images/others.jpg'),
                              //               ),
                              //               onTap: () {
                              //                 Navigator.of(context).push(
                              //                     new MaterialPageRoute(
                              //                         builder: (context) =>
                              //                             CategoryListScreen(
                              //                                 focusposition: 3)));
                              //               },
                              //             ),
                              //             SingleChildScrollView(
                              //               scrollDirection: Axis.horizontal,
                              //               child: Row(
                              //                 children: <Widget>[
                              //                   GestureDetector(
                              //                     child: Image(
                              //                       height: 80,
                              //                       image: AssetImage(
                              //                           'images/consumable_products.jpg'),
                              //                     ),
                              //                     onTap: () {
                              //                       Navigator.of(context).push(
                              //                           new MaterialPageRoute(
                              //                               builder: (context) =>
                              //                                   Example(
                              //                                     from: null,
                              //                                     catids:
                              //                                         "380,381,382,383,384,385,386,387,388,389,390,391,392,393",
                              //                                     searchtext:
                              //                                         null
                              //                                   )));
                              //                     },
                              //                   ),
                              //                   Container(
                              //                       height: 80,
                              //                       child: VerticalDivider(
                              //                           color: Colors.blue[900])),
                              //                   GestureDetector(
                              //                     child: Image(
                              //                       height: 80,
                              //                       image: AssetImage(
                              //                           'images/consumable_products.jpg'),
                              //                     ),
                              //                     onTap: () {
                              //                       Navigator.of(context).push(
                              //                           new MaterialPageRoute(
                              //                               builder: (context) =>
                              //                                   Example(
                              //                                     from: null,
                              //                                     catids:
                              //                                         "380,381,382,383,384,385,386,387,388,389,390,391,392,393",
                              //                                     searchtext:
                              //                                         null
                              //                                   )));
                              //                     },
                              //                   ),
                              //                 ],
                              //               ),
                              //             )
                              //           ],
                              //         ))),
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => AllCategoriesScreennew()));
                      },
                      child: Image(
                        image: AssetImage("images/all_categories.jpg"),
                      ),
                    )),
            
                      
              ],
            ),
          ),
        ));

    // body: Container(
    // padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),

    // child: buildListViewHoriental(items),));
  }

  ListView listBanners(List<String> banners) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: banners.length,
        itemBuilder: (context, index) {
          return Center(
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: GestureDetector(
                    child: Container(

                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15.0),
                        //     border: Border.all(color: Colors.grey, width: 2.0)),
                        child: Material(
                            elevation: 4,
                            child: Image(
                              image: AssetImage(banners[index]),
                            ))),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) =>
                              CategoryListScreen(focusposition: index)));
                    },
                  )));
        });
  }

  ListView buildListViewHoriental(List<ItemModel> numbers) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          return Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey[200], width: 2.0)),
                child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      numbers[index].name,
                    ))),
          ));
        });
  }
}
