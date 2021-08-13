import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isPassword;
  final Function onChanged;

  const InputField(
      {Key? key,
      this.label = '',
      this.icon = Icons.perm_identity_outlined,
      this.color = Colors.black54,
      this.isPassword = false,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    // TextEditingController _txtController = TextEditingController();

    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     this.label != '' ?
      //     Container(
      //       margin: EdgeInsets.only(bottom: 10),
      //       child: Text(
      //         this.label,
      //         style: TextStyle(
      //             color: Colors.grey
      //         ),
      //       ),
      //     ) : SizedBox.shrink(),
      //     Container(
      //       child: TextField(
      //         onChanged: (val) => this.onChanged(val),
      //         style: TextStyle(
      //           color: Colors.grey,
      //           fontSize: 16
      //         ),
      //         obscureText: this.isPassword,
      //         obscuringCharacter: '*',
      //         decoration: new InputDecoration(
      //           prefixIcon: Icon(
      //             this.icon,
      //             color: this.color,
      //           ),
      //           border: new OutlineInputBorder(
      //             borderRadius: const BorderRadius.all(
      //               const Radius.circular(5),
      //             ),
      //             borderSide: new BorderSide(
      //               color: this.color,
      //               width: 1.0,
      //             ),
      //           ),
      //         ),
      //       ),
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(5),
      //         color: Colors.white10,
      //       ),
      //     ),
      //     SizedBox(height: 20,)
      //   ],
      // ),
      child: TextFormField(
        // initialValue: this.user,
        // onChanged: (email) => context
        //     .read(loginFormViewModelProvider.notifier)
        //     .handleEmail(email),
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
