import 'package:flutter/material.dart';
import 'package:nossos_pontos/controllers/home_controller.dart';
import 'package:nossos_pontos/domain/models/points_item_model.dart';

class CardName extends StatefulWidget {
  final String name;
  final int pointsTotal;
  final List<PointsItemModel> pointsItem;
  final HomeController controller;
  const CardName({
    super.key,
    required this.name,
    required this.pointsTotal,
    required this.pointsItem,
    required this.controller,
  });

  @override
  State<CardName> createState() => _CardNameState();
}

class _CardNameState extends State<CardName> {
  bool expansionTileExpanded = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ExpansionTile(
      collapsedBackgroundColor: Colors.blue,
      backgroundColor: Colors.white,
      textColor: Colors.blue,
      iconColor: Colors.blue,
      collapsedIconColor: Colors.white,
      collapsedTextColor: Colors.white,
      collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
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
          if (expanded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollController.jumpTo(0); // Rola para o topo
            });
          }
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
              '${widget.pointsTotal}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      children: [
        SizedBox(
          height: size.height * 0.5,
          child: ListView.separated(
            controller: _scrollController,
            itemCount: widget.pointsItem.length,
            separatorBuilder: (context, index) => Container(
              height: 3,
              color: Colors.blue,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        //onPressed: widget.controller.editMotivo(
                          //  widget.name, widget.pointsTotal, widget.),
                        onPressed: (){},
                        icon: Icon(Icons.mode_edit_rounded)),
                    Expanded(
                      child: Text(
                        widget.controller.firstLetterCapitalized(
                          widget.pointsItem[index].motivo,
                        ),
                        style: const TextStyle(),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Text(
                      '${widget.controller.pointsPositivosString(widget.pointsItem[index].isPositivePoints)} ${widget.pointsItem[index].points}',
                      style: TextStyle(
                          color: widget.pointsItem[index].isPositivePoints
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
