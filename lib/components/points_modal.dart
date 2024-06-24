// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nossos_pontos/controllers/home_controller.dart';
import 'package:nossos_pontos/domain/user_model.dart';

class PointsModal extends StatefulWidget {
  final HomeController controller;

  const PointsModal({super.key, required this.controller});

  @override
  State<PointsModal> createState() => _PointsModalState();
}

class _PointsModalState extends State<PointsModal> {
  String motivo = '';
  int points = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: size.height,
          width: size.width,
          color: const Color(0x70000000),
        ),
        AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            width: size.width * 0.8,
            padding: const EdgeInsets.all(22),
            margin: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blueAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Observer(
                      builder: (context) {
                        return DropdownButton<String>(
                          value: widget.controller.selectedUser,
                          dropdownColor: Colors.blueAccent,
                          icon: const Icon(Icons.arrow_drop_down_rounded,
                              color: Colors.white),
                          iconSize: 30,
                          elevation: 16,
                          style: const TextStyle(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              widget.controller.selectedUser = newValue!;
                            });
                          },
                          items: widget.controller.userList
                              .map<DropdownMenuItem<String>>((UserModel user) {
                            return DropdownMenuItem<String>(
                              value: user.name,
                              child: Text(user.name),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      maxLines: 5,
                      minLines: 1,
                      cursorColor: Colors.white,
                      cursorRadius: const Radius.circular(10),
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (motivo.isNotEmpty && points != 0) {
                            widget.controller.setPoints(points, false, motivo);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Descontar',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (motivo.isNotEmpty && points != 0) {
                          setState(() {
                            widget.controller.setPoints(points, true, motivo);
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Adicionar',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
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
