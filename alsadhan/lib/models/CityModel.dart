// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
    List<ListResult> listResult;
    bool isSuccess;
    int affectedRecords;
    String endUserMessage;
    List<dynamic> validationErrors;
    dynamic exception;

    CityModel({
        this.listResult,
        this.isSuccess,
        this.affectedRecords,
        this.endUserMessage,
        this.validationErrors,
        this.exception,
    });

    factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
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
    int countryId;
    CountryName countryName1;
    CountryName countryName2;
    CountryCode countryCode;
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
        this.countryId,
        this.countryName1,
        this.countryName2,
        this.countryCode,
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
        countryId: json["CountryId"] == null ? null : json["CountryId"],
        countryName1: json["CountryName1"] == null ? null : countryNameValues.map[json["CountryName1"]],
        countryName2: json["CountryName2"] == null ? null : countryNameValues.map[json["CountryName2"]],
        countryCode: json["CountryCode"] == null ? null : countryCodeValues.map[json["CountryCode"]],
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
        "CountryId": countryId == null ? null : countryId,
        "CountryName1": countryName1 == null ? null : countryNameValues.reverse[countryName1],
        "CountryName2": countryName2 == null ? null : countryNameValues.reverse[countryName2],
        "CountryCode": countryCode == null ? null : countryCodeValues.reverse[countryCode],
        "IsActive": isActive == null ? null : isActive,
        "CreatedByUserId": createdByUserId == null ? null : createdByUserId,
        "CreatedDate": createdDate == null ? null : createdDate.toIso8601String(),
        "UpdatedByUserId": updatedByUserId == null ? null : updatedByUserId,
        "UpdatedDate": updatedDate == null ? null : updatedDate.toIso8601String(),
    };
}

enum CountryCode { SA }

final countryCodeValues = EnumValues({
    "SA": CountryCode.SA
});

enum CountryName { SAUDI_ARABIA }

final countryNameValues = EnumValues({
    "Saudi Arabia": CountryName.SAUDI_ARABIA
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
