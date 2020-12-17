import 'package:flutter/material.dart';
import 'package:gp_version_01/widgets/description_item.dart';

class Details extends StatefulWidget {
  static const String route = "/details";
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Map detailsMap = {
    'موديل':
        'يمكن للطاقة أن تأخذ أشكالًا متنوعة منها طاقة حرارية، كيميائية، كهربائية، إشعاعية، نووية، طاقة كهرومغناطيسية، وطاقة حركية. هذه الأنواع من الطاقة يمكن تصنيفها بكونها طاقة حركية أو طاقة كامنة، في حين أن بعضها يمكن أن يكون مزيجًا من الطاقتين الكامنة والحركية معًا، وهذا يدرس في الديناميكا الحرارية.',
    'مكان': 'زهراء السلام'
  };
  @override
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.report_problem, color: Colors.amber[200]),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border),
              ),
            ],
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      height: 325,
                      child: Image.network(
                        url,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: Colors.black54,
                        ),
                        width: double.infinity,
                        child: Text(
                          "سماعة بلوتوث سامسونج اصلية",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          softWrap: true,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Card(
                        margin: EdgeInsets.all(7),
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              Spacer(),
                              Text('زهراء السلام'),
                            ],
                          ),
                        ),
                      ),
                      Divider(color: Colors.black45),
                      Card(
                        margin: EdgeInsets.all(7),
                        elevation: 1,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              "يمكن للطاقة أن تأخذ أشكالًا متنوعة منها طاقة حرارية، كيميائية، كهربائية، إشعاعية، نووية، طاقة كهرومغناطيسية، وطاقة حركية. هذه الأنواع من الطاقة يمكن تصنيفها بكونها طاقة حركية أو طاقة كامنة، في حين أن بعضها يمكن أن يكون مزيجًا من الطاقتين الكامنة والحركية معًا، وهذا يدرس في الديناميكا الحرارية.",
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Divider(color: Colors.black45),
                      DescriptionItem(detailsMap),
                      Divider(color: Colors.black45),
                      SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      /*floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton.extended(
                heroTag: "left",
                backgroundColor: Colors.amber[900],
                onPressed: () {},
                label: Text("قدم عرض"),
              ),
              FloatingActionButton(
                heroTag: "middle",
                backgroundColor: Colors.green[500],
                onPressed: null,
                child: Icon(
                  Icons.phone,
                ),
              ),
              FloatingActionButton.extended(
                heroTag: 'right',
                backgroundColor: Colors.amber[900],
                onPressed: () {},
                label: Text("تكلم معه"),
              )
            ],
          ),
        )*/
    );
  }
}
