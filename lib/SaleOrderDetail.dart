class SaleOrderDetail {
  final String detailId;
  final String saleId;
  final int productId; 
	final int quantity;
	final int price;
	final String currency; 
	final int status;
 
  SaleOrderDetail({this.detailId, this.saleId, this.productId, this.quantity, this.price, this.currency, this.status});
 
  factory SaleOrderDetail.fromJson(Map<String, dynamic> json) {
    return SaleOrderDetail(
        detailId: json['detailId'],
        saleId: json['saleId'],
        productId: json['productId'],
        quantity: json['quantity'],
        price: json['price'],
        currency: json['currency'],
        status: json['status']
    );
  }
 
  Map toMap() {
      var map = new Map<String, dynamic>();
      map["detailId"] = detailId;
      map["saleId"] = saleId;
      map["productId"] = productId;
      map["quantity"] = quantity;
      map["price"] = price;
      map["currency"] = currency;
      map["status"] = status;   
    
      return map;
  }
}
 