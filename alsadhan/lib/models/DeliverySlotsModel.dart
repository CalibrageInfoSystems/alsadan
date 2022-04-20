// To parse this JSON data, do
//
//     final deliverySlotsModel = deliverySlotsModelFromJson(jsonString);

import 'dart:convert';

DeliverySlotsModel deliverySlotsModelFromJson(String str) => DeliverySlotsModel.fromJson(json.decode(str));

String deliverySlotsModelToJson(DeliverySlotsModel data) => json.encode(data.toJson());

class DeliverySlotsModel {
    List<ListResult> listResult;
    bool isSuccess;
    int affectedRecords;
    String endUserMessage;
    List<dynamic> validationErrors;
    dynamic exception;

    DeliverySlotsModel({
        this.listResult,
        this.isSuccess,
        this.affectedRecords,
        this.endUserMessage,
        this.validationErrors,
        this.exception,
    });

    factory DeliverySlotsModel.fromJson(Map<String, dynamic> json) => DeliverySlotsModel(
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
    DateTime date;
    String day;
    List<DeliverSlot> deliverSlot;

    ListResult({
        this.date,
        this.day,
        this.deliverSlot,
    });

    factory ListResult.fromJson(Map<String, dynamic> json) => ListResult(
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        day: json["Day"] == null ? null : json["Day"],
        deliverSlot: json["DeliverSlot"] == null ? null : List<DeliverSlot>.from(json["DeliverSlot"].map((x) => DeliverSlot.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Date": date == null ? null : date.toIso8601String(),
        "Day": day == null ? null : day,
        "DeliverSlot": deliverSlot == null ? null : List<dynamic>.from(deliverSlot.map((x) => x.toJson())),
    };
}

class DeliverSlot {
    int id;
    String dayName;
    String slot;
    bool isActive;
    int createdByUserId;
    DateTime createdDate;
    int updatedByUserId;
    DateTime updatedDate;

    DeliverSlot({
        this.id,
        this.dayName,
        this.slot,
        this.isActive,
        this.createdByUserId,
        this.createdDate,
        this.updatedByUserId,
        this.updatedDate,
    });

    factory DeliverSlot.fromJson(Map<String, dynamic> json) => DeliverSlot(
        id: json["Id"] == null ? null : json["Id"],
        dayName: json["DayName"] == null ? null : json["DayName"],
        slot: json["Slot"] == null ? null : json["Slot"],
        isActive: json["IsActive"] == null ? null : json["IsActive"],
        createdByUserId: json["CreatedByUserId"] == null ? null : json["CreatedByUserId"],
        createdDate: json["CreatedDate"] == null ? null : DateTime.parse(json["CreatedDate"]),
        updatedByUserId: json["UpdatedByUserId"] == null ? null : json["UpdatedByUserId"],
        updatedDate: json["UpdatedDate"] == null ? null : DateTime.parse(json["UpdatedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id == null ? null : id,
        "DayName": dayName == null ? null : dayName,
        "Slot": slot == null ? null : slot,
        "IsActive": isActive == null ? null : isActive,
        "CreatedByUserId": createdByUserId == null ? null : createdByUserId,
        "CreatedDate": createdDate == null ? null : createdDate.toIso8601String(),
        "UpdatedByUserId": updatedByUserId == null ? null : updatedByUserId,
        "UpdatedDate": updatedDate == null ? null : updatedDate.toIso8601String(),
    };
}
