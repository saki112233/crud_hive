
import 'package:flutter/material.dart';

import 'api_model.dart';
import 'controller.dart';

class ModifiedData extends StatefulWidget {
  const ModifiedData({
    required this.index,Key? key}) : super(key: key);
  final int index;
  @override
  State<ModifiedData> createState() => _ModifiedDataState(index);
}

class _ModifiedDataState extends State<ModifiedData> {
  final int i;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _ModifiedDataState(this.i);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Add to Task',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            autofocus: true,
            enableSuggestions: true,
            controller: titleController,
            decoration: InputDecoration(
                labelText: 'title',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black))),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            onEditingComplete: (){},
            autofocus: true,
            enableSuggestions: true,
            controller: descriptionController,
            decoration: InputDecoration(
                labelText: 'description',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black))),
          ),
          SizedBox(
            height: 15,
          ),
          MaterialButton(
            onPressed:(){
              setState((){
                final data=Data(title: titleController.text,body: descriptionController.text);
                Bb.upDateData(i, data);
                Navigator.pop(context);
              });
            },
            child: Text(
              'Insert',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}