

import 'dart:convert';

PlaceOrdermodel placeOrdermodelFromJson(String str) => PlaceOrdermodel.fromJson(json.decode(str));

String placeOrdermodelToJson(PlaceOrdermodel data) => json.encode(data.toJson());

class PlaceOrdermodel {
    Order order;
    List<Product> products;

    PlaceOrdermodel({
        this.order,
        this.products,
    });

    factory PlaceOrdermodel.fromJson(Map<String, dynamic> json) => PlaceOrdermodel(
        order: Order.fromJson(json["Order"]),
        products: List<Product>.from(json["Products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Order": order.toJson(),
        "Products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Order {
    int userId;
    double totalPrice;
    int storeId;
    String address;
    String landmark;
    String cityName;
    String postalCode;
    DateTime deliveryDate;
    String timeSlot;

    Order({
        this.userId,
        this.totalPrice,
        this.storeId,
        this.address,
        this.landmark,
        this.cityName,
        this.postalCode,
        this.deliveryDate,
        this.timeSlot,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        userId: json["UserId"],
        totalPrice: json["TotalPrice"].toDouble(),
        storeId: json["StoreId"],
        address: json["Address"],
        landmark: json["Landmark"],
        cityName: json["CityName"],
        postalCode: json["PostalCode"],
        deliveryDate: DateTime.parse(json["DeliveryDate"]),
        timeSlot: json["TimeSlot"],
    );

    Map<String, dynamic> toJson() => {
        "UserId": userId,
        "TotalPrice": totalPrice,
        "StoreId": storeId,
        "Address": address,
        "Landmark": landmark,
        "CityName": cityName,
        "PostalCode": postalCode,
        "DeliveryDate": deliveryDate.toIso8601String(),
        "TimeSlot": timeSlot,
    };
}

class Product {
    int productId;
    double price;
    int quantity;

    Product({
        this.productId,
        this.price,
        this.quantity,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["ProductId"],
        price: json["Price"].toDouble(),
        quantity: json["Quantity"],
    );

    Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "Price": price,
        "Quantity": quantity,
    };
}
