import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/modelController.dart';
import 'package:gp_version_01/Controller/offerController.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';

import '../Controller/itemController.dart';
import '../Controller/userController.dart';
import '../models/item.dart';

// ignore: must_be_immutable
class ReportDialog extends StatefulWidget {
  ReportDialog({this.item});
  Item item;
  var totalScore = 0;

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  @override
  Widget build(BuildContext context) {
    Future<void> _updateScore() async {
      int index = Provider.of<ItemController>(context, listen: false)
          .getIndex(widget.item);

      setState(() {
        widget.item.baneScore += widget.totalScore;
      });

      await Provider.of<ItemController>(context, listen: false)
          .addBanedItem(widget.item);

      await Provider.of<ItemController>(context, listen: false)
          .updatebaneScore(widget.item, index);

      if (Provider.of<ItemController>(context, listen: false)
          .isBanned(widget.item.baneScore)) {
        Provider.of<ItemController>(context, listen: false)
            .deleteItem(widget.item.id);
        Provider.of<ModelController>(context, listen: false)
            .deleteItem(widget.item.id);
        Provider.of<ItemOffersController>(context, listen: false)
            .deleteItem(widget.item.id);
      }

      await Provider.of<UserController>(context, listen: false)
          .baneIf((widget.totalScore * 0.5).toInt(), widget.item.itemOwner);

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }

    return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text("تبليغ عن...."),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Directionality(
                          textDirection: TextDirection.ltr,
                          child: RadioButtonGroup(
                            labels: <String>[
                              'محتوي غير لائق',
                              'المنتج غير متاح',
                              'صورة/نوع خاطىء',
                              'احتيال',
                              'اخري',
                            ],
                            onSelected: (String selected) {
                              setState(() {
                                switch (selected) {
                                  case 'محتوي غير لائق':
                                    widget.totalScore = 10;
                                    break;
                                  case 'المنتج غير متاح':
                                    widget.totalScore = 10;
                                    break;
                                  case 'صورة/نوع خاطىء':
                                    widget.totalScore = 10;
                                    break;
                                  case 'احتيال':
                                    widget.totalScore = 20;
                                    break;
                                  case 'اخري':
                                    widget.totalScore = 5;
                                    break;
                                }
                              });
                            },
                            labelStyle: TextStyle(color: Colors.black54),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              child: Text("تبليغ"),
              onPressed: _updateScore,
            ),
          ],
        ));
  }
}
