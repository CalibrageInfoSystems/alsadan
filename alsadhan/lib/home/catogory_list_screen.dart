import 'package:alsadhan/home/FlutterExample.dart';
import 'package:alsadhan/localdb/LocalDb.dart';
import 'package:alsadhan/models/CategoryModel.dart';
import 'package:alsadhan/models/categoryitem.dart';
import 'package:alsadhan/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

List<CateGoryItem> maintcategory = [];
List<CateGoryItem> submaintcategory = [];
List<CateGoryItem> subcategory = [];
ProgressDialog pr;

class CategoryListScreen extends StatefulWidget {
  int focusposition;
  CategoryListScreen({Key key, this.focusposition}) : super(key: key);

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  ApiConnector api;
  CategoryModel categoryModel;
  LocalData localData = new LocalData();
  // TabController _controller;
  int initialIndex = 0;
  bool isArabic = false;
  static final _myTabbedPageKey = new GlobalKey<_CategoryListScreenState>();
  TabController _tabController;
  @override
  Future<void> initState() {
    super.initState();

    api = new ApiConnector();
    localData.isarabic().then((iseng) {
      setState(() {
        print('************ is English : ' + isArabic.toString());
        isArabic = true;
      });
    });
    getcategorydata();
    //  _tabController = new TabController(vsync: this, length: choices.length);
    // _controller.addListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: maintcategory.length < 1
          ? new Scaffold(
              appBar: AppBar(title: Text('Categories')),
              body: Center(
                child: Text('Fetching Data...'),
              ),
            )
          : DefaultTabController(
              initialIndex: this.widget.focusposition,
              length: maintcategory.length,
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
                    leading: new IconButton(
                      icon: new Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    backgroundColor: Colors.blue[900],
                    title: new Text('Categories'),
                    bottom: new TabBar(
                      isScrollable: true,
                      tabs: List<Widget>.generate(maintcategory.length,
                          (int index) {
                        return new Tab(text: isArabic == false ? maintcategory[index].name1 :maintcategory[index].name2);
                      }),
                    ),
                  ),
                  body: Container(
                    color: Colors.grey[200],
                    child: new TabBarView(
                      children: List<Widget>.generate(maintcategory.length,
                          (int index) {
                        // return new Text(maintcategory[index].name1);
                        return _subCategory(maintcategory[index].id);
                      }),
                    ),
                  ))),
    );
  }

  Widget _subCategory(int maintcatid) {
    var subitem = submaintcategory
        .where((e) => e.parentCategoryId == maintcatid)
        .toList();
    return new ListView.builder(
        itemCount: subitem.length,
        itemBuilder: (BuildContext ctxt, int index) {
          // return new Text(subcategory[index].name1);
          return Card(
            child: ExpansionTile(
              title: Text(isArabic == false  ?subitem[index].name1 :subitem[index].name2),
              children: _buildExpandableContent(subitem[index].id),
            ),
          );
        });
  }

  _buildExpandableContent(int mainid) {
    List<Widget> columnContent = [];
    var subitem =
        subcategory.where((e) => e.parentCategoryId == mainid).toList();
    for (CateGoryItem content in subitem)
      columnContent.add(
        new ListTile(
          title: GestureDetector(
              onTap: () {
                print('OnCLick :' + content.name1);
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => Example(
                          from: 'CATEGORY',
                          catids: content.id.toString(),
                          searchtext: null,
                        )));
              },
              child: Card(
                  child: Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(10),
                      child: new Text( isArabic == false ?
                        content.name1 : content.name2,
                        style: new TextStyle(fontSize: 18.0),
                      )))),
        ),
      );

    return columnContent;
  }

  Widget _subinsideCategory(int maintcatid) {
    var subitem =
        subcategory.where((e) => e.parentCategoryId == maintcatid).toList();
    return new ListView.builder(
        itemCount: subcategory.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Text(subcategory[index].name1);
        });
  }

  Future<void> getcategorydata() async {
    maintcategory = new List<CateGoryItem>();
    submaintcategory = new List<CateGoryItem>();
    subcategory = new List<CateGoryItem>();
    await api.getAllCategories().then((valueitem) {
      setState(() {
        for (int i = 0; i < valueitem.listResult.length; i++) {
          if (valueitem.listResult[i].categoryLevel == 1) {
            maintcategory.add(new CateGoryItem(
                id: valueitem.listResult[i].id,
                categoryLevel: valueitem.listResult[i].categoryLevel,
                createdByUserId: valueitem.listResult[i].createdByUserId,
                createdDate: valueitem.listResult[i].createdDate,
                isActive: valueitem.listResult[i].isActive,
                name1: valueitem.listResult[i].name1,
                name2: valueitem.listResult[i].name2,
                parentCategoryId: valueitem.listResult[i].parentCategoryId,
                parentCategoryName1:
                    valueitem.listResult[i].parentCategoryName1,
                parentCategoryName2:
                    valueitem.listResult[i].parentCategoryName2,
                updatedByUserId: valueitem.listResult[i].updatedByUserId,
                updatedDate: valueitem.listResult[i].updatedDate));
          } else if (valueitem.listResult[i].categoryLevel == 2) {
            submaintcategory.add(new CateGoryItem(
                id: valueitem.listResult[i].id,
                categoryLevel: valueitem.listResult[i].categoryLevel,
                createdByUserId: valueitem.listResult[i].createdByUserId,
                createdDate: valueitem.listResult[i].createdDate,
                isActive: valueitem.listResult[i].isActive,
                name1: valueitem.listResult[i].name1,
                name2: valueitem.listResult[i].name2,
                parentCategoryId: valueitem.listResult[i].parentCategoryId,
                parentCategoryName1:
                    valueitem.listResult[i].parentCategoryName1,
                parentCategoryName2:
                    valueitem.listResult[i].parentCategoryName2,
                updatedByUserId: valueitem.listResult[i].updatedByUserId,
                updatedDate: valueitem.listResult[i].updatedDate));
          } else if (valueitem.listResult[i].categoryLevel == 3) {
            subcategory.add(new CateGoryItem(
                id: valueitem.listResult[i].id,
                categoryLevel: valueitem.listResult[i].categoryLevel,
                createdByUserId: valueitem.listResult[i].createdByUserId,
                createdDate: valueitem.listResult[i].createdDate,
                isActive: valueitem.listResult[i].isActive,
                name1: valueitem.listResult[i].name1,
                name2: valueitem.listResult[i].name2,
                parentCategoryId: valueitem.listResult[i].parentCategoryId,
                parentCategoryName1:
                    valueitem.listResult[i].parentCategoryName1,
                parentCategoryName2:
                    valueitem.listResult[i].parentCategoryName2,
                updatedByUserId: valueitem.listResult[i].updatedByUserId,
                updatedDate: valueitem.listResult[i].updatedDate));
          }
        }
        print('*********** Main cat Count :' + maintcategory.length.toString());
        print('*********** subMain cat Count :' +
            submaintcategory.length.toString());
        print('*********** sub cat Count :' + subcategory.length.toString());
      });
    });

    setState(() {
      print(
          '********* Focus Position :' + this.widget.focusposition.toString());
      initialIndex = this.widget.focusposition;
      print('********* Focus Position :' + initialIndex.toString());
    });
  }
}
