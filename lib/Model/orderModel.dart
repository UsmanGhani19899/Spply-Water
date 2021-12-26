class OrderModel {
  String? orderId;
  String? quantity;
  String? userId;
  String? status;
  String? dateOfOrder;

  OrderModel(
      {this.userId,
      this.orderId,
      this.quantity,
      this.status,
      this.dateOfOrder});

  factory OrderModel.fromMap(map) {
    return OrderModel(
        orderId: map["orderId"],
        quantity: map["quantity"],
        status: map["status"],
        userId: map["userId"],
        dateOfOrder: map["dateOfOrder"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "orderId": orderId,
      "quantity": quantity,
      "status": status,
      "userId": userId,
      "dateOfOrder": dateOfOrder,
    };
  }
}
