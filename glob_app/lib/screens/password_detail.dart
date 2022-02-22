import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glob_app/models/password.dart';
import 'package:glob_app/screens/passwords.dart';

class PasswordDetailDialog extends StatefulWidget {
  final Password password;
  final bool isNew;

  PasswordDetailDialog(this.password, this.isNew);

  @override
  _PasswordDetailDialogState createState() => _PasswordDetailDialogState();
}

class _PasswordDetailDialogState extends State<PasswordDetailDialog> {
 final TextEditingController txtName = TextEditingController();
 final TextEditingController txtPassword = TextEditingController();
 bool hidePassword = true;

 @override
  Widget build(BuildContext context) {
   String title = (widget.isNew) ? 'Insert new Password' : 'Edit Password';
   txtName.text = widget.password.password;

   return AlertDialog(
     title: Text(title),
     content: Column(
       children: [
         TextField(
           controller: txtName,
           decoration: InputDecoration(
             hintText: 'Description',
           ),
         ),
         TextField(
           controller: txtPassword,
           obscureText: hidePassword,
           decoration: InputDecoration(
             hintText: 'Password',
             suffixIcon: IconButton(
               onPressed: () {
                 setState(() {
                   hidePassword = !hidePassword;
                 });
               },
               icon: hidePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off)
             )
           )
         )
       ]
     ),
     actions: [
       TextButton(
         child: Text('Save'),
         onPressed: () {
           widget.password.name = txtName.text;
           widget.password.password = txtPassword.text;
           Navigator.pop(context);
           Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordsScreen()));
         }
       ),
       TextButton(
         onPressed: () => Navigator.pop(context),
         child: Text('Cancel')
       )
     ],
   );
 }
}