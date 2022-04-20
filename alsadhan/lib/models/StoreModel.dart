// To parse this JSON data, do
//
//     final storesModel = storesModelFromJson(jsonString);

import 'dart:convert';

StoresModel storesModelFromJson(String str) => StoresModel.fromJson(json.decode(str));

String storesModelToJson(StoresModel data) => json.encode(data.toJson());

class StoresModel {
    List<ListResultStore> listResult;
    bool isSuccess;
    int affectedRecords;
    String endUserMessage;
    List<dynamic> validationErrors;
    dynamic exception;

    StoresModel({
        this.listResult,
        this.isSuccess,
        this.affectedRecords,
        this.endUserMessage,
        this.validationErrors,
        this.exception,
    });

    factory StoresModel.fromJson(Map<String, dynamic> json) => StoresModel(
        listResult: List<ListResultStore>.from(json["ListResult"].map((x) => ListResultStore.fromJson(x))),
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

class ListResultStore {
    int id;
    String name1;
    String name2;
    dynamic fileName;
    dynamic fileLocation;
    dynamic fileExtension;
    dynamic filepath;
    String address;
    String landmark;
    String cityName;
    dynamic postalCode;
    String fullAddress;
    bool isActive;
    int createdByUserId;
    DateTime createdDate;
    int updatedByUserId;
    DateTime updatedDate;

    ListResultStore({
        this.id,
        this.name1,
        this.name2,
        this.fileName,
        this.fileLocation,
        this.fileExtension,
        this.filepath,
        this.address,
        this.landmark,
        this.cityName,
        this.postalCode,
        this.fullAddress,
        this.isActive,
        this.createdByUserId,
        this.createdDate,
        this.updatedByUserId,
        this.updatedDate,
    });

    factory ListResultStore.fromJson(Map<String, dynamic> json) => ListResultStore(
        id: json["Id"],
        name1: json["Name1"],
        name2: json["Name2"],
        fileName: json["FileName"],
        fileLocation: json["FileLocation"],
        fileExtension: json["FileExtension"],
        filepath: json["Filepath"],
        address: json["Address"],
        landmark: json["Landmark"],
        cityName: json["CityName"],
        postalCode: json["PostalCode"],
        fullAddress: json["FullAddress"],
        isActive: json["IsActive"],
        createdByUserId: json["CreatedByUserId"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        updatedByUserId: json["UpdatedByUserId"],
        updatedDate: DateTime.parse(json["UpdatedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name1": name1,
        "Name2": name2,
        "FileName": fileName,
        "FileLocation": fileLocation,
        "FileExtension": fileExtension,
        "Filepath": filepath,
        "Address": address,
        "Landmark": landmark,
        "CityName": cityName,
        "PostalCode": postalCode,
        "FullAddress": fullAddress,
        "IsActive": isActive,
        "CreatedByUserId": createdByUserId,
        "CreatedDate": createdDate.toIso8601String(),
        "UpdatedByUserId": updatedByUserId,
        "UpdatedDate": updatedDate.toIso8601String(),
    };
}
