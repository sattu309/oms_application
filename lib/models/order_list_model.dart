class OrderListModel {
  bool? success;
  List<Orders>? orders;

  OrderListModel({this.success, this.orders});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? id;
  int? customerId;
  int? otp;
  int? salespersonsId;
  int? createdBy;
  String? orderno;
  String? orderdate;
  String? subtotal;
  String? city;
  int? status;
  String? totalamount;
  String? discount;
  Null? discountPercentage;
  Null? cgst;
  Null? sgst;
  Null? igst;
  String? createdAt;
  String? updatedAt;
  String? customerName;

  Orders(
      {this.id,
        this.customerId,
        this.otp,
        this.salespersonsId,
        this.createdBy,
        this.orderno,
        this.orderdate,
        this.city,
        this.subtotal,
        this.status,
        this.totalamount,
        this.discount,
        this.discountPercentage,
        this.cgst,
        this.sgst,
        this.igst,
        this.createdAt,
        this.updatedAt,
        this.customerName});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    otp = json['otp'];
    salespersonsId = json['salespersons_id'];
    createdBy = json['created_by'];
    orderno = json['orderno'];
    city = json['city'];
    orderdate = json['orderdate'];
    subtotal = json['subtotal'];
    status = json['status'];
    totalamount = json['totalamount'];
    discount = json['discount'];
    discountPercentage = json['discount_percentage'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerName = json['customer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['otp'] = this.otp;
    data['salespersons_id'] = this.salespersonsId;
    data['created_by'] = this.createdBy;
    data['orderno'] = this.orderno;
    data['city'] = this.city;
    data['orderdate'] = this.orderdate;
    data['subtotal'] = this.subtotal;
    data['status'] = this.status;
    data['totalamount'] = this.totalamount;
    data['discount'] = this.discount;
    data['discount_percentage'] = this.discountPercentage;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['igst'] = this.igst;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer_name'] = this.customerName;
    return data;
  }
}
