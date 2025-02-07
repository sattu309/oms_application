class UserInfoModel {
  String? rememberToken;
  int? id;
  String? name;
  Null? lname;
  String? phone;
  String? email;
  int? userrole;

  UserInfoModel(
      {this.rememberToken,
        this.id,
        this.name,
        this.lname,
        this.phone,
        this.email,
        this.userrole});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    rememberToken = json['remember_token'];
    id = json['id'];
    name = json['name'];
    lname = json['lname'];
    phone = json['phone'];
    email = json['email'];
    userrole = json['userrole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remember_token'] = this.rememberToken;
    data['id'] = this.id;
    data['name'] = this.name;
    data['lname'] = this.lname;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['userrole'] = this.userrole;
    return data;
  }
}
