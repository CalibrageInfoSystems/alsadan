import 'dart:convert';
import 'dart:ffi';
import 'package:alsadhan/models/AreaNamesModel.dart';
import 'package:alsadhan/models/CartModel_data.dart';
import 'package:alsadhan/models/CategoryModel.dart';
import 'package:alsadhan/models/MyordersModel.dart';
import 'package:alsadhan/models/PlaceOrdermodel.dart';
import 'package:alsadhan/models/PostCartModel.dart';
import 'package:alsadhan/models/ProductsModel.dart';
import 'package:alsadhan/models/StoreModel.dart';
import 'package:alsadhan/models/UserInfoModel.dart';
import 'package:alsadhan/myorders/myorder_screen.dart';
import 'package:alsadhan/services/api_constants.dart';
import 'package:http/http.dart';
import 'package:alsadhan/models/ProductsModel.dart';
import 'package:alsadhan/models/DeliveryOrder.dart';

class ApiConnector {
  Future<CategoryModel> getAllCategories() async {
    CategoryModel categoryModel = new CategoryModel();
    Response res = await get(BASEURL + GETALLCATEGORIES);

    int statusCode = res.statusCode;
    String responseBody = res.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);
      categoryModel = CategoryModel.fromJson(userresponce);
      print('::: getAllCategories :::: Success : 200');
      print('::: getAllCategories :::: ' + userresponce.toString());

      return categoryModel;
    } else {
      print('::: getAllCategories :::: error : ');

      //getRefreshToken(refreshToken);

      return null;
    }
  }

  Future<CategoryModel> loginAPICall(String userName, String passward) async {
    final uri = BASEURL + LOGINURL;

    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "refreshToken": "refreshToken",
      "clientId": "saveblood_spa",
      "clientSecret": null,
      "scope": "saveblood_api offline_access"
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);

      print('::: Login Status :::: Success : 200');
      print('::: Login Response :::: ' + userresponce.toString());
    } else {
      print('::: Login Response :::: error : ');

      return null;
    }
  }

  Future<CategoryModel> signUpAPICall(String fullName, String userName,
      String mobileNumber, String passward, String confirmPassward) async {
    final uri = BASEURL + SIGNUPURL;

    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "refreshToken": fullName,
      "clientId": "saveblood_spa",
      "clientSecret": null,
      "scope": "saveblood_api offline_access"
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);

      print('::: Sign Up Status :::: Success : 200');
      print('::: Sign Up  Response :::: ' + userresponce.toString());
    } else {
      print('::: Sign Up Response :::: error : ');

      return null;
    }
  }

  Future<ProductsModel> productsAPICall(String categoryIds, int pageNo,
      int pageSize, String sortColumn, String sortOrder) async {
    final uri = BASEURL + PRODUCTSURL;

    print('------->> API call :' + uri);
    ProductsModel productsModel = new ProductsModel();

    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "CategoryIds": categoryIds,
      "PageNo": pageNo,
      "PageSize": pageSize,
      "SortColumn": sortColumn,
      "SortOrder": sortOrder
    };

    String jsonBody = json.encode(body);
    print('API CALL :' + jsonBody);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);
      productsModel = ProductsModel.fromJson(userresponce);

      print('::: Sign Up Status :::: Success : 200');
      print('::: Sign Up  Response :::: ' + userresponce.toString());

      return productsModel;
    } else {
      print('::: Sign Up Response :::: error : ');
      return null;
    }
  }
  // Future<StoreModel> getAllStores(int id, String name1, String name2, String fileName, String fileLocation, String fileExtension, String filepath, String address, String landmark, String cityName,  )
  // {
  // }

  Future<ProductsModel> getSearchproducts(String searchValue, int pageNo,
      int pageSize, String sortColumn, String sortOrder) async {
    final uri = BASEURL + PRODUCT_SEARCHURL;

    ProductsModel productsModel = new ProductsModel();

    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "SearchValue": searchValue,
      "PageNo": pageNo,
      "PageSize": pageSize,
      "SortColumn": sortColumn,
      "SortOrder": sortOrder
    };

    String jsonBody = json.encode(body);
    print('*************API CALL :' + jsonBody);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);
      productsModel = ProductsModel.fromJson(userresponce);

      print('::: Sign Up Status :::: Success : 200');
      print('::: Sign Up  Response :::: ' + userresponce.toString());

      return productsModel;
    } else {
      print('::: Sign Up Response :::: error : ');
      return null;
    }
  }

  Future<StoresModel> getStores() async {
    final uri = BASEURL + STORES_URL;
    print('API call :' + uri);
    StoresModel storesModel = new StoresModel();
    final headers = {'Content-Type': 'application/json'};
    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);
      storesModel = StoresModel.fromJson(userresponce);

      print('::: Sign Up Status :::: Success : 200');
      print('::: Sign Up  Response :::: ' + userresponce.toString());

      return storesModel;
    } else {
      print('::: Sign Up Response :::: error : ');
      return null;
    }
  }

  Future<int> placeOrder(PlaceOrdermodel ordermodel) async {
    final uri = BASEURL + PLACEORDER_URL;
    int _successcode = 200;
    final headers = {'Content-Type': 'application/json'};

    String jsonBody = json.encode(ordermodel.toJson());
    final encoding = Encoding.getByName('utf-8');

    print('Request Model :' + ordermodel.toJson().toString());
    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    _successcode = statusCode;
    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);

      print('::: placeOrder Response :::: ' + userresponce.toString());
      bool issucess = userresponce['IsSuccess'];
      print('::: placeOrder :::: Success : ' + issucess.toString());
      if (issucess) {
        _successcode = 200;
      } else {
        _successcode = 400;
      }
      return _successcode;
    } else {
      print('::: placeOrder Response :::: error : ');

      return _successcode;
    }
  }

  Future<MyordersModel> gtOrers(
      int userid, int pagenumber, int pagesize) async {
    final uri = BASEURL + MYORDERS;

    MyordersModel productsModel = new MyordersModel();

    final headers = {'Content-Type': 'application/json'};

    Map<String, dynamic> body = {
      "UserId": userid,
      "PageNo": pagenumber,
      "PageSize": pagesize
    };

    String jsonBody = json.encode(body);
    print('*************API CALL :' + uri);
    print('*************API CALL :' + jsonBody);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);
      productsModel = MyordersModel.fromJson(userresponce);

      print('::: placeOrder Up Status :::: Success : 200');
      print('::: placeOrder Response :::: ' + userresponce.toString());

      return productsModel;
    } else {
      print('::: placeOrder Response :::: error : ');
      return null;
    }
  }

  Future<DeliveryOrder> getOrderDetails(String orderid) async {
    final uri = BASEURL + DELIVERYORDERDETAIL + '/' + orderid;
    print('API call :' + uri);
    DeliveryOrder storesModel = new DeliveryOrder();
    final headers = {'Content-Type': 'application/json'};
    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);
      storesModel = DeliveryOrder.fromJson(userresponce);

      print('::: SgetOrderDetails :::: Success : 200');
      print('::: getOrderDetails:::: ' + userresponce.toString());

      return storesModel;
    } else {
      print('::: getOrderDetails :::: error : ');
      return null;
    }
  }

  Future<CartModel> getCartInfo(int userid) async {
    final uri = BASEURL + GET_CARTDETAILS + userid.toString();
    print('API call :' + uri);
    CartModel cartModel = new CartModel();
    final headers = {'Content-Type': 'application/json'};
    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);
      cartModel = CartModel.fromJson(userresponce);

      print('::: getCartInfo :::: Success : 200');
      print('::: getCartInfos:::: ' + userresponce.toString());

      return cartModel;
    } else {
      print('::: getCartInfo :::: error : ');
      return null;
    }
  }

  Future<int> postCartUpdate(PostCartModel cartinfo) async {
    final uri = BASEURL + POST_CART;
    int _successcode = 200;
    final headers = {'Content-Type': 'application/json'};

    String jsonBody = json.encode(cartinfo.toJson());
    final encoding = Encoding.getByName('utf-8');

    print('postCartUpdate :' + cartinfo.toJson().toString());
    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    _successcode = statusCode;
    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);

      print('::: postCartUpdate Response :::: ' + userresponce.toString());
      bool issucess = userresponce['IsSuccess'];
      print('::: postCartUpdate :::: Success : ' + issucess.toString());
      if (issucess) {
        _successcode = 200;
      } else {
        _successcode = 400;
      }
      return _successcode;
    } else {
      print('::: postCartUpdate Response :::: error : ');

      return _successcode;
    }
  }

  Future<int> deleteCart(int userid) async {
    int _successcode = 101;
    final uri = BASEURL + CLEAR_CART + userid.toString();
    print('API call :' + uri);

    final headers = {'Content-Type': 'application/json'};
    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);

      print('::: deleteCart Response :::: ' + userresponce.toString());
      bool issucess = userresponce['IsSuccess'];
      print('::: deleteCart :::: Success : ' + issucess.toString());
      if (issucess) {
        _successcode = 200;
      } else {
        _successcode = 400;
      }
      return _successcode;
    } else {
      print('::: deleteCart :::: error : ');

      return _successcode;
    }
  }

   Future<UserInfoModel> getUserInfo(int id) async {
    final uri = BASEURL + USERINFOURL + id.toString();
    print('API call :' + uri);
    UserInfoModel userInfoModel = new UserInfoModel();
    final headers = {'Content-Type': 'application/json'};
    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);
      userInfoModel = UserInfoModel.fromJson(userresponce);

      print('::: userInfoModel :::: Success : 200');
      print('::: userInfoModel :::: ' + userresponce.toString());

      return userInfoModel;
    } else {
      print('::: userInfoModel :::: error : ');
      return null;
    }
  }

     Future<AreaNamesModel> getAreaNames(String cityName) async {
    final uri = BASEURL + AREANAMESURL + cityName;
    print('API call :' + uri);
    AreaNamesModel areaNamesModel = new AreaNamesModel();
    final headers = {'Content-Type': 'application/json'};
    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    if (statusCode == 200) {
      var userresponce = json.decode(responseBody);
      areaNamesModel = AreaNamesModel.fromJson(userresponce);

      print('::: AreaNamesModel :::: Success : 200');
      print('::: AreaNamesModel :::: ' + userresponce.toString());

      return areaNamesModel;
    } else {
      print('::: AreaNamesModel :::: error : ');
      return null;
    }
  }
}
