class OtpVerifyForOrderConfirmationModel {
  String? message;
  Order? order;
  List<OrderDetails>? orderDetails;

  OtpVerifyForOrderConfirmationModel(
      {this.message, this.order, this.orderDetails});

  OtpVerifyForOrderConfirmationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.orderDetails != null) {
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  dynamic id;
  dynamic usersId;
  dynamic otp;
  dynamic salespersonsId;
  dynamic unitId;
  dynamic createdBy;
  dynamic orderno;
  dynamic orderdate;
  dynamic subtotal;
  dynamic status;
  dynamic totalamount;
  dynamic  discount;
  dynamic discountPercentage;
  dynamic cgst;
  dynamic sgst;
  dynamic igst;
  dynamic createdAt;
  dynamic updatedAt;

  Order(
      {this.id,
        this.usersId,
        this.otp,
        this.salespersonsId,
        this.unitId,
        this.createdBy,
        this.orderno,
        this.orderdate,
        this.subtotal,
        this.status,
        this.totalamount,
        this.discount,
        this.createdAt,
        this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    otp = json['otp'];
    salespersonsId = json['salespersons_id'];
    unitId = json['unit_id']?.toString();
    createdBy = json['created_by'];
    orderno = json['orderno'];
    orderdate = json['orderdate'];
    subtotal = json['subtotal'];
    status = json['status'];
    totalamount = json['totalamount'];
    discount = json['discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['users_id'] = this.usersId;
    data['otp'] = this.otp;
    data['salespersons_id'] = this.salespersonsId;
    data['unit_id'] = this.unitId;
    data['created_by'] = this.createdBy;
    data['orderno'] = this.orderno;
    data['orderdate'] = this.orderdate;
    data['subtotal'] = this.subtotal;
    data['status'] = this.status;
    data['totalamount'] = this.totalamount;
    data['discount'] = this.discount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OrderDetails {
  int? id;
  int? orderId;
  int? productId;
  int? qty;
  String? price;
  dynamic saleprice;
  String? amount;
  String? productname;
  String? sku;
  String? createdAt;
  String? updatedAt;

  OrderDetails(
      {this.id,
        this.orderId,
        this.productId,
        this.qty,
        this.price,
        this.saleprice,
        this.amount,
        this.productname,
        this.sku,
        this.createdAt,
        this.updatedAt});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    qty = json['qty'];
    price = json['price'];
    saleprice = json['saleprice'];
    amount = json['amount'];
    productname = json['productname'];
    sku = json['sku'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['saleprice'] = this.saleprice;
    data['amount'] = this.amount;
    data['productname'] = this.productname;
    data['sku'] = this.sku;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
