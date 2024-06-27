import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nossos_pontos/components/edit_motivo_modal.dart';
import 'package:nossos_pontos/controllers/home_controller.dart';
import 'package:nossos_pontos/domain/models/points_item_model.dart';
import 'package:nossos_pontos/domain/models/user_model.dart';

class CardName extends StatefulWidget {
  final List<PointsItemModel> pointsItemList;
  final HomeController controller;
  final UserModel userModel;
  const CardName({
    super.key,
    required this.userModel,
    required this.pointsItemList,
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
              widget.userModel.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${widget.userModel.pointsTotal}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      children: [
        Observer(builder: (context) {
          return SizedBox(
            height: size.height * 0.5,
            child: ListView.separated(
              controller: _scrollController,
              itemCount: widget.pointsItemList.length,
              separatorBuilder: (context, index) => Container(
                height: 3,
                color: Colors.blue,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(15, 30, 30, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              showEditMotivoModal(
                                context,
                                widget.controller,
                                widget.pointsItemList[index].motivo,
                                widget.pointsItemList[index].points,
                                index,
                                widget.pointsItemList[index],
                                widget.userModel,
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.mode_edit_rounded,
                            color: Colors.blue,
                          )),
                      Expanded(
                        child: Text(
                          widget.controller.firstLetterCapitalized(
                            widget.pointsItemList[index].motivo,
                          ),
                          style: const TextStyle(),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        '${widget.controller.pointsPositivosString(widget.pointsItemList[index].isPositivePoints)} ${widget.pointsItemList[index].points}',
                        style: TextStyle(
                            color: widget.pointsItemList[index].isPositivePoints
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        })
      ],
    );
  }
}

void showEditMotivoModal(
  BuildContext context,
  HomeController controller,
  String motivoOld,
  int pointsOld,
  int indexPointsItemList,
  PointsItemModel pointsItem,
  UserModel userModel,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Observer(builder: (context) {
          return EditMotivoModal(
            controller: controller,
            motivoOld: motivoOld,
            pointsOld: pointsOld,
            pointsItem: pointsItem,
            userModel: userModel,
          );
        }),
      );
    },
  );
}
