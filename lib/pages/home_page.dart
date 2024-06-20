import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nossos_pontos/components/card_name.dart';
import 'package:nossos_pontos/components/points_modal.dart';

class HomePage extends StatefulWidget {
  late bool visible;
  HomePage({
    super.key,
    this.visible = true,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void visibleActive() {
    if (widget.visible == true) {
      widget.visible = false;
    } else {
      widget.visible = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade300,
        title: const Text(
          'Nossos Pontos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: ListView(children: [
          Stack(
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: Stack(
                  children: [
                    Container(
                      height: size.height,
                      width: size.width,
                      child: Image.asset(
                        'assets/background_image.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CardName(
                      name: 'João',
                      rankItemObjectList: [],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CardName(
                      name: 'Kelly',
                      rankItemObjectList: [],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.visible,
                child: PointsModal(
                  name: 'JOAO',
                  points: 23,
                ),
              ),
            ],
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.blue,
        backgroundColor: Colors.lightBlue.shade300,
        onPressed: visibleActive,
        child: const Icon(
          Icons.mode_edit_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
