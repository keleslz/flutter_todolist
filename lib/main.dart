import 'package:flut_app/model/Task.dart';
import 'package:flut_app/request/RequestApi.dart';
import 'package:flut_app/widget/ItemList.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const String _title = 'Mon app Flutt(iste)';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> _items = [];

  final TextEditingController textController = TextEditingController();

  _MyHomePageState() {
    _getItems();
  }

  void _getItems() async {
    final List<dynamic> data = await RequestApi().getData();
    List<Task> tasks = data.map((d) => Task.fromJson(d)).toList();
    setState(() {
      _items = tasks;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyHomePage._title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Card(
            child: ItemList(
              items: _items,
              index: index,
              callback: refresh,
            ),
          );
        },
      ),
      floatingActionButton: Stack(children: [
        Positioned(
          child: TextField(
            controller: textController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
            ),
            onTap: () {},
          ),
          bottom: 0,
          right: 70,
          width: 400,
        ),
        Positioned(
            bottom: 0,
            right: 10,
            width: 50,
            child: FloatingActionButton(
              child: const Text('add'),
              splashColor: Colors.blueGrey,
              onPressed: () {
                var task = Task.fromJson({
                  'id': DateTime.now().millisecondsSinceEpoch,
                  'title': textController.text,
                  'detail': textController.text,
                  'completed': false,
                });

                setState(() => _items.add(task));
                textController.text = '';
              },
            )),
      ]),
    );
  }
}
