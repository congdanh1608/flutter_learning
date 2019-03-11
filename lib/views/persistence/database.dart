import 'package:flutter/material.dart';
import 'package:flutter_learning/views/persistence/model/dog.dart';
import 'package:flutter_learning/views/persistence/provider/db_provider.dart';

class MyDatabase extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyDatabase();
  }
}

class _MyDatabase extends State<MyDatabase> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _idDeleteController = TextEditingController();

  List<Dog> dogs = new List();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Insert', style: TextStyle(fontSize: 22)),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: _ageController,
            decoration: InputDecoration(labelText: 'Age'),
          ),
          TextFormField(
            controller: _idController,
            decoration: InputDecoration(labelText: 'ID'),
          ),
          RaisedButton(
            child: Text('Insert'),
            onPressed: () async {
              Dog dog = Dog(id: int.parse(_idController.text), age: int.parse(_ageController.text), name: _nameController.text);
              await DBProvider.db.insertDog(dog);
            },
          ),
          Divider(
            color: Colors.red,
            height: 10.0,
          ),
          Text('Update (get data from above form)', style: TextStyle(fontSize: 22)),
          RaisedButton(
            child: Text('Update'),
            onPressed: () async {
              Dog dog = Dog(id: int.parse(_idController.text), age: int.parse(_ageController.text), name: _nameController.text);
              await DBProvider.db.updateDog(dog);
            },
          ),
          Divider(
            color: Colors.red,
            height: 10.0,
          ),
          Text(
            'Delete dog by Id',
            style: TextStyle(fontSize: 22.0),
          ),
          TextFormField(
            controller: _idDeleteController,
            decoration: InputDecoration(labelText: 'ID'),
          ),
          RaisedButton(
            child: Text('Delete'),
            onPressed: () async {
              await DBProvider.db.delete(int.parse(_idDeleteController.text));
            },
          ),
          Divider(
            color: Colors.red,
            height: 10.0,
          ),
          Text(
            'Fetch data',
            style: TextStyle(fontSize: 22.0),
          ),
          RaisedButton(
            child: Text('Fetch all dogs'),
            onPressed: () async {
              dogs = await DBProvider.db.getDogs();
              setState(() {});
            },
          ),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: ListView.builder(
                itemCount: dogs.length,
                itemBuilder: (context, i) {
                  final dog = dogs[i];
                  return Card(
                    child: ListTile(
                      title: Text(dog.name),
                      subtitle: Text('${dog.id}  -  ${dog.age}'),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
