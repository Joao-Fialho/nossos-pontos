// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nossos_pontos/domain/rank_item_objetct.dart';

class CardName extends StatefulWidget {
  final String name;
  final double points;
  final List<RankItemObject> rankItemObjectList;

  const CardName({
    required this.name,
    required this.points,
    required this.rankItemObjectList,
  });

  @override
  State<CardName> createState() => _CardNameState();
}

class _CardNameState extends State<CardName> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.name),
            Text('${widget.points}'),
          ],
        ),
      ),
      children: [
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child:
                            Text('${widget.rankItemObjectList[index].motivo}'),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        '${widget.rankItemObjectList[index].points}',
                        style: TextStyle(
                            color: widget.rankItemObjectList[index]
                                        .pointsPositivos ==
                                    true
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  ),
                );
              },
              itemCount: widget.rankItemObjectList.length,
            ),
          ),
        )
      ],
    );
  }
}
