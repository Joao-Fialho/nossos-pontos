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
                  const EdgeInsets.only(bottom: 80, left: 8, right: 8, top: 8),
              child: Observer(
                builder: (context) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: controller.userList.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
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
                    ),
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
              child: Expanded(
                child: Observer(builder: (context) {
                  if (controller.isVisibleModalPoint.value == true) {
                    return WillPopScope(
                      onWillPop: () async {
                        controller.toggleVisibility();
                        return false;
                      },
                      child: ListView(children: [
                        PointsModal(
                          controller: controller,
                        ),
                      ]),
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.blue,
        backgroundColor: Colors.lightBlue.shade300,
        onPressed: () {
          setState(() {
            controller.toggleVisibility();
          });
        },
        child: const Icon(
          Icons.mode_edit_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
