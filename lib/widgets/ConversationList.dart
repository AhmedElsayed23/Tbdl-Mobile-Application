import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/chatController.dart';
import 'package:gp_version_01/Screens/ChatDetailPage.dart';
import 'package:provider/provider.dart';

class ConversationList extends StatefulWidget {
  final Map<String, dynamic> temp;
  final String name;
  final String messageText;
  final String time;
  final bool isMessageRead;
  ConversationList(
      {@required this.name,
      @required this.messageText,
      @required this.time,
      @required this.isMessageRead,
      this.temp});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return GestureDetector(
      onTap: () async {
        await Provider.of<ChatController>(context, listen: false).getDocId(
            widget.temp['senId'] + "_" + widget.temp['recId'],
            widget.temp['recId'] + "_" + widget.temp['senId']);
        Navigator.pushNamed(context, ChatDetailPage.route,
            arguments: widget.temp);
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Card(
                    child: Icon(
                      Icons.person,
                      size: queryData.size.height * 0.061,
                      color: Theme.of(context).primaryColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
