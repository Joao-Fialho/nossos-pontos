import 'package:flutter/material.dart';
import 'package:nossos_pontos/components/card_name.dart';
import 'package:nossos_pontos/components/points_modal.dart';
import 'package:nossos_pontos/domain/rank_item_objetct.dart';

class HomePage extends StatefulWidget {
  late bool visible;
  HomePage({
    super.key,
    this.visible = false,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Nossos Pontos'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://is.zobj.net/image-server/v1/images?r=_SlWO-YyhRhjdAbRjN3dTTYRus4E-L6OZDNKFFZGGJ0zaqphgtHDldPvy3l5fchlGujiHFc2y4cmHrkGgdbIo4ulnquiKu2uqABJA9cB6XqYjb0aATXMegpMFr62KI-jOgWN1f6-3c6OyNNZ9uaeFh2NpS13cGQlpqFdP9Ucu9dtyV5qr6fbGJ-53g1mNIqbHoyFvDUFBVU3N5i6v7qzDpRsGqq9reIHZ1EM0JcJ-BqrPl9ZTaGb0crUpGI'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  CardName(
                    name: 'Joao',
                    points: 175,
                    rankItemObjectList: [
                      RankItemObject(
                        motivo: 'teste teste',
                        points: 100,
                        pointsPositivos: false,
                      ),
                      RankItemObject(
                        motivo: 'teste teste',
                        points: 100,
                        pointsPositivos: false,
                      ),
                      RankItemObject(
                        motivo: 'teste teste',
                        points: 100,
                        pointsPositivos: true,
                      ),
                      RankItemObject(
                        motivo: 'teste teste',
                        points: 100,
                        pointsPositivos: true,
                      ),
                      RankItemObject(
                        motivo: 'teste teste',
                        points: 100,
                        pointsPositivos: true,
                      ),
                    ],
                  ),
                  CardName(
                    name: 'Kelly',
                    points: 180,
                    rankItemObjectList: [
                      RankItemObject(
                        motivo: 'teste teste',
                        points: 100,
                        pointsPositivos: true,
                      ),
                      RankItemObject(
                        motivo: 'teste teste',
                        points: 100,
                        pointsPositivos: true,
                      ),
                      RankItemObject(
                        motivo: 'teste teste',
                        points: 100,
                        pointsPositivos: true,
                      ),
                      RankItemObject(
                        motivo: 'teste teste',
                        points: 100,
                        pointsPositivos: true,
                      ),
                    ],
                  ),
                ],
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: visibleActive,
        tooltip: 'Increment',
        child: const Icon(Icons.mode_edit_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
