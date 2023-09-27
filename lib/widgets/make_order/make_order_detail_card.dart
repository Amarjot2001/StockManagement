import 'package:flutter/material.dart';
import '../../models/stock_product_model.dart';

class MakeOrderDetailCard extends StatelessWidget {
  final StockProductModel _stockProduct;
  final Function(int) _onQuantityChange;
  final int quantity;
  const MakeOrderDetailCard(this._stockProduct, this.quantity, this._onQuantityChange, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/product_image.png'),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _stockProduct
                  .productModel
                  .company
                  .toString(),
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
                "${_stockProduct.productModel.title.toString()}(${_stockProduct.productModel.subtitle.toString()})",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            const SizedBox(
              height: 5,
            ),
            Text(
              "MRP: Rs.${_stockProduct.stockModel.mrp.toString()}",
              style: const TextStyle(color: Colors.black),
            ),
            Text(
                "Discount: Rs.${_stockProduct.stockModel.discountedPrice.toString()}",
                style: const TextStyle(color: Colors.black)),
            const SizedBox(
              height: 5,
            ),
            Row(mainAxisSize: MainAxisSize.min, children: [
              InkWell(
                onTap: () {
                  if (_stockProduct.quantity > 0) {
                    _onQuantityChange(_stockProduct.quantity-1);
                  }
                },
                child: Container(
                  color: Colors.purple,
                  child:
                  const Icon(Icons.remove, color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  _onQuantityChange(_stockProduct.quantity+1);
                },
                child: Container(
                  color: Colors.purple,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              )
            ]),

          ],
        ),
      ),
    );
  }
}
