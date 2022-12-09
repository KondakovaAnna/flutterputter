import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:myproject/main.dart';

class PlantPage extends StatefulWidget {
  PlantPage({Key? key}) : super(key: key);
  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: Stack(
        children: [
          //Center(
          /*child:*/ Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                child: Image.asset('assets/images/monstera(zoom).jpg',
                    width: 410.0, fit: BoxFit.cover),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                        child: Align(
                          alignment: Alignment(-0.77, 0),
                          child: Text("Монстера",
                              style: TextStyle(
                                  fontFamily: 'BoldMontserrat', fontSize: 28)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Align(
                          alignment: Alignment(-0.8, 0),
                          child: Text("Описание",
                              style: TextStyle(
                                  fontFamily: 'BoldMontserrat', fontSize: 14)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 34.0, left: 34.0),
                        child: Text(
                            "Монстера — вечнозелёная лиана с крупными — до 45 см — резными листьями. Монстеры неприхотливы и даже в домашних условиях могут вырастать до нескольких метров в длину. Чтобы вырастить крупное растение, потребуется устойчивая опора. \n \n Лазающие растения не выносят прямых солнечных лучей, лазают с помощью придаточных корней. В случае утраты контакта с почвой растение продолжает жить как эпифит.Листья перисторассечённые и перфорированные. Цветки собраны в початки. Плоды — ягоды. \n \n Монстера — вечнозелёная лиана с крупными — до 45 см — резными листьями. Монстеры неприхотливы и даже в домашних условиях могут вырастать до нескольких метров в длину. Чтобы вырастить крупное растение, потребуется устойчивая опора. \n \n Лазающие растения не выносят прямых солнечных лучей, лазают с помощью придаточных корней. В случае утраты контакта с почвой растение продолжает жить как эпифит.Листья перисторассечённые и перфорированные. Цветки собраны в початки. Плоды — ягоды.",
                            style: TextStyle(
                                fontFamily: 'MediumMontserrat',
                                fontSize: 14,
                                color: Color(0xFF9B9B9B)),
                            textAlign: TextAlign.justify),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 50.0),
              child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MyApp())),
                child: const Icon(Icons.arrow_back_ios_rounded),
                //backgroundColor: const Color(0xFF89C09F),
                //child: const Icon(Icons.arrow_back_ios_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
