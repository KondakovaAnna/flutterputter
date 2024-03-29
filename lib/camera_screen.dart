import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myproject/plant_page.dart';
import 'package:myproject/services/network.dart';
import 'location.dart';
import 'package:myproject/classes/Plant.dart';


import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'globals.dart' as globals;


// A screen that allows users to take a picture using a given camera.
class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraDescription camera;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int selectedCamera = 0;
  List<File> capturedImage = [];

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.setFlashMode(FlashMode.off);
    // Fill this out in the next steps.
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            final r= {
              "plantname": "plantname",
              "plantinfo": "info",
              "picture":"picture"
            };
            Plant p = new Plant.fromJson(r);
            final rc= {
              "latitude": 0.0,
              "longitude": 0.0,
              "date":DateTime.now().toString(),
              "plant":r
            };
            Plant_with_coordinate info = new Plant_with_coordinate.fromJson(rc);
            return Stack(
              children: [
                Container(
                    height: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                            child: CameraPreview(_controller), height: 745.0),
                        Container(
                          height: 121.25,
                          color: Colors.black,
                        )
                      ],
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 50.0),
                    child: GestureDetector(
                      onTap: Navigator.of(context).pop,
                      child: const Icon(Icons.arrow_back_ios_rounded,
                          color: Colors.white),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 90.0,
                      width: 90.0,
                      child: FloatingActionButton(
                        backgroundColor: Colors.grey,
                        onPressed: () async {
                          try {
                            await _initializeControllerFuture;
                            final image = await _controller.takePicture();
                            var pos = await determinePosition();
                            var pic = await http.MultipartFile.fromPath("image", image.path);
                            //send image

                            NetworkWorker action = new NetworkWorker();
                            info = await action.ImageClassification(DateTime.now(),pos.latitude,pos.longitude, pic);
                            globals.list_of_plants.add(info);
                            //print(globals.inf.name);

                          } catch (error) {
                            print(error);
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlantPage(info)));
                        },
                        child: const Icon(Icons.camera_alt, size: 56.0),
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 94.0, right: 15.0),
                    child: Image.asset('assets/images/camera_frame.png',
                        width: 400),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 144.0, right: 15.0),
                    child: Text(
                        "Убедитесь, что растение находится" '\n' "в фокусе",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, color: Color(0xFF9B9B9B))),
                  ),
                ),
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // floatingActionButton:  Row(
      //   mainAxisAlignment:MainAxisAlignment.center,
      //   children: [
      //     FloatingActionButton(
      //           backgroundColor: Colors.black,
      //           onPressed: () async {
      //             try {
      //               await _initializeControllerFuture;
      //               final image = await _controller.takePicture();
      //             } catch (error) {
      //               print(error);
      //             }
      //           },
      //           child: const Icon(Icons.camera_alt),
      //         ),
      //   ],
      // ),
    );
  }
}
