// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    Result result;
    bool isSuccess;
    int affectedRecords;
    String endUserMessage;
    List<dynamic> validationErrors;
    dynamic exception;

    UserModel({
        this.result,
        this.isSuccess,
        this.affectedRecords,
        this.endUserMessage,
        this.validationErrors,
        this.exception,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        result: Result.fromJson(json["Result"]),
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
    int id;
    String userId;
    String firstName;
    String middleName;
    String lastname;
    String contactNumber;
    dynamic email;
    String userName;
    String password;
    int roleId;
    bool isActive;
    dynamic createdByUserId;
    DateTime createdDate;
    dynamic updatedByUserId;
    DateTime updatedDate;
    dynamic managerId;
    dynamic address;

    Result({
        this.id,
        this.userId,
        this.firstName,
        this.middleName,
        this.lastname,
        this.contactNumber,
        this.email,
        this.userName,
        this.password,
        this.roleId,
        this.isActive,
        this.createdByUserId,
        this.createdDate,
        this.updatedByUserId,
        this.updatedDate,
        this.managerId,
        this.address,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["Id"],
        userId: json["UserId"],
        firstName: json["FirstName"],
        middleName: json["MiddleName"],
        lastname: json["Lastname"],
        contactNumber: json["ContactNumber"],
        email: json["Email"],
        userName: json["UserName"],
        password: json["Password"],
        roleId: json["RoleId"],
        isActive: json["IsActive"],
        createdByUserId: json["CreatedByUserId"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        updatedByUserId: json["UpdatedByUserId"],
        updatedDate: DateTime.parse(json["UpdatedDate"]),
        managerId: json["ManagerId"],
        address: json["Address"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "FirstName": firstName,
        "MiddleName": middleName,
        "Lastname": lastname,
        "ContactNumber": contactNumber,
        "Email": email,
        "UserName": userName,
        "Password": password,
        "RoleId": roleId,
        "IsActive": isActive,
        "CreatedByUserId": createdByUserId,
        "CreatedDate": createdDate.toIso8601String(),
        "UpdatedByUserId": updatedByUserId,
        "UpdatedDate": updatedDate.toIso8601String(),
        "ManagerId": managerId,
        "Address": address,
    };
}
