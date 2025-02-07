class OrderDetailsModel {
  bool? success;
  String? orderId;
  int? status;
  String? orderdate;
  Customer? customer;
  String? totalamount;
  String? subtotal;
  String? discount;
  List<OrderDetail>? orderDetail;

  OrderDetailsModel(
      {this.success,
        this.orderId,
        this.status,
        this.orderdate,
        this.customer,
        this.totalamount,
        this.subtotal,
        this.discount,
        this.orderDetail});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    orderId = json['order_id'];
    status = json['status'];
    orderdate = json['orderdate'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    totalamount = json['totalamount'];
    subtotal = json['subtotal'];
    discount = json['discount'];
    if (json['orderDetail'] != null) {
      orderDetail = <OrderDetail>[];
      json['orderDetail'].forEach((v) {
        orderDetail!.add(new OrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    data['orderdate'] = this.orderdate;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['totalamount'] = this.totalamount;
    data['subtotal'] = this.subtotal;
    data['discount'] = this.discount;
    if (this.orderDetail != null) {
      data['orderDetail'] = this.orderDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  int? id;
  int? usersId;
  String? name;
  String? lname;
  int? isActive;
  String? email;
  String? email2;
  String? phone;
  String? phone2;
  String? address;
  String? address2;
  String? cpName;
  String? cpPhone;
  String? state;
  String? city;
  int? pincode;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
        this.usersId,
        this.name,
        this.lname,
        this.isActive,
        this.email,
        this.email2,
        this.phone,
        this.phone2,
        this.address,
        this.address2,
        this.cpName,
        this.cpPhone,
        this.state,
        this.city,
        this.pincode,
        this.createdAt,
        this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    name = json['name'];
    lname = json['lname'];
    isActive = json['is_active'];
    email = json['email'];
    email2 = json['email2'];
    phone = json['phone'];
    phone2 = json['phone2'];
    address = json['address'];
    address2 = json['address2'];
    cpName = json['cp_name'];
    cpPhone = json['cp_phone'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['users_id'] = this.usersId;
    data['name'] = this.name;
    data['lname'] = this.lname;
    data['is_active'] = this.isActive;
    data['email'] = this.email;
    data['email2'] = this.email2;
    data['phone'] = this.phone;
    data['phone2'] = this.phone2;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['cp_name'] = this.cpName;
    data['cp_phone'] = this.cpPhone;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OrderDetail {
  int? id;
  int? orderId;
  int? productId;
  String? unitId;
  int? qty;
  String? price;
  String? saleprice;
  String? amount;
  String? productname;
  String? sku;

  OrderDetail(
      {this.id,
        this.orderId,
        this.productId,
        this.unitId,
        this.qty,
        this.price,
        this.saleprice,
        this.amount,
        this.productname,
        this.sku});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    unitId = json['unit_id'];
    qty = json['qty'];
    price = json['price'];
    saleprice = json['saleprice'];
    amount = json['amount'];
    productname = json['productname'];
    sku = json['sku'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['unit_id'] = this.unitId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['saleprice'] = this.saleprice;
    data['amount'] = this.amount;
    data['productname'] = this.productname;
    data['sku'] = this.sku;
    return data;
  }
}
