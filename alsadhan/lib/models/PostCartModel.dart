// To parse this JSON data, do
//
//     final postCartModel = postCartModelFromJson(jsonString);

import 'dart:convert';

PostCartModel postCartModelFromJson(String str) => PostCartModel.fromJson(json.decode(str));

String postCartModelToJson(PostCartModel data) => json.encode(data.toJson());

class PostCartModel {
    CartPostInfo cart;
    List<ProductsListModelCart> productsList;

    PostCartModel({
        this.cart,
        this.productsList,
    });

    factory PostCartModel.fromJson(Map<String, dynamic> json) => PostCartModel(
        cart: CartPostInfo.fromJson(json["cart"]),
        productsList: List<ProductsListModelCart>.from(json["productsList"].map((x) => ProductsListModelCart.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cart": cart.toJson(),
        "productsList": List<dynamic>.from(productsList.map((x) => x.toJson())),
    };
}

class CartPostInfo {
    int id;
    int userId;
    String name;

    CartPostInfo({
        this.id,
        this.userId,
        this.name,
    });

    factory CartPostInfo.fromJson(Map<String, dynamic> json) => CartPostInfo(
        id: json["Id"],
        userId: json["UserId"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "Name": name,
    };
}

class ProductsListModelCart {
    int productId;
    int quantity;

    ProductsListModelCart({
        this.productId,
        this.quantity,
    });

    factory ProductsListModelCart.fromJson(Map<String, dynamic> json) => ProductsListModelCart(
        productId: json["ProductId"],
        quantity: json["Quantity"],
    );

    Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "Quantity": quantity,
    };
}
