import 'package:flutter/material.dart';
import 'package:stock_management/models/order_history_model.dart';

class OrderHistoryDetailCard extends StatelessWidget {
  final OrderHistoryCombined _orderHistoryItem;
  const OrderHistoryDetailCard(this._orderHistoryItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Order No.:${_orderHistoryItem.orders.last.id}",
                style:
                const TextStyle(color: Colors.black, fontSize: 14),
              ),
              const SizedBox(
                width: 5,
                height: 5,
              ),
              Text("Date: ${_orderHistoryItem.orders.last.date}"),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Total price: Rs.${calculateTotalPrice()}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _orderHistoryItem.orders.length,
                    itemBuilder: (context, position) {
                      return Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _orderHistoryItem
                                  .orders[position]
                                  .pName
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              "${_orderHistoryItem.orders[position].pPrice.toString()} X ${_orderHistoryItem.orders[position].pQuantity.toString()}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }

  int calculateTotalPrice(){
    var list = _orderHistoryItem.orders;
    int price = 0;
    for(var orderItem in list){
      price += orderItem.pPrice!.toInt() * (orderItem.pQuantity!);
    }
    return price;
  }
}
