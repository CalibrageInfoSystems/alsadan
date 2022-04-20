// To parse this JSON data, do
//
//     final myordersModel = myordersModelFromJson(jsonString);

import 'dart:convert';

import 'package:gson/gson.dart';

MyordersModel myordersModelFromJson(String str) => MyordersModel.fromJson(json.decode(str));

String myordersModelToJson(MyordersModel data) => json.encode(data.toJson());

class MyordersModel {
    List<ListResultMyorder> listResult;
    bool isSuccess;
    int affectedRecords;
    String endUserMessage;
    List<dynamic> validationErrors;
    dynamic exception;

    MyordersModel({
        this.listResult,
        this.isSuccess,
        this.affectedRecords,
        this.endUserMessage,
        this.validationErrors,
        this.exception,
    });

    factory MyordersModel.fromJson(Map<String, dynamic> json) => MyordersModel(
        listResult:json["ListResult"]==null ? null : List<ListResultMyorder>.from(json["ListResult"].map((x) => ListResultMyorder.fromJson(x))),
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

class ListResultMyorder {
    int maxRows;
    int id;
    String code;
    int userId;
    String customerName;
    String customerContactNumber;
    double totalPrice;
    int storeId;
    String storeName1;
    String storeName2;
    String storeCityName;
    String storeLandmark;
    String address;
    String landmark;
    String cityName;
    String postalCode;
    String shippingAddress;
    int statusTypeId;
    String status;
    dynamic comments;
    int createdByUserId;
    DateTime createdDate;
    int updatedByUserId;
    DateTime updatedDate;
    int deliveryAgentId;
    String deliveryAgentName;
    String deliveryAgentContactNumber;
    DateTime deliveryDate;
    String timeSlot;

    ListResultMyorder({
        this.maxRows,
        this.id,
        this.code,
        this.userId,
        this.customerName,
        this.customerContactNumber,
        this.totalPrice,
        this.storeId,
        this.storeName1,
        this.storeName2,
        this.storeCityName,
        this.storeLandmark,
        this.address,
        this.landmark,
        this.cityName,
        this.postalCode,
        this.shippingAddress,
        this.statusTypeId,
        this.status,
        this.comments,
        this.createdByUserId,
        this.createdDate,
        this.updatedByUserId,
        this.updatedDate,
        this.deliveryAgentId,
        this.deliveryAgentName,
        this.deliveryAgentContactNumber,
        this.deliveryDate,
        this.timeSlot,
    });

    factory ListResultMyorder.fromJson(Map<String, dynamic> json) => ListResultMyorder(
        maxRows: json["MaxRows"],
        id: json["Id"],
        code: json["Code"],
        userId: json["UserId"],
        customerName: json["CustomerName"],
        customerContactNumber: json["CustomerContactNumber"],
        totalPrice: json["TotalPrice"],
        storeId: json["StoreId"],
        storeName1: json["StoreName1"],
        storeName2: json["StoreName2"],
        storeCityName: json["StoreCityName"],
        storeLandmark: json["StoreLandmark"],
        address: json["Address"],
        landmark: json["Landmark"],
        cityName: json["CityName"],
        postalCode: json["PostalCode"],
        shippingAddress: json["ShippingAddress"],
        statusTypeId: json["StatusTypeId"],
        status: json["Status"],
        comments: json["Comments"],
        createdByUserId: json["CreatedByUserId"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        updatedByUserId: json["UpdatedByUserId"],
        updatedDate: DateTime.parse(json["UpdatedDate"]),
        deliveryAgentId: json["DeliveryAgentId"] == null ? null : json["DeliveryAgentId"],
        deliveryAgentName: json["DeliveryAgentName"] == null ? null : json["DeliveryAgentName"],
        deliveryAgentContactNumber: json["DeliveryAgentContactNumber"] == null ? null : json["DeliveryAgentContactNumber"],
        deliveryDate: DateTime.parse(json["DeliveryDate"]),
        timeSlot: json["TimeSlot"],
    );

    Map<String, dynamic> toJson() => {
        "MaxRows": maxRows,
        "Id": id,
        "Code": code,
        "UserId": userId,
        "CustomerName": customerName,
        "CustomerContactNumber": customerContactNumber,
        "TotalPrice": totalPrice,
        "StoreId": storeId,
        "StoreName1": storeName1,
        "StoreName2": storeName2,
        "StoreCityName": storeCityName,
        "StoreLandmark": storeLandmark,
        "Address": address,
        "Landmark": landmark,
        "CityName": cityName,
        "PostalCode": postalCode,
        "ShippingAddress": shippingAddress,
        "StatusTypeId": statusTypeId,
        "Status": status,
        "Comments": comments,
        "CreatedByUserId": createdByUserId,
        "CreatedDate": createdDate.toIso8601String(),
        "UpdatedByUserId": updatedByUserId,
        "UpdatedDate": updatedDate.toIso8601String(),
        "DeliveryAgentId": deliveryAgentId == null ? null : deliveryAgentId,
        "DeliveryAgentName": deliveryAgentName == null ? null : deliveryAgentName,
        "DeliveryAgentContactNumber": deliveryAgentContactNumber == null ? null : deliveryAgentContactNumber,
        "DeliveryDate": deliveryDate.toIso8601String(),
        "TimeSlot": timeSlot,
    };
}
