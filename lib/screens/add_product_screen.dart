import 'package:flutter/material.dart';
import 'package:stock_management/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../helper/InputTextField.dart';
import '../helper/PrimaryBtn.dart';
import '../providers/product_list_provider.dart';

class AddProductScreen extends StatefulWidget {
  final ProductListProvider _productListProvider;

  const AddProductScreen(this._productListProvider, {super.key});

  @override
  State<AddProductScreen> createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> {
  final _pCompany = TextEditingController();
  final _pTitle = TextEditingController();
  final _pSubtitle = TextEditingController();
  final _pDesc = TextEditingController();
  final _formKey = GlobalKey<FormState>(); //To validate the empty input fields
  var supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Product Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 40,
              ),
              information(),
              const SizedBox(
                height: 50,
              ),
              PrimaryBtn(buttonTap: onButtonPressed, name: "Save")
            ],
          ),
        ),
      ),
    );
  }

  Widget information() {
    return Container(
      width: 600,
      child: Column(children: [
          InputTextField(
            title: 'Product Company',
            textController: _pCompany,
            errorMessage: "Please enter product's brand",
            textBoxWidth: 400,
          ),
          const SizedBox(
            height: 20,
          ),
          InputTextField(
            title: 'Product Title',
            textController: _pTitle,
            errorMessage: "Please enter product title",
            textBoxWidth: 400,
          ),
          const SizedBox(
            height: 20,
          ),
          InputTextField(
              title: 'Product Subtitle',
              textController: _pSubtitle,
              errorMessage: "Please enter short detail",
              textBoxWidth: 400),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Description', style: Theme.of(context).textTheme.titleMedium),
              Spacer(),
              SizedBox(
                width: 400,
                child: TextField(
                  maxLines: 4,
                  controller: _pDesc,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Product's Detail",
                  ),
                ),
              )
            ],
          ),
        ]),
    );

  }

  void onButtonPressed() {
    if (_formKey.currentState!.validate()) {
      var company = _pCompany.text.toString();
      var title = _pTitle.text.toString();
      var subTitle = _pSubtitle.text.toString();
      var desc = _pDesc.text.toString();
      var product = ProductModel("", title, subTitle, company, desc);
      widget._productListProvider.insertDataInProductDatabase(product);
      _pCompany.clear();
      _pTitle.clear();
      _pSubtitle.clear();
      _pDesc.clear();
    }
  }
}
