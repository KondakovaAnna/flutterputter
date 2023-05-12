import 'dart:async';
import 'package:flutter/material.dart';
import 'location.dart';
import 'dart:io';
import 'package:myproject/plant_page.dart';
import 'package:myproject/classes/Plant.dart';
import 'globals.dart' as globals;

class HistoryPane extends StatelessWidget {
  //HistoryPane({Key? key}) : super(key: key);
  final Plant_with_coordinate information;
  const HistoryPane(this.information);

  @override
  Widget build(BuildContext context) {
    var plant_name = information.p.name;
    var plant_picture = information.p.picture;
    var plant_date = information.time;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PlantPage(information)));
      },
      child: Stack(children: [
         CircleAvatar(
            backgroundColor: const Color(0xFFCAC76D),
            radius: 50,
            child: CircleAvatar(
                radius: 47,
                backgroundImage:
                    ExactAssetImage(plant_picture))),
         Positioned.fill(
          child: Align(
            child: Text(plant_name,
                textAlign: TextAlign.left,
                style: const TextStyle(fontFamily: 'BoldMontserrat', fontSize: 16)),
            alignment: const Alignment(-0.17, 0.1),
          ),
        ),
        Positioned.fill(
          child: Align(
            child: Text("${plant_date.day.toString()}.${plant_date.month.toString().padLeft(2,'0')}",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
            alignment: const Alignment(0.97, -0.97),
          ),
        ),
      ]),
    );
  }
}

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late List<Widget> histories;
  @override
  void initState() {
    var plants = new List.from(globals.list_of_plants.reversed);
    histories = plants.map((e) => HistoryPane(e)).toList();
    super.initState();
  }

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
       // floatingActionButton: FloatingActionButton(
         // onPressed: () {
           // histories.add(HistoryPane(key: Key("${histories.length}")));
           // setState(() {});
         // },
        //),
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
        padding: const EdgeInsets.only(top: 11.0, left: 11.0, right: 10.0, bottom: 15.0),
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
