// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    List<ListResult> listResult;
    bool isSuccess;
    int affectedRecords;
    String endUserMessage;
    List<dynamic> validationErrors;
    dynamic exception;

    CategoryModel({
        this.listResult,
        this.isSuccess,
        this.affectedRecords,
        this.endUserMessage,
        this.validationErrors,
        this.exception,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
    int id;
    String name1;
    String name2;
    int categoryLevel;
    int parentCategoryId;
    String parentCategoryName1;
    String parentCategoryName2;
    bool isActive;
    int createdByUserId;
    DateTime createdDate;
    int updatedByUserId;
    DateTime updatedDate;

    ListResult({
        this.id,
        this.name1,
        this.name2,
        this.categoryLevel,
        this.parentCategoryId,
        this.parentCategoryName1,
        this.parentCategoryName2,
        this.isActive,
        this.createdByUserId,
        this.createdDate,
        this.updatedByUserId,
        this.updatedDate,
    });

    factory ListResult.fromJson(Map<String, dynamic> json) => ListResult(
        id: json["Id"],
        name1: json["Name1"],
        name2: json["Name2"],
        categoryLevel: json["CategoryLevel"],
        parentCategoryId: json["ParentCategoryId"] == null ? null : json["ParentCategoryId"],
        parentCategoryName1: json["ParentCategoryName1"] == null ? null : json["ParentCategoryName1"],
        parentCategoryName2: json["ParentCategoryName2"] == null ? null : json["ParentCategoryName2"],
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
        "CategoryLevel": categoryLevel,
        "ParentCategoryId": parentCategoryId == null ? null : parentCategoryId,
        "ParentCategoryName1": parentCategoryName1 == null ? null : parentCategoryName1,
        "ParentCategoryName2": parentCategoryName2 == null ? null : parentCategoryName2,
        "IsActive": isActive,
        "CreatedByUserId": createdByUserId,
        "CreatedDate": createdDate.toIso8601String(),
        "UpdatedByUserId": updatedByUserId,
        "UpdatedDate": updatedDate.toIso8601String(),
    };
}
