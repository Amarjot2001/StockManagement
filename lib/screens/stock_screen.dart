import 'package:flutter/material.dart';
import 'package:stock_management/widgets/stock/stock_detail_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/stock_product_model.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  List<StockProductModel> _productStockInfoList = [];

  @override
  void initState() {
    fetchDataFromBothTables();
    super.initState();
  }

  void fetchDataFromBothTables() async {
    List<StockProductModel> dummyList = [];
    var response = await Supabase.instance.client
        .from('stock')
        .select('''*, product(*)''');
    var listFromDatabase = response as List<dynamic>;
    for (var element in listFromDatabase) {
      var model = StockProductModel.fromJson(element as Map<String, dynamic>);
        dummyList.add(model);
    }
    setState(() {
      _productStockInfoList = dummyList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GridView.builder(
          itemCount: _productStockInfoList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, mainAxisExtent: 180),
          itemBuilder: (BuildContext context, int index) {
            return StockDetailCard(_productStockInfoList[index]);
          }),
    );
  }
}
