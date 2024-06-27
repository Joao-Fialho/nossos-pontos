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
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2)); // Simula uma chamada de rede
    setState(() {
      controller.getUser();
    });
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
      body: Observer(builder: (context) {
        if (controller.userList.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.blueAccent,
          ));
        }
        return RefreshIndicator(
          onRefresh: _refresh,
          child: SizedBox(
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
                  padding: const EdgeInsets.only(
                      bottom: 0, left: 8, right: 8, top: 8),
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
                            userModel: controller.userList[index],
                            pointsItemList:
                                controller.userList[index].pointsItemList,
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
        );
      }),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.blue,
        backgroundColor: Colors.lightBlue.shade300,
        onPressed: () {
          setState(() {
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
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomAppBar(
          color: Colors.lightBlue.shade300,
          child: LayoutBuilder(builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth * 0.3,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Icon(
                          Icons.today_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Text(
                        'Lembretes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth * 0.3,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Icon(
                          Icons.graphic_eq,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Text(
                        'Pontos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth * 0.3,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Icon(
                          Icons.perm_device_information,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Text(
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
