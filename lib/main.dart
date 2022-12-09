import 'package:camera/camera.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myproject/camera_screen.dart';
import 'package:myproject/services/network.dart' as network;
import 'package:myproject/map.dart';
import 'package:myproject/history.dart';
import 'package:myproject/authorization.dart';
import 'package:myproject/registration.dart';
import 'package:myproject/plant_page.dart';

import 'location.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  int _selectedIndex = 1;
  Widget _body = Image.asset('assets/images/logo1.png', width: 200);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  var history_active_color = const Color(0xFFE4E4A3);
  var history_color = Colors.white;
  var map_active_color = const Color(0xFFE4E4A3);
  var map_color = Colors.white;

  void onItemTapped(int index) async {
    if (index == 2) {
      var pos = await determinePosition();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => MapSample(pos)));
      return;
    } else if (index == 1) {
      /*final cameras = await availableCameras();
      final firstCamera = cameras.first;*/
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => CameraScreen()));
      return;
    } else if (index == 0) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => History()));
      return;
      //_body = Text("History");
      //setState(() {
      //history_color = history_active_color;
      //});
    }
    setState(() {
      //_selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: _body),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 50.0),
              child: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: IconButton(
                  icon: Icon(Icons.account_circle_rounded,
                      size: 45.0, color: Colors.white),
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Authorization())),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xFF89C09F),
        color: const Color(0xFFa3ceb4),
        buttonBackgroundColor: const Color(0xFFE4E4A3),
        height: 75,
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Icon(Icons.history, size: 50, color: history_color),
          ),
          const Icon(Icons.photo_camera, size: 64, color: Color(0xFF89C09F)),
          /*Container(
            width: 64.0,
            height: 64.0,
            color: Color(0xFF89C09F),
          ),*/
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Icon(Icons.location_on, size: 50, color: map_color),
          ),
        ],
        index: _selectedIndex,
        letIndexChange: (ind) {
          onItemTapped(ind);
          return false;
        },
        onTap: onItemTapped,
        //Handle button tap

        /*items: const <BottomNavigationBarItem>[
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

        unselectedItemColor: const Color(0xFFFFFFFF),*/
      ),
      //floatingActionButton: FloatingActionButton(onPressed: network.test),//!!!!!!!!!связь с сервером!!!!!!!
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
