import 'package:flutter/material.dart';

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({Key? key}) : super(key: key);
  static const String id = 'addnewproduct -screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Material(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      child: Text('Products / Add'),
                    ),
                  ),
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.save,
                        color: Colors.black,
                      ),
                      label: Text(
                        'Save',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
