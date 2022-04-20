// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    Result result;
    bool isSuccess;
    int affectedRecords;
    String endUserMessage;
    List<dynamic> validationErrors;
    dynamic exception;

    CartModel({
        this.result,
        this.isSuccess,
        this.affectedRecords,
        this.endUserMessage,
        this.validationErrors,
        this.exception,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        result:json["Result"] == null ? null : Result.fromJson(json["Result"]),
        isSuccess: json["IsSuccess"],
        affectedRecords: json["AffectedRecords"],
        endUserMessage: json["EndUserMessage"],
        validationErrors: List<dynamic>.from(json["ValidationErrors"].map((x) => x)),
        exception: json["Exception"],
    );

    Map<String, dynamic> toJson() => {
        "Result": result.toJson(),
        "IsSuccess": isSuccess,
        "AffectedRecords": affectedRecords,
        "EndUserMessage": endUserMessage,
        "ValidationErrors": List<dynamic>.from(validationErrors.map((x) => x)),
        "Exception": exception,
    };
}

class Result {
    Cart cart;
    List<ProductsList> productsList;

    Result({
        this.cart,
        this.productsList,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        cart: Cart.fromJson(json["cart"]),
        productsList: List<ProductsList>.from(json["productsList"].map((x) => ProductsList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cart": cart.toJson(),
        "productsList": List<dynamic>.from(productsList.map((x) => x.toJson())),
    };
}

class Cart {
    int id;
    int userId;
    String name;
    DateTime createdDate;
    DateTime updatedDate;

    Cart({
        this.id,
        this.userId,
        this.name,
        this.createdDate,
        this.updatedDate,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["Id"],
        userId: json["UserId"],
        name: json["Name"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        updatedDate: DateTime.parse(json["UpdatedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "Name": name,
        "CreatedDate": createdDate.toIso8601String(),
        "UpdatedDate": updatedDate.toIso8601String(),
    };
}

class ProductsList {
    int id;
    int userCartId;
    int quantity;
    int productId;
    String code;
    String name1;
    String name2;
    String description1;
    String description2;
    double price;
    double discountedPrice;
    bool isActive;
    int createdByUserId;
    DateTime createdDate;
    int updatedByUserId;
    DateTime updatedDate;
    String fileName;
    String fileExtension;
    String fileLocation;
    String filepath;
    int discountPercentage;
    double actualPrice;

    ProductsList({
        this.id,
        this.userCartId,
        this.quantity,
        this.productId,
        this.code,
        this.name1,
        this.name2,
        this.description1,
        this.description2,
        this.price,
        this.discountedPrice,
        this.isActive,
        this.createdByUserId,
        this.createdDate,
        this.updatedByUserId,
        this.updatedDate,
        this.fileName,
        this.fileExtension,
        this.fileLocation,
        this.filepath,
        this.discountPercentage,
        this.actualPrice,
    });

    factory ProductsList.fromJson(Map<String, dynamic> json) => ProductsList(
        id: json["Id"],
        userCartId: json["UserCartId"],
        quantity: json["Quantity"],
        productId: json["ProductId"],
        code: json["Code"],
        name1: json["Name1"],
        name2: json["Name2"],
        description1: json["Description1"],
        description2: json["Description2"],
        price: json["Price"].toDouble(),
        discountedPrice: json["DiscountedPrice"].toDouble(),
        isActive: json["IsActive"],
        createdByUserId: json["CreatedByUserId"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        updatedByUserId: json["UpdatedByUserId"],
        updatedDate: DateTime.parse(json["UpdatedDate"]),
        fileName: json["FileName"],
        fileExtension: json["FileExtension"],
        fileLocation: json["FileLocation"],
        filepath: json["Filepath"],
        discountPercentage: json["DiscountPercentage"],
        actualPrice: json["ActualPrice"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserCartId": userCartId,
        "Quantity": quantity,
        "ProductId": productId,
        "Code": code,
        "Name1": name1,
        "Name2": name2,
        "Description1": description1,
        "Description2": description2,
        "Price": price,
        "DiscountedPrice": discountedPrice,
        "IsActive": isActive,
        "CreatedByUserId": createdByUserId,
        "CreatedDate": createdDate.toIso8601String(),
        "UpdatedByUserId": updatedByUserId,
        "UpdatedDate": updatedDate.toIso8601String(),
        "FileName": fileName,
        "FileExtension": fileExtension,
        "FileLocation": fileLocation,
        "Filepath": filepath,
        "DiscountPercentage": discountPercentage,
        "ActualPrice": actualPrice,
    };
}
