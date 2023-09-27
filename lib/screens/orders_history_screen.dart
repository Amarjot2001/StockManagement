import 'package:flutter/material.dart';
import 'package:stock_management/providers/order_list_provider.dart';
import '../models/order_history_model.dart';
import '../widgets/order/order_history_detail_card.dart';

class OrdersHistory extends StatefulWidget {
  final OrderHistoryListProvider _orderHistoryListProvider;

  const OrdersHistory(this._orderHistoryListProvider, {super.key});

  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  List<OrderHistoryCombined> _combinedList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: FutureBuilder<List<OrderHistoryModel>>(
        future: widget._orderHistoryListProvider.fetchDataFromOrderDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred: ${snapshot.error}'),
            );
          } else {
            var orderHistoryList = snapshot.data ?? [];
            getCombinedListItems(orderHistoryList);
            return GridView.builder(
              itemCount: _combinedList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 220
              ),
              itemBuilder: (BuildContext context, int index) {
                return OrderHistoryDetailCard(_combinedList[index]);
              },
            );
          }
        },
      ),
    );
  }

  void getCombinedListItems(List<OrderHistoryModel> orders) {
    List<OrderHistoryCombined> newList = [];
    for (OrderHistoryModel order in orders) {
      if (newList.isNotEmpty) {
        if (newList.last.orders.last.id == order.id) {
          newList.last.orders.add(order);
        } else {
          OrderHistoryCombined dummy = OrderHistoryCombined();
          dummy.orders.add(order);
          newList.add(dummy);
        }
      } else {
        OrderHistoryCombined dummy = OrderHistoryCombined();
        dummy.orders.add(order);
        newList.add(dummy);
      }
    }
    _combinedList = newList;
  }
}
