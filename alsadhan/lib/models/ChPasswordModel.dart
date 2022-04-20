// To parse this JSON data, do
//
//     final chPasswordModel = chPasswordModelFromJson(jsonString);

import 'dart:convert';

ChPasswordModel chPasswordModelFromJson(String str) => ChPasswordModel.fromJson(json.decode(str));

String chPasswordModelToJson(ChPasswordModel data) => json.encode(data.toJson());

class ChPasswordModel {
    String userId;
    String oldPassword;
    String newPassword;
    String confirmPassword;

    ChPasswordModel({
        this.userId,
        this.oldPassword,
        this.newPassword,
        this.confirmPassword,
    });

    factory ChPasswordModel.fromJson(Map<String, dynamic> json) => ChPasswordModel(
        userId: json["UserId"],
        oldPassword: json["OldPassword"],
        newPassword: json["NewPassword"],
        confirmPassword: json["ConfirmPassword"],
    );

    Map<String, dynamic> toJson() => {
        "UserId": userId,
        "OldPassword": oldPassword,
        "NewPassword": newPassword,
        "ConfirmPassword": confirmPassword,
    };
}
