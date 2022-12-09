import 'dart:async';
import 'package:flutter/material.dart';
import 'location.dart';
import 'dart:io';

class HistoryPane extends StatelessWidget {
  HistoryPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const CircleAvatar(
          backgroundColor: Color(0xFFCAC76D),
          radius: 50,
          child: CircleAvatar(
              radius: 47,
              backgroundImage: ExactAssetImage('assets/images/monstera.jpg'))),
      const Positioned.fill(
        child: Align(
          child: Text("Монстера",
              style: TextStyle(fontFamily: 'BoldMontserrat', fontSize: 16)),
          alignment: Alignment(-0.17, 0.1),
        ),
      ),
      Positioned.fill(
        child: Align(
          child: Text("Дата",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
          alignment: const Alignment(0.97, -0.97),
        ),
      ),
    ]);
  }
}

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    histories = [
      HistoryPane(key: Key("1")),
      HistoryPane(key: Key("2")),
      HistoryPane(key: Key("3")),
      HistoryPane(key: Key("4")),
      HistoryPane(key: Key("5")),
    ];
    super.initState();
  }

  late List<Widget> histories;

  @override
  Widget build(BuildContext context) {
    print("rebuilding");
    return Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xFF89C09F),
            leading: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            title: const Padding(
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              child: Text('История', style: TextStyle(fontSize: 22)),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            histories.add(HistoryPane(key: Key("${histories.length}")));
            setState(() {});
          },
        ),
        body: HistoryBody(histories));
  }
}

class HistoryBody extends StatelessWidget {
  final List<Widget> items;
  const HistoryBody(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 11.0, left: 11.0, right: 10.0),
        separatorBuilder: (context, index) => Divider(
          endIndent: 30,
          indent: 30,
          thickness: 2.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, i) => Padding(
          child: items[i],
          padding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
