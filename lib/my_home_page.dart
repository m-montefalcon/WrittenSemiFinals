import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Forms/edit_todo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
//Get the data on Jsonplaceholder
const String jsonUrl = 'https://jsonplaceholder.typicode.com/todos';

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    getDataTodo();
  }

//Transfer the datas in Jsonplaceholder to object //inputting the values as mapRep
  getDataTodo() async {
    var url = Uri.parse(jsonUrl);
    var rep = await http.get(url);

    if (rep.statusCode == 200) {
      setState(() {
        mapRep = jsonDecode(rep.body) as List<dynamic>;
      });
    } else {
      return null;
    }
  }


  List mapRep = <dynamic>[];
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Practical Semi Final Todo"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(50.00),
          itemCount :  mapRep.length,
          itemBuilder: (context, index){
            return ListTile(
              onTap: (){},
              trailing: Wrap(
                children: [
                  IconButton(
                      onPressed: () async {
                         var test = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                //pass the values as mr
                                    EditTodo(mr: mapRep[index])));

                      },
                      icon: const Icon(Icons.edit)),
                ],
              ),
              leading: Text(mapRep[index]['id'].toString()),
              title: Text(mapRep[index]['title']),



            );
          }
      ),
    );
  }
}
