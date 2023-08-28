import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  String id;
  String customerName;
  String customerPhone;
  String customerAddress;
  String customerEmail;
  String orderName;
  String orderId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Post({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerEmail,
    required this.orderName,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        customerName: json["customerName"],
        customerPhone: json["customerPhone"],
        customerAddress: json["customerAddress"],
        customerEmail: json["customerEmail"],
        orderName: json["orderName"],
        orderId: json["orderId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerName": customerName,
        "customerPhone": customerPhone,
        "customerAddress": customerAddress,
        "customerEmail": customerEmail,
        "orderName": orderName,
        "orderId": orderId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
