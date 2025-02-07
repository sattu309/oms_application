class OrderModel {
  Order? order;
  List<Orderdetails>? orderdetails;

  OrderModel({this.order, this.orderdetails});

  OrderModel.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    if (json['orderdetails'] != null) {
      orderdetails = <Orderdetails>[];
      json['orderdetails'].forEach((v) {
        orderdetails!.add(new Orderdetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.orderdetails != null) {
      data['orderdetails'] = this.orderdetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int? usersId;
  int? salespersonsId;
  String? orderno;
  String? orderdate;
  int? createdBy;
  int? status;
  int? unitId;
  int? discount;
  int? subtotal;
  int? totalamount;
  String? updatedAt;
  String? createdAt;
  int? id;

  Order(
      {this.usersId,
        this.salespersonsId,
        this.orderno,
        this.orderdate,
        this.createdBy,
        this.status,
        this.unitId,
        this.discount,
        this.subtotal,
        this.totalamount,
        this.updatedAt,
        this.createdAt,
        this.id});

  Order.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    salespersonsId = json['salespersons_id'];
    orderno = json['orderno'];
    orderdate = json['orderdate'];
    createdBy = json['created_by'];
    status = json['status'];
    unitId = json['unit_id'];
    discount = json['discount'];
    subtotal = json['subtotal'];
    totalamount = json['totalamount'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id'] = this.usersId;
    data['salespersons_id'] = this.salespersonsId;
    data['orderno'] = this.orderno;
    data['orderdate'] = this.orderdate;
    data['created_by'] = this.createdBy;
    data['status'] = this.status;
    data['unit_id'] = this.unitId;
    data['discount'] = this.discount;
    data['subtotal'] = this.subtotal;
    data['totalamount'] = this.totalamount;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class Orderdetails {
  int? orderId;
  String? sku;
  String? qty;
  String? price;
  Null? saleprice;
  int? amount;
  String? productId;
  String? productname;
  String? updatedAt;
  String? createdAt;
  int? id;

  Orderdetails(
      {this.orderId,
        this.sku,
        this.qty,
        this.price,
        this.saleprice,
        this.amount,
        this.productId,
        this.productname,
        this.updatedAt,
        this.createdAt,
        this.id});

  Orderdetails.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    sku = json['sku'];
    qty = json['qty'];
    price = json['price'];
    saleprice = json['saleprice'];
    amount = json['amount'];
    productId = json['product_id'];
    productname = json['productname'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['sku'] = this.sku;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['saleprice'] = this.saleprice;
    data['amount'] = this.amount;
    data['product_id'] = this.productId;
    data['productname'] = this.productname;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
