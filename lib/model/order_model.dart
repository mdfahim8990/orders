class OrderModel {
  String? orderId;
  String? orderDate;
  String? cusName;
  String? cusNumber;
  String? totalAmount;
  String? deliveryPersonId;
  String? deliveryStatus;
  List<String>? orderItems;

  OrderModel(
      {this.orderId,
        this.orderDate,
        this.cusName,
        this.cusNumber,
        this.totalAmount,
        this.deliveryPersonId,
        this.deliveryStatus,
        this.orderItems
      });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId : json['OrderId']??'',
      orderDate : json['CreatedAt'].cast<String>(),
      cusName : json['CustomerName'],
      cusNumber : json['LastModified'],
      totalAmount : json['TotalAmount'],
      deliveryPersonId : json['CreatedBy'],
      deliveryStatus : json['OrderStatus'],
      orderItems : json['OrderItems'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderId'] = this.orderId;
    data['CreatedAt'] = this.orderDate;
    data['CustomerName'] = this.cusName;
    data['LastModified'] = this.cusNumber;
    data['TotalAmount'] = this.totalAmount;
    data['CreatedBy'] = this.deliveryPersonId;
    data['OrderStatus'] = this.deliveryStatus;
    data['OrderItems'] = this.orderItems;
    return data;
  }
}