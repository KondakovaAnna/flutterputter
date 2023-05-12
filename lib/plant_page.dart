import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:myproject/main.dart';
import 'globals.dart' as globals;
import 'package:myproject/classes/Plant.dart';


class PlantPage extends StatefulWidget {
  final Plant_with_coordinate information;
  //PlantPage({Key? key, required this.information}) : super(key: key);
  const PlantPage(this.information);

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  ScrollController _scrollController = new ScrollController();
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var plant_name = widget.information.p.name;
    var plant_info = widget.information.p.info;
    var plant_picture = widget.information.p.picture;
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_rounded), color: isShrink ? Colors.white : Colors.black),
            snap: false,
            floating: true,
            expandedHeight: 380.0,
            backgroundColor: isShrink ? Color(0xFF89C09F) : Color(0xFFF3F3F3),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                //StretchMode.fadeTitle,
              ],
              //title: Text(plant_name,
                 // style: TextStyle(
                   // color: isShrink ? Colors.white : Colors.black.withOpacity(0.0),
                    //fontFamily: 'BoldMontserrat',
                    //fontSize: 18.0,
                 //)),
              background: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0)),
                    child: Image.asset(plant_picture,
                        width: 410.0, fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                      child: Align(
                        alignment: const Alignment(-0.77, 0),
                        child: Text(
                          plant_name,
                          style: const TextStyle(
                              fontFamily: 'BoldMontserrat', fontSize: 28),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Align(
                        alignment: Alignment(-0.8, 0),
                        child: Text(
                          "Описание",
                          style: TextStyle(
                              fontFamily: 'BoldMontserrat', fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 34.0, left: 34.0, bottom: 34.0),
                      child: Text(
                        plant_info,
                          //"Монстера — вечнозелёная лиана с крупными — до 45 см — резными листьями. Монстеры неприхотливы и даже в домашних условиях могут вырастать до нескольких метров в длину. Чтобы вырастить крупное растение, потребуется устойчивая опора. \n \n Лазающие растения не выносят прямых солнечных лучей, лазают с помощью придаточных корней. В случае утраты контакта с почвой растение продолжает жить как эпифит.Листья перисторассечённые и перфорированные. Цветки собраны в початки. Плоды — ягоды. \n \n Монстера — вечнозелёная лиана с крупными — до 45 см — резными листьями. Монстеры неприхотливы и даже в домашних условиях могут вырастать до нескольких метров в длину. Чтобы вырастить крупное растение, потребуется устойчивая опора. \n \n Лазающие растения не выносят прямых солнечных лучей, лазают с помощью придаточных корней. В случае утраты контакта с почвой растение продолжает жить как эпифит.Листья перисторассечённые и перфорированные. Цветки собраны в початки. Плоды — ягоды. Монстера — вечнозелёная лиана с крупными — до 45 см — резными листьями. Монстеры неприхотливы и даже в домашних условиях могут вырастать до нескольких метров в длину. Чтобы вырастить крупное растение, потребуется устойчивая опора. \n \n Лазающие растения не выносят прямых солнечных лучей, лазают с помощью придаточных корней. В случае утраты контакта с почвой растение продолжает жить как эпифит.Листья перисторассечённые и перфорированные. Цветки собраны в початки. Плоды — ягоды. \n \n Монстера — вечнозелёная лиана с крупными — до 45 см — резными листьями. Монстеры неприхотливы и даже в домашних условиях могут вырастать до нескольких метров в длину. Чтобы вырастить крупное растение, потребуется устойчивая опора. \n \n Лазающие растения не выносят прямых солнечных лучей, лазают с помощью придаточных корней. В случае утраты контакта с почвой растение продолжает жить как эпифит.Листья перисторассечённые и перфорированные. Цветки собраны в початки. Плоды — ягоды.",
                          style: const TextStyle(
                              fontFamily: 'MediumMontserrat',
                              fontSize: 14,
                              height: 1.8,
                              color: Color(0xFF9B9B9B)),
                          textAlign: TextAlign.justify),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
