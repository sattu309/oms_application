class AllCategoryModel {
  bool? success;
  List<Categories>? categories;
  List<Null>? products;

  AllCategoryModel({this.success, this.categories, this.products});

  AllCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    // if (json['products'] != null) {
    //   products = <Null>[];
    //   json['products'].forEach((v) {
    //     products!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    // if (this.products != null) {
    //   data['products'] = this.products!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Categories {
  int? id;
  String? category;
  String? slug;
  String? image;
  dynamic mobileimage;
  int? parentId;
  int? isActive;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Null>? products;

  Categories(
      {this.id,
        this.category,
        this.slug,
        this.image,
        this.mobileimage,
        this.parentId,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.products});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    slug = json['slug'];
    image = json['image'];
    mobileimage = json['mobileimage'];
    parentId = json['parent_id'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // if (json['products'] != null) {
    //   products = <Null>[];
    //   json['products'].forEach((v) {
    //     products!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['mobileimage'] = this.mobileimage;
    data['parent_id'] = this.parentId;
    data['is_active'] = this.isActive;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // if (this.products != null) {
    //   data['products'] = this.products!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
