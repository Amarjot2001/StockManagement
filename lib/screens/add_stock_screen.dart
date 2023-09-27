import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_management/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../helper/InputTextField.dart';
import '../helper/PrimaryBtn.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({Key? key}) : super(key: key);

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  TextEditingController expiry = TextEditingController();
  TextEditingController mrp = TextEditingController();
  TextEditingController costPrice = TextEditingController();
  TextEditingController discountPrice = TextEditingController();
  TextEditingController availableStock = TextEditingController();
  TextEditingController soldStock = TextEditingController();
  TextEditingController batchCode = TextEditingController();
  TextEditingController barCode = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<ProductModel> productList = [];
  List<ProductModel> foundProducts = [];
  bool showSearchSuggestionList = false;
  FocusNode myFocus = FocusNode();
  String productUuid = "";
  var supabase = Supabase.instance.client;

  @override
  void initState() {
    expiry.text = "";
    readData();
    focus();
    _searchController.addListener(() {
      _runFilter(_searchController.text);
    });
    super.initState();
  }

  Future<List<ProductModel>> readData() async {
    var response = await Supabase.instance.client
        .from('product')
        .select('id, title, subtitle, company, description')
        .order('id', ascending: true)
        .execute();
    var list = response.data as List<dynamic>;
    list.forEach((element) {
      var model = ProductModel.fromJson(element as Map<String, dynamic>);
      productList.add(model);
    });
    print("Product model: ${productList.length}");
    return productList;
  }

  void focus() {
    myFocus.addListener(() {
      if (myFocus.hasFocus) {
        setState(() {
          showSearchSuggestionList = true;
        });
      } else {
        print("search TextField unfocused.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                        'Stock Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(child: searchBar()),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 500,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Select Date", style: Theme.of(context).textTheme.titleMedium),
                                    Spacer(),
                                    datePicker(),
                                  ],
                                ),
                                InputTextField(
                                  title: 'Cost Price',
                                  textController: costPrice,
                                  errorMessage: "Enter cost price",
                                  textBoxWidth: 250,
                                ),
                                InputTextField(
                                  title: 'Available Stock',
                                  textController: availableStock,
                                  errorMessage: "Enter currently present stock",
                                  textBoxWidth: 250,
                                ),
                                InputTextField(
                                  title: 'Batch Code',
                                  textController: batchCode,
                                  errorMessage: "Enter Batch code",
                                  textBoxWidth: 250,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 500,
                            child: Column(
                              children: [
                                InputTextField(
                                  title: 'MRP',
                                  textController: batchCode,
                                  errorMessage: "Enter MRP",
                                  textBoxWidth: 250,
                                ),
                                InputTextField(
                                  title: 'Discounted Price',
                                  textController: discountPrice,
                                  errorMessage: "Enter Price after discount",
                                  textBoxWidth: 250,
                                ),
                                InputTextField(
                                  title: 'Sold Stock',
                                  textController: soldStock,
                                  errorMessage: "Enter sold stock",
                                  textBoxWidth: 250,
                                ),
                                InputTextField(
                                  title: 'Bar Code',
                                  textController: barCode,
                                  errorMessage: "Enter Bar code",
                                  textBoxWidth: 250,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    PrimaryBtn(
                        buttonTap: () {
                          if (_formKey.currentState!.validate()) {
                            addRecord();
                          }
                        },
                        name: "Save Stock"),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget titleText(String title) {
    return SizedBox(
        width: 160,
        height: 70,
        child: Text(title, style: Theme.of(context).textTheme.titleMedium));
  }

  Widget textField(TextEditingController input, String hint) {
    return SizedBox(
      width: 250,
      height: 50,
      child: TextFormField(
        controller: input,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "hint.",
        ),
      ),
    );
  }

  Widget datePicker() {
    return SizedBox(
      width: 250,
      height: 50,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select expiry date';
          }
          return null;
        },
        controller: expiry,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Select Date",
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

            setState(() {
              expiry.text = formattedDate;
            });
          } else {}
        },
      ),
    );
  }

  Widget searchBar() {
    return Column(
      children: [
        Column(
          children: [
            Container(
              height: 50,
              width: 400,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                focusNode: myFocus,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Product...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _runFilter(_searchController.text.toString());
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            showSearchSuggestionList
                ? Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black26),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListView.builder(
                      itemCount: foundProducts?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(
                              foundProducts![index].title.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              onSearchedItemSelected(index);
                            });
                      },
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ],
    );
  }

  void onSearchedItemSelected(int index) {
    productUuid = foundProducts![index].id!;
    print(foundProducts![index].id);
    setState(() {
      _searchController.text = foundProducts![index].title!;
      showSearchSuggestionList = false;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ProductModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = productList;
    } else {
      print("ProductList:: ${productList.toString()}");
      results = productList
          .where((product) => product.title
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundProducts = results;
      print('foundList $foundProducts');
    });
  }

  void addRecord() async {
    await supabase.from('stock').insert({
      'productId': productUuid,
      'expiry': expiry.text.toString(),
      'mrp': double.parse(mrp.text),
      'costPrice': double.parse(costPrice.text),
      'discountedPrice': double.parse(discountPrice.text),
      'availableStock': int.parse(availableStock.text),
      'soldStock': int.parse(soldStock.text),
      'batchCode': batchCode.text.toString(),
      'barCode': barCode.text.toString(),
    });
  }
}
