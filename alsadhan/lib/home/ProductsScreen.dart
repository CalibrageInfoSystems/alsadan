import 'package:alsadhan/SignUp/SignUpScreen.dart';
import 'package:alsadhan/models/ProductsModel.dart';
import 'package:alsadhan/services/api_service.dart';
import 'package:flutter/material.dart';

ApiConnector apiConnector;
ProductsModel productsModel;
var productsListArray = [];

var pageNumber = 1;
var pagesize = 10;
var _currentAmount = 0;
bool isLoading = false;
int totalCount = 0;
final ScrollController scrollController = new ScrollController();

class ProductsScreen extends StatefulWidget {
  @override
  _productsScreen createState() => _productsScreen();
}

class _productsScreen extends State<ProductsScreen> {
  @override
  void initState() {
    apiModel = new ApiConnector();
    productsListArray = [];
    super.initState();
    getProductsAPICall();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: productsListArray == null || productsListArray.isEmpty ??
                Center(child: Text("No data found"))
            ? Center(child: Text('No Data'))
            : GridView.count(
                controller: scrollController,
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.

                children: List.generate(productsListArray.length, (index) {
                  return new GridTile(
                      child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (!isLoading &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                              pageNumber = pageNumber + 1;
                              if (productsListArray.length < totalCount) {
                                getProductsAPICall();
                              }
                              // start loading data
                              print('--->>> listResultResponse.length' +
                                  productsListArray.length.toString());
                              print(
                                  '--->>> total count' + totalCount.toString());
                              print('--->>> called Notiification listener');
                              setState(() {
                                isLoading = true;
                              });
                            }
                          },
                          child: new Card(
                              color: Colors.blue.shade200,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _currentAmount -= 1;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    "$_currentAmount",
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                  SizedBox(width: 15),
                                  GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _currentAmount += 1;
                                      });
                                    },
                                  ),
                                ],
                              )
                              // child: new Center(
                              //   child: new Text('tile $index'),
                              // )
                              )));
                }),
              ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: productsListArray == null || productsListArray.isEmpty ??
  //             Center(child: Text("No data found"))
  //         ? Center(child: Text('No Data'))
  //         : productsList(),
  //   );
  // }

  Widget productsList() {
    child:
    NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isLoading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          pageNumber = pageNumber + 1;
          if (productsListArray.length < totalCount) {
            getProductsAPICall();
          }
          // start loading data
          print('--->>> listResultResponse.length' +
              productsListArray.length.toString());
          print('--->>> total count' + totalCount.toString());
          print('--->>> called Notiification listener');
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(productsListArray.length, (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headline,
            ),
          );
        }),
      ),
    );
  }

  Future<void> getProductsAPICall() async {
    await apiModel
        .productsAPICall("9,10", pageNumber, pagesize, null, null)
        .then((response) {
      setState(() {
        productsListArray = response.listResult;

        //totalCount = response.affectedRecords;
        totalCount = 56;
      });

      print('--->>> productsListArray.length' +
          productsListArray.length.toString());
      print('--->>> total count' + totalCount.toString());
    });
  }
}
