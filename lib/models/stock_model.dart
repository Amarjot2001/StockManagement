class StockModel {
  String? id;
  String? productId;
  String? expiry;
  num? mrp;
  num? costPrice;
  num? discountedPrice;
  int? availableStock;
  int? soldStock;
  String? batchCode;
  String? barCode;

  StockModel(
      this.id,
      this.productId,
      this.expiry,
      this.mrp,
      this.costPrice,
      this.discountedPrice,
      this.availableStock,
      this.soldStock,
      this.batchCode,
      this.barCode);

  StockModel.fromJson(Map<String, dynamic> json) {
    print("Json = $json");
    id = json['id'];
    productId = json['productId'];
    expiry = json['expiry'];
    mrp = json['mrp'];
    costPrice = json['costPrice'];
    discountedPrice = json['discountedPrice'];
    availableStock = json['availableStock'];
    soldStock = json['soldStock'];
    batchCode = json['batchCode'];
    barCode = json['barCode'];
  }
}
