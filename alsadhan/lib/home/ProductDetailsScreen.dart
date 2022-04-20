import 'package:alsadhan/home/DeliverySlotScreen.dart';
import 'package:alsadhan/home/ProductsScreen.dart';
import 'package:alsadhan/models/ProductsModel.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  // String something;
  // ProductDetailsScreen(this.something);
  ListResultProduct productsArry;
  ProductDetailsScreen({Key key, @required this.productsArry})
      : super(key: key);

  // void initState() {

  //   print("------->>>>. " + something);
  // }
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          title: Text(widget.productsArry.name1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, true),
          )),
      body: productDetailsView(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
      ),
    );
  }

  productDetailsView() {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Center(
                    child: Image(
                        image: NetworkImage(widget.productsArry.filepath))),
              ),
              Divider(height: 10, color: Colors.grey),
              SizedBox(height: 5),
              Padding(padding: EdgeInsets.only(right: 20.0)),
              Text(
                widget.productsArry.name1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 10),
              Text(widget.productsArry.description1,
                  style: TextStyle(fontWeight: FontWeight.normal)),
              SizedBox(height: 5),
              Divider(height: 10, color: Colors.grey),
            ],
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              color: Colors.blue,
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Price ' + widget.productsArry.price.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 140),
                    child: RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      //focusColor: Colors.grey,
                      child: Text('Check Out'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeliverySlotScreen()));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
