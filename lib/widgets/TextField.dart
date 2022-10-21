
import 'package:flutter/material.dart';

import 'Txt.dart';

class TextFormInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;
  GestureTapCallback onTap;
   TextFormInputField({Key? key,required this.onTap, this.controller,this.onChanged, this.hintText, this.keyboardType, this.maxLength, this.labelText, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(

        controller: controller,
        decoration: InputDecoration(
            label: Txt(labelText.toString(),color: Colors.grey),
            border: const OutlineInputBorder(),
            hintText: hintText.toString(),hintStyle: const TextStyle(color: Colors.grey),
           isDense: true,
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: GestureDetector(
             onTap: onTap,
              child: const Icon(Icons.search,color: Colors.black,))
        ),
        validator: validator,
        keyboardType: keyboardType??TextInputType.text,
        maxLength: maxLength,
        onChanged: onChanged,
      ),
    );
  }
}
