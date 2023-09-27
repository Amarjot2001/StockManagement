import 'package:stock_management/models/product_model.dart';
import 'package:stock_management/models/stock_model.dart';

class StockProductModel {
  late ProductModel productModel;
  late StockModel stockModel;
  int quantity = 0;

  StockProductModel.fromJson(Map<String, dynamic> json) {
    print("product id: ${json['product']['id']}");
    var productData = json['product'] as Map<String, dynamic>;
    productModel = ProductModel.fromJson(productData);
    stockModel = StockModel.fromJson(json);
  }
}