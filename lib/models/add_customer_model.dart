class AddCustomerModel {
  String? success;
  Customer? customer;

  AddCustomerModel({this.success, this.customer});

  AddCustomerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  String? name;
  String? lname;
  String? email;
  String? phone;
  String? email2;
  String? phone2;
  String? address;
  String? address2;
  String? cpName;
  String? cpPhone;
  String? state;
  String? city;
  String? pincode;
  String? updatedAt;
  int? usersId;
  String? createdAt;
  int? id;

  Customer(
      {this.name,
        this.lname,
        this.email,
        this.phone,
        this.email2,
        this.phone2,
        this.address,
        this.address2,
        this.cpName,
        this.cpPhone,
        this.state,
        this.city,
        this.pincode,
        this.updatedAt,
        this.usersId,
        this.createdAt,
        this.id});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lname = json['lname'];
    email = json['email'];
    phone = json['phone'];
    email2 = json['email2'];
    phone2 = json['phone2'];
    address = json['address'];
    address2 = json['address2'];
    cpName = json['cp_name'];
    cpPhone = json['cp_phone'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    updatedAt = json['updated_at'];
    usersId = json['users_id'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email2'] = this.email2;
    data['phone2'] = this.phone2;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['cp_name'] = this.cpName;
    data['cp_phone'] = this.cpPhone;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['updated_at'] = this.updatedAt;
    data['users_id'] = this.usersId;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
