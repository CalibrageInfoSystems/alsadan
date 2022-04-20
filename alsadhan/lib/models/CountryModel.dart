// To parse this JSON data, do
//
//     final countrymodel = countrymodelFromJson(jsonString);

import 'dart:convert';

Countrymodel countrymodelFromJson(String str) => Countrymodel.fromJson(json.decode(str));

String countrymodelToJson(Countrymodel data) => json.encode(data.toJson());

class Countrymodel {
    List<ListResult> listResult;
    bool isSuccess;
    int affectedRecords;
    String endUserMessage;
    List<dynamic> validationErrors;
    dynamic exception;

    Countrymodel({
        this.listResult,
        this.isSuccess,
        this.affectedRecords,
        this.endUserMessage,
        this.validationErrors,
        this.exception,
    });

    factory Countrymodel.fromJson(Map<String, dynamic> json) => Countrymodel(
        listResult: json["ListResult"] == null ? null : List<ListResult>.from(json["ListResult"].map((x) => ListResult.fromJson(x))),
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

class ListResult {
    int id;
    String name1;
    String name2;
    String code;
    bool isActive;
    int createdByUserId;
    DateTime createdDate;
    int updatedByUserId;
    DateTime updatedDate;

    ListResult({
        this.id,
        this.name1,
        this.name2,
        this.code,
        this.isActive,
        this.createdByUserId,
        this.createdDate,
        this.updatedByUserId,
        this.updatedDate,
    });

    factory ListResult.fromJson(Map<String, dynamic> json) => ListResult(
        id: json["Id"] == null ? null : json["Id"],
        name1: json["Name1"] == null ? null : json["Name1"],
        name2: json["Name2"] == null ? null : json["Name2"],
        code: json["Code"] == null ? null : json["Code"],
        isActive: json["IsActive"] == null ? null : json["IsActive"],
        createdByUserId: json["CreatedByUserId"] == null ? null : json["CreatedByUserId"],
        createdDate: json["CreatedDate"] == null ? null : DateTime.parse(json["CreatedDate"]),
        updatedByUserId: json["UpdatedByUserId"] == null ? null : json["UpdatedByUserId"],
        updatedDate: json["UpdatedDate"] == null ? null : DateTime.parse(json["UpdatedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id == null ? null : id,
        "Name1": name1 == null ? null : name1,
        "Name2": name2 == null ? null : name2,
        "Code": code == null ? null : code,
        "IsActive": isActive == null ? null : isActive,
        "CreatedByUserId": createdByUserId == null ? null : createdByUserId,
        "CreatedDate": createdDate == null ? null : createdDate.toIso8601String(),
        "UpdatedByUserId": updatedByUserId == null ? null : updatedByUserId,
        "UpdatedDate": updatedDate == null ? null : updatedDate.toIso8601String(),
    };
}
