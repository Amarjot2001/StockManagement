import 'package:flutter/material.dart';
import 'package:stock_management/providers/cart_items_provider.dart';
import 'package:stock_management/widgets/make_order/make_order_detail_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/stock_product_model.dart';

class SelectedItem {
  int quantity = 0;
  String itemId;

  SelectedItem(this.quantity, this.itemId);
}

class MakeOrderScreen extends StatefulWidget {
  final CartItemsProviders _cartItemsProvider;

  const MakeOrderScreen(this._cartItemsProvider, {super.key});

  @override
  State<MakeOrderScreen> createState() => _MakeOrderScreenState();
}

class _MakeOrderScreenState extends State<MakeOrderScreen> {
  List<StockProductModel> productStockInfoList = [];

  @override
  void initState() {
    _fetchDataFromBothTables();
    super.initState();
  }

  void _fetchDataFromBothTables() async {
    var response = await Supabase.instance.client
        .from('stock')
        .select('''*, product(*)''');
    var listFromDatabase = response as List<dynamic>;
    List<StockProductModel> newList = [];
    for (var element in listFromDatabase) {
      var model = StockProductModel.fromJson(element as Map<String, dynamic>);
      for (SelectedItem electedItem
          in widget._cartItemsProvider.selectedItems) {
        if (model.productModel.id.toString() == electedItem.itemId) {
          model.quantity = electedItem.quantity;
          break;
        }
      }
      newList.add(model);
    }
    setState(() {
      productStockInfoList = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
            itemCount: productStockInfoList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
            itemBuilder: (BuildContext context, int index) {
              return MakeOrderDetailCard(
                  productStockInfoList[index],
                  productStockInfoList[index].quantity,
                  (p0) => {
                        setState(() {
                          productStockInfoList[index].quantity = p0;
                          widget._cartItemsProvider.updateQuantity(
                              p0,
                              productStockInfoList[index]
                                  .productModel
                                  .id
                                  .toString());
                        }),
                      });
            }));
  }
}
