import 'package:flutter/material.dart';
import 'package:nossos_pontos/controllers/home_controller.dart';
import 'package:nossos_pontos/domain/models/points_item_model.dart';
import 'package:nossos_pontos/domain/models/user_model.dart';

class EditMotivoModal extends StatefulWidget {
  final HomeController controller;
  final String motivoOld;
  final int pointsOld;
  final PointsItemModel pointsItem;
  final UserModel userModel;
  const EditMotivoModal(
      {super.key,
      required this.controller,
      required this.motivoOld,
      required this.pointsOld,
      required this.pointsItem,
      required this.userModel});

  @override
  State<EditMotivoModal> createState() => _EditMotivoModalState();
}

class _EditMotivoModalState extends State<EditMotivoModal> {
  int points = 0;
  String motivo = '';
  TextEditingController controllerTextFormMotivo =
      TextEditingController(text: '');
  TextEditingController controllerTextFormPoints =
      TextEditingController(text: '');

  @override
  void initState() {
    motivo = widget.motivoOld;
    points = widget.pointsOld;
    controllerTextFormMotivo = TextEditingController(text: motivo);
    controllerTextFormPoints = TextEditingController(text: '$points');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueAccent,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextFormField(
                  controller: controllerTextFormMotivo,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  maxLines: 3,
                  minLines: 1,
                  cursorColor: Colors.white,
                  cursorRadius: const Radius.circular(10),
                  cursorWidth: 2,
                  onChanged: (value) {
                    setState(() {
                      motivo = value;
                    });
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
                  height: 20,
                ),
                TextFormField(
                  controller: controllerTextFormPoints,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  cursorColor: Colors.white,
                  cursorRadius: const Radius.circular(10),
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
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            LayoutBuilder(builder: (context, constraits) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (motivo.isNotEmpty && points != 0) {
                        setState(() {
                          widget.controller.editMotivo(widget.pointsItem,
                              points, motivo, widget.userModel.id);
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: Container(
                      width: constraits.maxWidth * 0.9,
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Editar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Container(
                      width: constraits.maxWidth * 0.9,
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Cancelar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
