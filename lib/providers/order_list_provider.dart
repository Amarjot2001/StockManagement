import 'package:stock_management/models/order_history_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderHistoryProviderInterface {
  void insertDataInOrderDatabase(OrderHistoryModel order);

  Future<List<OrderHistoryModel>> fetchDataFromOrderDatabase();
}

class OrderHistoryListProvider implements OrderHistoryProviderInterface {
  @override
  Future<List<OrderHistoryModel>> fetchDataFromOrderDatabase() async {
    List<OrderHistoryModel> ordersList = [];
    var response = await Supabase.instance.client
        .from('orders')
        .select('id, date, pName, pPrice, pQuantity, totalPrice');
    var list = response as List<dynamic>;
    for (var element in list) {
      var model = OrderHistoryModel.fromJson(element as Map<String, dynamic>);
      ordersList.add(model);
    }
    return ordersList;
  }

  @override
  void insertDataInOrderDatabase(OrderHistoryModel order) {
    // TODO: implement insertDataInOrderDatabase
  }
}
