import 'package:flutter/material.dart';

class MainListViewChild extends StatefulWidget {
  final int no;
  const MainListViewChild({super.key, required this.no});

  @override
  State<MainListViewChild> createState() => _MainListViewChildState();
}

class _MainListViewChildState extends State<MainListViewChild> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, //阴影
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      color: Colors.white, //颜色
      margin: EdgeInsets.all(10), //margin
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.android),
            title: Text('标题'),
            subtitle: Text('副标题'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text("this is ${widget.no} "),
          )
        ],
      ),
    );
  }
}
