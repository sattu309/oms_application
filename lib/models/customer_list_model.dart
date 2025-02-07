class CustomerListModel {
  List<Success>? success;

  CustomerListModel({this.success});

  CustomerListModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = <Success>[];
      json['success'].forEach((v) {
        success!.add(new Success.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class  Success {
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
  String? panno;
  String? gstno;
  String? address2;
  String? cpName;
  String? cpPhone;
  String? state;
  String? city;
  int? pincode;
  String? createdAt;
  String? updatedAt;

  Success(
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
        this.panno,
        this.gstno,
        this.address2,
        this.cpName,
        this.cpPhone,
        this.state,
        this.city,
        this.pincode,
        this.createdAt,
        this.updatedAt});

  Success.fromJson(Map<String, dynamic> json) {
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
    panno = json['panno'];
    gstno = json['gstno'];
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
    data['panno'] = this.panno;
    data['gstno'] = this.gstno;
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
