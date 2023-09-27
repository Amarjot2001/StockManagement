import 'package:flutter/material.dart';

import '../../models/stock_product_model.dart';

class CartDetailCard extends StatelessWidget {
  final StockProductModel _cartItem;
  final Function(int) _onQuantityChange;

  const CartDetailCard(this._cartItem, this._onQuantityChange, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/product_image.png'),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _cartItem.productModel.company.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                    "${_cartItem.productModel.title.toString()}(${_cartItem.productModel.subtitle.toString()})",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  "MRP: Rs.${_cartItem.stockModel.mrp.toString()}",
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  InkWell(
                    onTap: () {
                      if (_cartItem.quantity > 0) {
                        _onQuantityChange(_cartItem.quantity - 1);
                      }
                    },
                    child: Container(
                      color: Colors.purple,
                      child: const Icon(Icons.remove, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${_cartItem.quantity}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      _onQuantityChange(_cartItem.quantity + 1);
                    },
                    child: Container(
                      color: Colors.purple,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  )
                ]),
                Text(
                  "${_cartItem.stockModel.mrp.toString()} X ${_cartItem.quantity}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children:  [
                const Text(
                  "Total Price",
                  style: TextStyle(color: Colors.black),
                ),
                Text("Rs.${totalPrice()}.0",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  String totalPrice(){
    var total =  ((_cartItem.stockModel.mrp)! * (_cartItem.quantity));
    return total.toString();
  }
}
