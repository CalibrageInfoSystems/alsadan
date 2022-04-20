// To parse this JSON data, do
//
//     final deliveryOrder = deliveryOrderFromJson(jsonString);

import 'dart:convert';

DeliveryOrder deliveryOrderFromJson(String str) => DeliveryOrder.fromJson(json.decode(str));

String deliveryOrderToJson(DeliveryOrder data) => json.encode(data.toJson());

class DeliveryOrder {
    List<ListResult> listResult;
    bool isSuccess;
    int affectedRecords;
    String endUserMessage;
    List<dynamic> validationErrors;
    dynamic exception;

    DeliveryOrder({
        this.listResult,
        this.isSuccess,
        this.affectedRecords,
        this.endUserMessage,
        this.validationErrors,
        this.exception,
    });

    factory DeliveryOrder.fromJson(Map<String, dynamic> json) => DeliveryOrder(
        listResult: List<ListResult>.from(json["ListResult"].map((x) => ListResult.fromJson(x))),
        isSuccess: json["IsSuccess"],
        affectedRecords: json["AffectedRecords"],
        endUserMessage: json["EndUserMessage"],
        validationErrors: List<dynamic>.from(json["ValidationErrors"].map((x) => x)),
        exception: json["Exception"],
    );

    Map<String, dynamic> toJson() => {
        "ListResult": List<dynamic>.from(listResult.map((x) => x.toJson())),
        "IsSuccess": isSuccess,
        "AffectedRecords": affectedRecords,
        "EndUserMessage": endUserMessage,
        "ValidationErrors": List<dynamic>.from(validationErrors.map((x) => x)),
        "Exception": exception,
    };
}

class ListResult {
    int orderId;
    int productId;
    String name1;
    String name2;
    String code;
    String description1;
    String description2;
    double price;
    int quantity;
    double totalPrice;

    ListResult({
        this.orderId,
        this.productId,
        this.name1,
        this.name2,
        this.code,
        this.description1,
        this.description2,
        this.price,
        this.quantity,
        this.totalPrice,
    });

    factory ListResult.fromJson(Map<String, dynamic> json) => ListResult(
        orderId: json["OrderId"],
        productId: json["ProductId"],
        name1: json["Name1"],
        name2: json["Name2"],
        code: json["Code"],
        description1: json["Description1"],
        description2: json["Description2"],
        price: json["Price"].toDouble(),
        quantity: json["Quantity"],
        totalPrice: json["TotalPrice"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "OrderId": orderId,
        "ProductId": productId,
        "Name1": name1,
        "Name2": name2,
        "Code": code,
        "Description1": description1,
        "Description2": description2,
        "Price": price,
        "Quantity": quantity,
        "TotalPrice": totalPrice,
    };
}
