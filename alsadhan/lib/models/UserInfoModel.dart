// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
    List<ListResult> listResult;
    bool isSuccess;
    int affectedRecords;
    String endUserMessage;
    List<dynamic> validationErrors;
    dynamic exception;

    UserInfoModel({
        this.listResult,
        this.isSuccess,
        this.affectedRecords,
        this.endUserMessage,
        this.validationErrors,
        this.exception,
    });

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
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
    String userId;
    String firstName;
    dynamic middleName;
    String lastName;
    String fullName;
    String userName;
    String password;
    int roleId;
    String roleName;
    dynamic managerId;
    String activityRights;
    dynamic managerName;
    String contactNumber;
    dynamic address;
    dynamic email;
    bool isActive;
    dynamic createdByUserId;
    DateTime createdDate;
    dynamic updatedByUserId;
    DateTime updatedDate;
    dynamic landmark;
    dynamic countryId;
    dynamic cityId;
    dynamic locationId;
    dynamic countryName1;
    dynamic countryName2;
    dynamic cityName1;
    dynamic cityName2;
    dynamic locationName1;
    dynamic locationName2;
    dynamic storeIds;

    ListResult({
        this.id,
        this.userId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.fullName,
        this.userName,
        this.password,
        this.roleId,
        this.roleName,
        this.managerId,
        this.activityRights,
        this.managerName,
        this.contactNumber,
        this.address,
        this.email,
        this.isActive,
        this.createdByUserId,
        this.createdDate,
        this.updatedByUserId,
        this.updatedDate,
        this.landmark,
        this.countryId,
        this.cityId,
        this.locationId,
        this.countryName1,
        this.countryName2,
        this.cityName1,
        this.cityName2,
        this.locationName1,
        this.locationName2,
        this.storeIds,
    });

    factory ListResult.fromJson(Map<String, dynamic> json) => ListResult(
        id: json["Id"] == null ? null : json["Id"],
        userId: json["UserId"] == null ? null : json["UserId"],
        firstName: json["FirstName"] == null ? null : json["FirstName"],
        middleName: json["MiddleName"],
        lastName: json["LastName"] == null ? null : json["LastName"],
        fullName: json["FullName"] == null ? null : json["FullName"],
        userName: json["UserName"] == null ? null : json["UserName"],
        password: json["Password"] == null ? null : json["Password"],
        roleId: json["RoleId"] == null ? null : json["RoleId"],
        roleName: json["RoleName"] == null ? null : json["RoleName"],
        managerId: json["ManagerId"],
        activityRights: json["ActivityRights"] == null ? null : json["ActivityRights"],
        managerName: json["ManagerName"],
        contactNumber: json["ContactNumber"] == null ? null : json["ContactNumber"],
        address: json["Address"],
        email: json["Email"],
        isActive: json["IsActive"] == null ? null : json["IsActive"],
        createdByUserId: json["CreatedByUserId"],
        createdDate: json["CreatedDate"] == null ? null : DateTime.parse(json["CreatedDate"]),
        updatedByUserId: json["UpdatedByUserId"],
        updatedDate: json["UpdatedDate"] == null ? null : DateTime.parse(json["UpdatedDate"]),
        landmark: json["Landmark"],
        countryId: json["CountryId"],
        cityId: json["CityId"],
        locationId: json["LocationId"],
        countryName1: json["CountryName1"],
        countryName2: json["CountryName2"],
        cityName1: json["CityName1"],
        cityName2: json["CityName2"],
        locationName1: json["LocationName1"],
        locationName2: json["LocationName2"],
        storeIds: json["StoreIds"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id == null ? null : id,
        "UserId": userId == null ? null : userId,
        "FirstName": firstName == null ? null : firstName,
        "MiddleName": middleName,
        "LastName": lastName == null ? null : lastName,
        "FullName": fullName == null ? null : fullName,
        "UserName": userName == null ? null : userName,
        "Password": password == null ? null : password,
        "RoleId": roleId == null ? null : roleId,
        "RoleName": roleName == null ? null : roleName,
        "ManagerId": managerId,
        "ActivityRights": activityRights == null ? null : activityRights,
        "ManagerName": managerName,
        "ContactNumber": contactNumber == null ? null : contactNumber,
        "Address": address,
        "Email": email,
        "IsActive": isActive == null ? null : isActive,
        "CreatedByUserId": createdByUserId,
        "CreatedDate": createdDate == null ? null : createdDate.toIso8601String(),
        "UpdatedByUserId": updatedByUserId,
        "UpdatedDate": updatedDate == null ? null : updatedDate.toIso8601String(),
        "Landmark": landmark,
        "CountryId": countryId,
        "CityId": cityId,
        "LocationId": locationId,
        "CountryName1": countryName1,
        "CountryName2": countryName2,
        "CityName1": cityName1,
        "CityName2": cityName2,
        "LocationName1": locationName1,
        "LocationName2": locationName2,
        "StoreIds": storeIds,
    };
}
