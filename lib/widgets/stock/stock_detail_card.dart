import 'package:flutter/material.dart';

import '../../models/stock_product_model.dart';

class StockDetailCard extends StatelessWidget {
  final StockProductModel stockList;

  const StockDetailCard(this.stockList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                stockList.productModel.company.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${stockList.productModel.title.toString()}(${stockList.productModel.subtitle.toString()})",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      titleText("Expiry"),
                      const SizedBox(
                        height: 20,
                      ),
                      titleText("MRP"),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      titleText(
                        stockList.stockModel.expiry.toString(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      titleText(
                        stockList.stockModel.mrp.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      titleText("Available Stock"),
                      const SizedBox(
                        height: 20,
                      ),
                      titleText("Discounted Price"),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      titleText(
                        stockList.stockModel.availableStock.toString(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      titleText(
                        stockList.stockModel.discountedPrice.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget titleText(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, color: Colors.black),
    );
  }
}
