class OrderHistoryModel {
  String? id;
  String? date;
  String? pName;
  num? pPrice;
  int? pQuantity;
  num? totalPrice;
  bool? isExpanded;

  OrderHistoryModel(
    this.id,
    this.date,
    this.pName,
    this.pPrice,
    this.pQuantity,
    this.totalPrice,
  );

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    pName = json['pName'];
    pPrice = json['pPrice'];
    pQuantity = json['pQuantity'];
    totalPrice = json['totalPrice'];
  }
}

class OrderHistoryCombined {
  List<OrderHistoryModel> orders = [];
  double totalPrice = 0.0;
}
