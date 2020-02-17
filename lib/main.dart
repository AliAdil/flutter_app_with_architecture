import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bloc/blocProvider.dart';

void main() => runApp(MyApp());

/*void main(){
  runApp(new MyApp());
}*/

/*class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      // home: MyHomePage(key:key,title: 'Flutter Demo Home Page'),
      *//*home: MyHomePage(key:key,title: 'Flutter Demo Home Page'),*//*
      home: BlocProvider<IncrementBloc>(
        bloc: IncrementBloc(),
        child: CounterPage(),
      ),

    );
  }
}*/

/*class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();

  *//* _MyHomePageState createState(){
   return new  _MyHomePageState();
  }*//*

//}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).

            Text(
              'You have pushed the button $_counter many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FloatingActionButton(
              onPressed: _decrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.minimize),
            ),
          ]),

      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Streams Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<IncrementBloc>(
        bloc: IncrementBloc(),
        child: CounterPage(),
      ),
    );
  }
}
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc bloc = BlocProvider.of<IncrementBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Stream version of the Counter App')),
      body: Center(
        child: StreamBuilder<int>(
            stream: bloc.outCounter,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
              return Text('You hit me: ${snapshot.data} times');
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          bloc.incrementCounter.add(null);
        },
      ),
    );
  }
}

class IncrementBloc implements BlocBase {
  int _counter;

  //
  // Stream to handle the counter
  //
  StreamController<int> _counterController = StreamController<int>();
  StreamSink<int> get _inAdd => _counterController.sink;
  Stream<int> get outCounter => _counterController.stream;

  //
  // Stream to handle the action on the counter
  //
  StreamController _actionController = StreamController();
  StreamSink get incrementCounter => _actionController.sink;

  //
  // Constructor
  //
  IncrementBloc(){
    _counter = 0;
    _actionController.stream
        .listen(_handleLogic);
  }

  void dispose(){
    _actionController.close();
    _counterController.close();
  }

  void _handleLogic(data){
    _counter = _counter + 1;
    _inAdd.add(_counter);
  }
}
/*class PositionedTiles extends StatefulWidget {
  @override
  PositionedTilesState createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  List<Widget> tiles;
  @override
  void initState() {
    super.initState();
    tiles = [StatefulColorfulTile(), StatefulColorfulTil2()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Row(children: tiles)),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.sentiment_very_dissatisfied), onPressed: swapTiles),
    );
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

class StatefulColorfulTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}

class StatefulColorfulTil2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(),
      ),
    );
  }
}*/
