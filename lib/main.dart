import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myproject/map.dart';

import 'location.dart';

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
      //theme: ThemeData(
        //primarySwatch: Colors.lightGreen,
      //),
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF89C09F)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _selectedIndex = 0;
  Widget _body = Image.asset('assets/images/logo.png',width: 200);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void onItemTapped(int index) async{
    if (index == 2){
      var pos = await determinePosition();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => MapSample(pos)));
      return;
    }
    else if (index == 1){
      _body = Text("Camera");
    }
    else if (index == 0){
      _body = Text("History");
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _body
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Map',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFE4E4A3),
        onTap: onItemTapped,
        backgroundColor: const Color(0xFFa8cdb7),
        unselectedItemColor: const Color(0xFFFFFFFF),
      ),
      /*floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () async {
              var pos = await determinePosition();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) { print("Helicopta");return MapSample(pos);}
                ),
              );
            },
            tooltip: 'decrement',
            child: const Icon(Icons.add),
          ),
        ],
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
