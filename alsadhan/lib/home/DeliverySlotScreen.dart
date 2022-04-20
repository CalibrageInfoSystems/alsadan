import 'dart:convert';

import 'package:alsadhan/cart/reviewCart.dart';
import 'package:alsadhan/home/catogory_list_screen.dart';
import 'package:alsadhan/models/DeliverySlotsModel.dart';
import 'package:alsadhan/models/ProductsModel.dart';
import 'package:alsadhan/models/StoreModel.dart';
import 'package:alsadhan/services/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

List<ListResult> deliveryDaysArray = [];
List<DeliverSlot> deliveruTimeArray = [];
String deliverySlot;
DateTime deliveryDate;
int selectedIndex = 0;
DefaultTabController defaultTabController;

DeliverySlotsModel slotsModel = new DeliverySlotsModel();

class DeliverySlotScreen extends StatefulWidget {
  _DeliverySlotScreen createState() => new _DeliverySlotScreen();
  ListResultStore storemodel;
  List<ListResultProduct> items = [];
  double totalprice;
  DeliverySlotScreen({Key key, this.items, this.storemodel, this.totalprice});
}

class _DeliverySlotScreen extends State<DeliverySlotScreen> {
  @override
  void initState() {
    super.initState();

    slotsModel = new DeliverySlotsModel();

    getDeliverySlotsAPICalling();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
          initialIndex: 0,
          length: deliveryDaysArray.length,
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
                title: new Text('Choose Delivery Slots'),
                bottom: new TabBar(
                  isScrollable: true,
                  tabs: List<Widget>.generate(deliveryDaysArray.length,
                      (int index) {
                    return Column(
                      children: <Widget>[
                        new Tab(
                            text: deliveryDaysArray[index].day +
                                "\n" +
                                mainDate(deliveryDaysArray[index].date)),
                        //new Tab(text: mainDate(deliveryDaysArray[index].date)),
                      ],
                    );
                  }),
                ),
              ),
              body: Column(
                children: <Widget>[
                  SizedBox(height: 15),
                  Text(
                    "Choose your desired delivery date by clicking on" +
                        "\n" +
                        "a time slot",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: new TabBarView(
                      children: List<Widget>.generate(deliveryDaysArray.length,
                          (int index) {
                        // return new Text(maintcategory[index].name1);
                        return buildBody(
                            deliveryDaysArray[index].deliverSlot, index);
                      }),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      //color: Colors.blue,
                      // padding: EdgeInsets.all(5.0),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      // child: RaisedButton(
                        
                      //   shape: new RoundedRectangleBorder(
                      //       borderRadius: new BorderRadius.circular(30.0)),
                      //   //focusColor: Colors.grey,
                      //   child: Text('Next',
                      //       style: TextStyle(
                      //           fontSize: 15, fontWeight: FontWeight.w600)),
                      //   onPressed: () {
                      //     print('---- >> Navigation to Review Screen');
                      //     setState(() {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => ReviewCartScreen(
                      //                   totalprice: this.widget.totalprice,
                      //                   items: this.widget.items,
                      //                   storemodel: this.widget.storemodel.id,
                      //                   deliveryTimeSlot: deliverySlot,
                      //                   deliveryDate: deliveryDate)));
                      //     });
                      //   },
                      // ),
                    ),
                  )
                ],
              ))),
    );
  }

  // void _handleTabSelection() {
  //   setState(() {
  //     _selectedTab = MyWidgetTabs.values[_tabController.index];
  //     print(
  //         "Changed tab to: ${_selectedTab.toString().split('.').last} , index: ${_tabController.index}");
  //   });
  // }

  Widget buildBody(List<DeliverSlot> slots, int deliverydaysIndex) {
    return ListView.builder(
        itemCount: slots.length,
        itemBuilder: (BuildContext ctx, int index) {
          //return Align( alignment: Alignment.center, child:  Text(slots[index].slot ,style: TextStyle(fontSize: 22),));

          return Column(
            children: <Widget>[
              SizedBox(height: 10),
              GestureDetector(
                child: Container(
                    color: Colors.white10,
                    child: Text(slots[index].slot,
                        style: TextStyle(fontSize: 22))),
                onTap: () {
                  print("------>>>>>" + slots[index].slot);
                  print("------>>>>>" +
                      deliveryDaysArray[deliverydaysIndex].date.toString());
                  deliverySlot = slots[index].slot;
                  deliveryDate = deliveryDaysArray[deliverydaysIndex].date;

                  print('****************************');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewCartScreen(
                              totalprice: this.widget.totalprice,
                              items: this.widget.items,
                              storemodel: this.widget.storemodel.id,
                              deliveryTimeSlot: deliverySlot,
                              deliveryDate: deliveryDate)));
                },
              ),
              SizedBox(height: 10),
              Divider(height: 5),
            ],
          );
        });
  }

  Future getDeliverySlotsAPICalling() async {
    String deliveryAPI = BASEURL + DELIVERSLOTSURL;
    Response res = await get(deliveryAPI);
    print("---->>>> DELIVERSLOTSURL ::::: " + deliveryAPI);

    int statusCode = res.statusCode;
    String responseBody = res.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);
      slotsModel = DeliverySlotsModel.fromJson(userresponce);
      print('::: DeliverySlotsModel :::: Success : 200');
      print('::: DeliverySlotsModel :::: ' + userresponce.toString());
      print('::: DeliverySlotsModel :::: -- >> ' +
          slotsModel.listResult.toString());

      print('::: deliveruSlotsArrayCount :::: -- >> ' +
          deliveryDaysArray.length.toString());

      setState(() {
        deliveryDaysArray = slotsModel.listResult;
        deliveryDate = deliveryDaysArray[0].date;
      });

      //return slotsModel;
    } else {
      print('::: getAllCategories :::: error : ');

      //getRefreshToken(refreshToken);

      return null;
    }
  }

  mainDate(DateTime date) {
    var formatter = new DateFormat('d MMMM');
    String dates = formatter.format(date);
    print(dates); // something like 2013-04-20
    return dates;
  }
}
