// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PointsModal extends StatefulWidget {
  final String name;
  final double points;

  PointsModal({
    required this.name,
    required this.points,
  });

  @override
  State<PointsModal> createState() => _PointsModalState();
}

class _PointsModalState extends State<PointsModal> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: size.height,
          width: size.width,
          color: Color(0x70000000),
        ),
        AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            color: const Color.fromARGB(255, 104, 101, 101),
            width: size.width * 0.8,
            padding: EdgeInsets.all(22),
            margin: EdgeInsets.all(11),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextFormField(),
                    TextFormField(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('Descontar'),
                    ),
                    Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('Adicionar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
