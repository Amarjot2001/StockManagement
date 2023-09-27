import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String title;
  final TextEditingController textController;
  final String errorMessage;
  final double textBoxWidth;

  const InputTextField(
      {super.key,
      required this.title,
      required this.textController,
      required this.errorMessage,
      required this.textBoxWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          Spacer(),
          Container(
            constraints: BoxConstraints(maxWidth: textBoxWidth),
            child: TextFormField(
              controller: textController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return errorMessage;
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: errorMessage,
              ),
            ),
          )
        ],
      ),
    );
  }
}
