class OrderModel {
  String? orderId;
  String? quantity;
  String? name;
  String? address;
  String? userId;
  String? status;
  String? dateOfOrder;

  OrderModel(
      {this.name,
      this.address,
      this.userId,
      this.orderId,
      this.quantity,
      this.status,
      this.dateOfOrder});

  factory OrderModel.fromMap(map) {
    return OrderModel(
        name: map["name"],
        address: map["address"],
        orderId: map["orderId"],
        quantity: map["quantity"],
        status: map["status"],
        userId: map["userId"],
        dateOfOrder: map["dateOfOrder"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "address": address,
      "name": name,
      "orderId": orderId,
      "quantity": quantity,
      "status": status,
      "userId": userId,
      "dateOfOrder": dateOfOrder,
    };
  }
}
