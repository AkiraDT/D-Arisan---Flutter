import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isPassword;
  final Function onChanged;
  final String value;

  const InputField(
      {Key? key,
      this.label = '',
      this.icon = Icons.perm_identity_outlined,
      this.color = Colors.black54,
      this.isPassword = false,
      required this.onChanged, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController _txtController = TextEditingController();
    _txtController.value = TextEditingValue(
        text: this.value,
        selection: TextSelection.fromPosition(
          TextPosition(offset: this.value.length),
        ),
      );

    return Container(
      child: TextFormField(
        controller: _txtController,
        // initialValue: this.user,
        onChanged: (val) => onChanged(val),
        cursorColor: this.color,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        autofocus: true,
        decoration: InputDecoration(
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: this.label,
          labelStyle: TextStyle(
              color: this.color, fontWeight: FontWeight.normal),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: this.color),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${this.label} harus diisi!';
          }
        },
      ),
    );
  }
}
