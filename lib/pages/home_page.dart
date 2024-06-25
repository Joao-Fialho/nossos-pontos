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
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
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
              padding:
                  const EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 8),
              child: Observer(
                builder: (context) {
                  return ListView.separated(
                    itemCount: controller.userList.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return CardName(
                        name: controller.userList[index].name,
                        pointsTotal: controller.userList[index].pointsTotal,
                        pointsItem: controller.userList[index].pointsItemList,
                        controller: controller,
                      );
                    },
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (MediaQuery.of(context).viewInsets.bottom == 0) {
                    controller.toggleVisibility();
                  } else {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                });
              },
              child: Observer(builder: (context) {
                if (controller.isVisibleModalPoint.value == true) {
                  return WillPopScope(
                    onWillPop: () async {
                      controller.toggleVisibility();
                      return false;
                    },
                    child: Expanded(
                      child: PointsModal(
                        controller: controller,
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.blue,
        backgroundColor: Colors.lightBlue.shade300,
        onPressed: () {
          setState(() {
            // controller.toggleVisibility();
            showPointsModal(context, controller);
          });
          // Modular.to.navigate('/pointsModal', arguments: controller);
        },
        child: const Icon(
          Icons.mode_edit_sharp,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomAppBar(
          color: Colors.lightBlue.shade300,
          child: LayoutBuilder(builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: const Icon(
                          Icons.today_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const Text(
                        'Lembretes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: const Icon(
                          Icons.graphic_eq,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const Text(
                        'Pontos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: const Icon(
                          Icons.perm_device_information,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const Text(
                        'Informaçoes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

void showPointsModal(BuildContext context, HomeController controller) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: PointsModal(controller: controller),
      );
    },
  );
}
