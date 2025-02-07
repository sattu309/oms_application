class SubCategoryModel {
  bool? success;
  List<Categories>? categories;
  List<Products>? products;

  SubCategoryModel({this.success, this.categories, this.products});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  dynamic id;
  dynamic  category;
  dynamic  slug;
  dynamic image;
  dynamic  mobileimage;
  dynamic parentId;
  dynamic isActive;
  dynamic  deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  List<Null>? children;

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
        this.children});

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
    // if (json['children'] != null) {
    //   children = <Null>[];
    //   json['children'].forEach((v) {
    //     children!.add(new Null.fromJson(v));
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
    // if (this.children != null) {
    //   data['children'] = this.children!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Products {
  int? id;
  dynamic  stockCode;
  dynamic  stockHeaderID;
  dynamic  title;
  dynamic  inventory;
  dynamic  categoryId;
  dynamic  description;
  dynamic  royaltyFactor;
  dynamic colorStatus;
  dynamic category;
  dynamic type;
  dynamic mobileimage;
  dynamic  brand;
  dynamic  garmentType;
  dynamic  gender;
  dynamic isUpdate;
  dynamic  updatedAt;
  dynamic  createdAt;
  dynamic  sku;
  dynamic  shortDesc;
  dynamic price;
  dynamic slug;
  dynamic image;
  dynamic unit;
  Pivot? pivot;

  Products(
      {this.id,
        this.stockCode,
        this.stockHeaderID,
        this.title,
        this.inventory,
        this.categoryId,
        this.description,
        this.royaltyFactor,
        this.colorStatus,
        this.category,
        this.type,
        this.brand,
        this.garmentType,
        this.gender,
        this.isUpdate,
        this.updatedAt,
        this.createdAt,
        this.sku,
        this.shortDesc,
        this.mobileimage,
        this.price,
        this.slug,
        this.image,
        this.unit,
        this.pivot});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stockCode = json['StockCode'];
    stockHeaderID = json['StockHeaderID'];
    title = json['title'];
    mobileimage = json['mobileimage'];
    inventory = json['inventory'];
    categoryId = json['category_id'];
    description = json['Description'];
    royaltyFactor = json['RoyaltyFactor'];
    colorStatus = json['ColorStatus'];
    category = json['Category'];
    type = json['Type'];
    brand = json['Brand'];
    garmentType = json['GarmentType'];
    gender = json['Gender'];
    isUpdate = json['is_update'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    sku = json['sku'];
    shortDesc = json['short_desc'];
    price = json['price'];
    slug = json['slug'];
    image = json['image'];
    unit = json['unit_id'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['StockCode'] = this.stockCode;
    data['StockHeaderID'] = this.stockHeaderID;
    data['title'] = this.title;
    data['mobileimage'] = this.mobileimage;
    data['inventory'] = this.inventory;
    data['category_id'] = this.categoryId;
    data['Description'] = this.description;
    data['RoyaltyFactor'] = this.royaltyFactor;
    data['ColorStatus'] = this.colorStatus;
    data['Category'] = this.category;
    data['Type'] = this.type;
    data['Brand'] = this.brand;
    data['GarmentType'] = this.garmentType;
    data['Gender'] = this.gender;
    data['is_update'] = this.isUpdate;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['sku'] = this.sku;
    data['short_desc'] = this.shortDesc;
    data['price'] = this.price;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['unit_id'] = this.unit;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? categoryId;
  int? productId;

  Pivot({this.categoryId, this.productId});

  Pivot.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['product_id'] = this.productId;
    return data;
  }
}
