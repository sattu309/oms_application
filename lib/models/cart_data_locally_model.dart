class CartDataLocallyModel {
  String? productName;
  String? productPrice;
  String? productSalePrice;
  String? productId;
  String? productImg;
  String? productSku;
  String? qty;

  CartDataLocallyModel(
      {this.productName,
        this.productPrice,
        this.productSalePrice,
        this.productId,
        this.productImg,
        this.productSku,
        this.qty});

  CartDataLocallyModel.fromJson(Map<String, dynamic> json) {
    productName = json['productname'];
    productPrice = json['price'];
    productSalePrice = json['saleprice'];
    productId = json['product_id'];
    productImg = json['product_img'];
    productSku = json['sku'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productname'] = this.productName;
    data['price'] = this.productPrice;
    data['saleprice'] = this.productSalePrice;
    data['product_id'] = this.productId;
    data['product_img'] = this.productImg;
    data['sku'] = this.productSku;
    data['qty'] = this.qty;
    return data;
  }
}
