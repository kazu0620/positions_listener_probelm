import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Positions Listener Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Positions Listener Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  // Initial itemCount for ScrollablePositionedList. If initial itemCount is
  // zero, itemPositionsListener would never notify item positions, even if
  // itemCount of ScrollablePositionedList change later.
  var numberOfItems = 0;

  void initState() {
    super.initState();
    itemPositionsListener.itemPositions
        // This callback NEVER called.
        .addListener(() => print("item positions notified."));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        // If you press this button, ScrollablePositionedList will be rebuild
        // with non zero itemCount, and scroll be enabled. But itemPositionsListener
        // will notify nothing.
        onPressed: () => _updateNumberOfItems(1000),
        child: Icon(Icons.add),
      ),
      body: _buildList(),
    );
  }

  void _updateNumberOfItems(int count) {
    setState(() {
      numberOfItems = count;
    });
  }

  Widget _buildList() => ScrollablePositionedList.builder(
        itemCount: numberOfItems,
        itemBuilder: (context, index) => _buildItem(index),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
      );

  Widget _buildItem(int index) {
    return Container(
      height: 50,
      child: Text("Index: $index"),
    );
  }
}
