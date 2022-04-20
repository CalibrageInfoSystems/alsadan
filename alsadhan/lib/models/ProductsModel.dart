// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
    List<ListResultProduct> listResult;
    bool isSuccess;
    int affectedRecords;
    String endUserMessage;
    List<dynamic> validationErrors;
    dynamic exception;

    ProductsModel({
        this.listResult,
        this.isSuccess,
        this.affectedRecords,
        this.endUserMessage,
        this.validationErrors,
        this.exception,
    });

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        listResult: json["ListResult"] == null ? null : List<ListResultProduct>.from(json["ListResult"].map((x) => ListResultProduct.fromJson(x))),
        isSuccess: json["IsSuccess"] == null ? null : json["IsSuccess"],
        affectedRecords: json["AffectedRecords"] == null ? null : json["AffectedRecords"],
        endUserMessage: json["EndUserMessage"] == null ? null : json["EndUserMessage"],
        validationErrors: json["ValidationErrors"] == null ? null : List<dynamic>.from(json["ValidationErrors"].map((x) => x)),
        exception: json["Exception"],
    );

    Map<String, dynamic> toJson() => {
        "ListResult": listResult == null ? null : List<dynamic>.from(listResult.map((x) => x.toJson())),
        "IsSuccess": isSuccess == null ? null : isSuccess,
        "AffectedRecords": affectedRecords == null ? null : affectedRecords,
        "EndUserMessage": endUserMessage == null ? null : endUserMessage,
        "ValidationErrors": validationErrors == null ? null : List<dynamic>.from(validationErrors.map((x) => x)),
        "Exception": exception,
    };
}

class ListResultProduct {
    int itemCount=0;
    int maxRows;
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
    FileName fileName;
    FileExtension fileExtension;
    FileLocation fileLocation;
    String filepath;

    ListResultProduct({
        this.maxRows,
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
        this.itemCount
    });

    factory ListResultProduct.fromJson(Map<String, dynamic> json) => ListResultProduct(
        maxRows: json["MaxRows"] == null ? null : json["MaxRows"],
        productId: json["ProductId"] == null ? null : json["ProductId"],
        code: json["Code"] == null ? null : json["Code"],
        name1: json["Name1"] == null ? null : json["Name1"],
        name2: json["Name2"] == null ? null : json["Name2"],
        description1: json["Description1"] == null ? null : json["Description1"],
        description2: json["Description2"] == null ? null : json["Description2"],
        price: json["Price"] == null ? null : json["Price"],
        discountedPrice: json["DiscountedPrice"] == null ? null : json["DiscountedPrice"],
        isActive: json["IsActive"] == null ? null : json["IsActive"],
        createdByUserId: json["CreatedByUserId"] == null ? null : json["CreatedByUserId"],
        createdDate: json["CreatedDate"] == null ? null : DateTime.parse(json["CreatedDate"]),
        updatedByUserId: json["UpdatedByUserId"] == null ? null : json["UpdatedByUserId"],
        updatedDate: json["UpdatedDate"] == null ? null : DateTime.parse(json["UpdatedDate"]),
        fileName: json["FileName"] == null ? null : fileNameValues.map[json["FileName"]],
        fileExtension: json["FileExtension"] == null ? null : fileExtensionValues.map[json["FileExtension"]],
        fileLocation: json["FileLocation"] == null ? null : fileLocationValues.map[json["FileLocation"]],
        filepath: json["Filepath"] == null ? null : json["Filepath"],
        itemCount:json["ItemCount"] == null ? 0:json["ItemCount"] ,
        
    );

    Map<String, dynamic> toJson() => {
        "MaxRows": maxRows == null ? null : maxRows,
        "ProductId": productId == null ? null : productId,
        "Code": code == null ? null : code,
        "Name1": name1 == null ? null : name1,
        "Name2": name2 == null ? null : name2,
        "Description1": description1 == null ? null : description1,
        "Description2": description2 == null ? null : description2,
        "Price": price == null ? null : price,
        "DiscountedPrice": discountedPrice == null ? null : discountedPrice,
        "IsActive": isActive == null ? null : isActive,
        "CreatedByUserId": createdByUserId == null ? null : createdByUserId,
        "CreatedDate": createdDate == null ? null : createdDate.toIso8601String(),
        "UpdatedByUserId": updatedByUserId == null ? null : updatedByUserId,
        "UpdatedDate": updatedDate == null ? null : updatedDate.toIso8601String(),
        "FileName": fileName == null ? null : fileNameValues.reverse[fileName],
        "FileExtension": fileExtension == null ? null : fileExtensionValues.reverse[fileExtension],
        "FileLocation": fileLocation == null ? null : fileLocationValues.reverse[fileLocation],
        "Filepath": filepath == null ? null : filepath,
        "ItemCount":itemCount == null ?0 : itemCount

    };
}

enum FileExtension { JPG }

final fileExtensionValues = EnumValues({
    ".jpg": FileExtension.JPG
});

enum FileLocation { PRODUCTS }

final fileLocationValues = EnumValues({
    "Products": FileLocation.PRODUCTS
});

enum FileName { PRODUCT }

final fileNameValues = EnumValues({
    "Product": FileName.PRODUCT
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
