import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:sample/models/users.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  late Future<List<Users>> _listadoUsers;
  // Users _users = new Users();

  Future<List<Users>> _getUsers() async {
    List<Users> _users = [];
    var _url = Uri.parse('https://eventapirest.azurewebsites.net/users');
    final response = await http.get(_url);
    // Future<List<Users>> _users = [];

    if (response.statusCode == 200) {
      List usersdata = convert.json.decode(response.body);
      _users = usersdata.map((json) => Users.fromJson(json)).toList();
      print(_users.map((e) => e.email));
      return _users;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listadoUsers = _getUsers();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hello World!',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            listUsers(),
            ElevatedButton(
                onPressed: _incrementCounter, child: const Text('Increment'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget listUsers() {
    return FutureBuilder(
      future: _listadoUsers,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          snapshot.data.map(
              (user) => {Text(user.username, style: TextStyle(fontSize: 20))});
          // return Text(snapshot.data.length.toString());
          return SizedBox(
              width: 200,
              height: 200,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Text('${snapshot.data[index].nombre}');
                },
              ));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

List<Widget> _buildList(List<Users> users) {
  return users.map((user) {
    return ListTile(
      title: Text(user.email),
      subtitle: Text(user.apellido),
    );
  }).toList();
}


//https://eventapirest.azurewebsites.net/