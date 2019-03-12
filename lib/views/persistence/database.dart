import 'package:flutter/material.dart';
import 'package:flutter_learning/views/persistence/bloc/dogs_bloc.dart';
import 'package:flutter_learning/views/persistence/model/dog.dart';

class MyDatabase extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyDatabase();
  }
}

class _MyDatabase extends State<MyDatabase> {
  final bloc = DogsBloc();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _idDeleteController = TextEditingController();

  List<Dog> dogs = new List();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
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
                      bloc.add(dog);
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
                      bloc.update(dog);
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
                      bloc.delete(int.parse(_idDeleteController.text));
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
                  SizedBox(
                      height: 600.0,
                      child: StreamBuilder<List<Dog>>(
                        stream: bloc.dogs,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i) {
                                  Dog dog = snapshot.data[i];
                                  return ListTile(
                                    title: Text(dog.name),
                                    subtitle: Text('${dog.id} - ${dog.age}'),
                                  );
                                });
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
