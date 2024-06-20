// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nossos_pontos/controllers/points_controller.dart';

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
  String motivo = '';
  int points = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = PointsController();

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
            width: size.width * 0.8,
            padding: EdgeInsets.all(22),
            margin: EdgeInsets.all(11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blueAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      maxLines: 5,
                      minLines: 1,
                      cursorColor: Colors.white,
                      cursorRadius: Radius.circular(10),
                      cursorWidth: 2,
                      onChanged: (value) {
                        motivo = value;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: 'Motivo',
                        labelStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      cursorColor: Colors.white,
                      cursorRadius: Radius.circular(10),
                      cursorWidth: 2,
                      decoration: InputDecoration(
                          labelText: 'Pontos',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(
                            Icons.attach_money_outlined,
                            color: Colors.white,
                          )),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          points = int.parse(value);
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (motivo.isNotEmpty && points != 0) {
                            controller.adicionarPoints(motivo, points, false);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('Descontar'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(11),
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
