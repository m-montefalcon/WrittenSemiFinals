import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditTodo extends StatefulWidget {
  //mr is the values taken from the my home page by selecting the specific listTile
  final dynamic mr;

  const EditTodo({required this.mr, Key? key}) : super(key: key);

  @override
  State<EditTodo> createState() => _EditTodo();
}

const String jsonUrl = 'https://jsonplaceholder.typicode.com/todos';


class _EditTodo extends State<EditTodo> {
  TextEditingController titleController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var id = '';
  var test;

  @override
  //initializing the values as widget to show the previous data in the text form field
  void initState() {
    super.initState();
    titleController.text = widget.mr["title"];
    id = widget.mr["id"].toString();
    test = widget.mr["title"];
  }

  //Editing the values when the submit button is executed
  editUser() async {
    var titleHolder = titleController.text;
    var url = Uri.parse('$jsonUrl/$id');
    var body = json.encode({
      'title': titleHolder,
    });
    var response = await http.put(url, body: body);
    if (response.statusCode == 200) {
      print('\n Edited on: $id!');

    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Todo"),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(40.0),
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    labelText: "Todo Title",
                    hintText: "E.g Do Chores"
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter todo title';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20),

              SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (test != titleController.text){
                          await editUser();
                          Navigator.pop(context,test);
                        }else{
                          return;
                        }
                      }else{
                        return;
                      }
                    },
                    child: const Text('Done')),
              ),
            ],
          ),
        ));
  }

}

