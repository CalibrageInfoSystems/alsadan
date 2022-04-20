// To parse this JSON data, do
//
//     final areaNamesModel = areaNamesModelFromJson(jsonString);

import 'dart:convert';

AreaNamesModel areaNamesModelFromJson(String str) => AreaNamesModel.fromJson(json.decode(str));

String areaNamesModelToJson(AreaNamesModel data) => json.encode(data.toJson());

class AreaNamesModel {
    List<ListResultAreaModel> listResult;
    bool isSuccess;
    int affectedRecords;
    String endUserMessage;
    List<dynamic> validationErrors;
    dynamic exception;

    AreaNamesModel({
        this.listResult,
        this.isSuccess,
        this.affectedRecords,
        this.endUserMessage,
        this.validationErrors,
        this.exception,
    });

    factory AreaNamesModel.fromJson(Map<String, dynamic> json) => AreaNamesModel(
        listResult: json["ListResult"] == null ? null : List<ListResultAreaModel>.from(json["ListResult"].map((x) => ListResultAreaModel.fromJson(x))),
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

class ListResultAreaModel {
    String cityCode;
    int cityId;
    int countryId;
    String cityName1;
    String cityName2;
    int areaId;
    String areaName1;
    String areaName2;

    ListResultAreaModel({
        this.cityCode,
        this.cityId,
        this.countryId,
        this.cityName1,
        this.cityName2,
        this.areaId,
        this.areaName1,
        this.areaName2,
    });

    factory ListResultAreaModel.fromJson(Map<String, dynamic> json) => ListResultAreaModel(
        cityCode: json["CityCode"] == null ? null : json["CityCode"],
        cityId: json["CityId"] == null ? null : json["CityId"],
        countryId: json["CountryId"] == null ? null : json["CountryId"],
        cityName1: json["CityName1"] == null ? null : json["CityName1"],
        cityName2: json["CityName2"] == null ? null : json["CityName2"],
        areaId: json["AreaId"] == null ? null : json["AreaId"],
        areaName1: json["AreaName1"] == null ? null : json["AreaName1"],
        areaName2: json["AreaName2"] == null ? null : json["AreaName2"],
    );

    Map<String, dynamic> toJson() => {
        "CityCode": cityCode == null ? null : cityCode,
        "CityId": cityId == null ? null : cityId,
        "CountryId": countryId == null ? null : countryId,
        "CityName1": cityName1 == null ? null : cityName1,
        "CityName2": cityName2 == null ? null : cityName2,
        "AreaId": areaId == null ? null : areaId,
        "AreaName1": areaName1 == null ? null : areaName1,
        "AreaName2": areaName2 == null ? null : areaName2,
    };
}
