class DashBoardModel {
  int? totalProducts;
  int? totalInventory;
  List<RecentOrder>? recentOrder;
  List<RecentCustomer>? recentCustomer;

  DashBoardModel(
      {this.totalProducts,
        this.totalInventory,
        this.recentOrder,
        this.recentCustomer});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    totalProducts = json['Total Products'];
    totalInventory = json['Total Inventory'];
    if (json['RecentOrder'] != null) {
      recentOrder = <RecentOrder>[];
      json['RecentOrder'].forEach((v) {
        recentOrder!.add(new RecentOrder.fromJson(v));
      });
    }
    if (json['RecentCustomer'] != null) {
      recentCustomer = <RecentCustomer>[];
      json['RecentCustomer'].forEach((v) {
        recentCustomer!.add(new RecentCustomer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Total Products'] = this.totalProducts;
    data['Total Inventory'] = this.totalInventory;
    if (this.recentOrder != null) {
      data['RecentOrder'] = this.recentOrder!.map((v) => v.toJson()).toList();
    }
    if (this.recentCustomer != null) {
      data['RecentCustomer'] =
          this.recentCustomer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentOrder {
  int? id;
  int? customerId;
  int? otp;
  int? salespersonsId;
  int? createdBy;
  String? orderno;
  dynamic latitude;
  dynamic longitude;
  String? orderdate;
  String? subtotal;
  int? status;
  String? totalamount;
  String? discount;
  dynamic discountPercentage;
  dynamic cgst;
  dynamic sgst;
  dynamic igst;
  String? createdAt;
  String? updatedAt;
  String? customerName;
  String? city;

  RecentOrder(
      {this.id,
        this.customerId,
        this.otp,
        this.salespersonsId,
        this.createdBy,
        this.orderno,
        this.latitude,
        this.longitude,
        this.orderdate,
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
        this.customerName,
        this.city});

  RecentOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    otp = json['otp'];
    salespersonsId = json['salespersons_id'];
    createdBy = json['created_by'];
    orderno = json['orderno'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['otp'] = this.otp;
    data['salespersons_id'] = this.salespersonsId;
    data['created_by'] = this.createdBy;
    data['orderno'] = this.orderno;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
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
    data['city'] = this.city;
    return data;
  }
}

class RecentCustomer {
  int? id;
  int? usersId;
  String? name;
  String? lname;
  String? panno;
  String? gstno;
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

  RecentCustomer(
      {this.id,
        this.usersId,
        this.name,
        this.lname,
        this.panno,
        this.gstno,
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

  RecentCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    name = json['name'];
    lname = json['lname'];
    panno = json['panno'];
    gstno = json['gstno'];
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
    data['panno'] = this.panno;
    data['gstno'] = this.gstno;
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
