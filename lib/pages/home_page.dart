import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nossos_pontos/components/card_name.dart';
import 'package:nossos_pontos/components/points_modal.dart';
import 'package:nossos_pontos/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = HomeController();
  @override
  void initState() {
    super.initState();

    setState(() {
      controller.isVisibleModalPoint = false;
      controller.getUser();
    });
    print(controller.userList);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          FocusScope.of(context).requestFocus(FocusNode());
        });
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade300,
          title: const Text(
            'Nossos Pontos',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
        body: SizedBox(
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
                      SizedBox(
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
                      Observer(
                        builder: (context) {
                          return ListView.builder(
                            itemCount: controller.userList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CardName(
                                name: controller.userList[index].name,
                                pointsTotal:
                                    controller.userList[index].pointsTotal,
                                pointsItem:
                                    controller.userList[index].pointsItemList,
                                controller: controller,
                              );
                            },
                          );
                        },
                      ),
                      // CardName(
                      //   name: 'João',
                      //   pointsTotal: controller.somaPoints(),
                      //   pointsItem: controller.pointsItem,
                      //   controller: controller,
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // CardName(
                      //   name: 'Kelly',
                      //   pointsTotal: controller.somaPoints(),
                      //   pointsItem: controller.pointsItem,
                      //   controller: controller,
                      // ),
                    ],
                  ),
                ),
                Observer(builder: (context) {
                  if (controller.isVisibleModalPoint) {
                    return PointsModal(
                      controller: controller,
                    );
                  } else {
                    return Container();
                  }
                })
              ],
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.blue,
          backgroundColor: Colors.lightBlue.shade300,
          onPressed: () {
            setState(() {
              // RankItemDatasource().getRankItem();
              controller.toggleVisibility();
              //clica aqui e nao fecha o modal
            });
          },
          child: const Icon(
            Icons.mode_edit_sharp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
