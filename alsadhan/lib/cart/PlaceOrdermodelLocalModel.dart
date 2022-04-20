// To parse this JSON data, do
//
//     final placeOrdermodel = placeOrdermodelFromJson(jsonString);

import 'dart:convert';

 
List<PlaceOrdermodelLocalModel> placeOrdermodelFromJson(String str) => List<PlaceOrdermodelLocalModel>.from(json.decode(str).map((x) => PlaceOrdermodelLocalModel.fromJson(x)));

String placeOrdermodelToJson(List<PlaceOrdermodelLocalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaceOrdermodelLocalModel {
    int productId;
    double price;
    int quantity;

    PlaceOrdermodelLocalModel({
        this.productId,
        this.price,
        this.quantity,
    });

    factory PlaceOrdermodelLocalModel.fromJson(Map<String, dynamic> json) => PlaceOrdermodelLocalModel(
        productId: json["ProductId"],
        price: json["Price"].toDouble(),
        quantity: json["Quantity"],
    );

    Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "Price": price,
        "Quantity": quantity,
    };
}
