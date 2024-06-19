// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nossos_pontos/controllers/card_name_controller.dart';
import 'package:nossos_pontos/domain/rank_item_objetct.dart';

class CardName extends StatefulWidget {
  final String name;
  late int points;
  final List<RankItemObject> rankItemObjectList;

  CardName({
    super.key,
    required this.name,
    required this.rankItemObjectList,
  });

  @override
  State<CardName> createState() => _CardNameState();
}

class _CardNameState extends State<CardName> {
  bool expansionTileExpanded = false;
  var controller = CardNameController();
  @override
  Widget build(BuildContext context) {
    widget.points = controller.somaPoints(widget.rankItemObjectList);
    final size = MediaQuery.of(context).size;

    return ExpansionTile(
      collapsedBackgroundColor: Colors.blue,
      backgroundColor: Colors.white,
      textColor: Colors.blue,
      iconColor: Colors.blue,
      collapsedIconColor: Colors.white,
      collapsedTextColor: Colors.white,
      collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      trailing: Icon(
        size: 40,
        expansionTileExpanded
            ? Icons.arrow_drop_down_rounded
            : Icons.arrow_right_rounded,
      ),
      onExpansionChanged: (bool expanded) {
        setState(() {
          expansionTileExpanded = expanded;
        });
      },
      title: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${widget.points}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      children: [
        SizedBox(
          height: size.height * 0.5,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        controller.firstLetterCapitalized(
                          widget.rankItemObjectList[index].motivo,
                        ),
                        style: const TextStyle(),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Text(
                      '${controller.pointsPositivos(widget.rankItemObjectList[index].pointsPositivos)} ${widget.rankItemObjectList[index].points}',
                      style: TextStyle(
                          color: widget.rankItemObjectList[index]
                                      .pointsPositivos ==
                                  true
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
            itemCount: widget.rankItemObjectList.length,
          ),
        )
      ],
    );
  }
}
