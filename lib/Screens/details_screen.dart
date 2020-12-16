import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  static const String route = "/details";

  @override
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.amber,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        //width: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              height: 400,
              //width: 300,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Scaffold(
                        body: Image.network(
                          url,
                          height: double.infinity,
                          width: double.infinity,
                          //fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  );
                },
                child: Image.network(
                  url,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              top: 380,
              child: Container(
                alignment: Alignment.center,
                height: 600,
                width: double.infinity,
                //padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'سماعة',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'يمكن للطاقة أن تأخذ أشكالًا متنوعة منها طاقة حرارية، كيميائية، كهربائية، إشعاعية، نووية، طاقة كهرومغناطيسية، وطاقة حركية. هذه الأنواع من الطاقة يمكن تصنيفها بكونها طاقة حركية أو طاقة كامنة، في حين أن بعضها يمكن أن يكون مزيجًا من الطاقتين الكامنة والحركية معًا، وهذا يدرس في الديناميكا الحرارية.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'dfffffffffffffaf',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite),
              ),
            ],
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(40.0),
                    bottomRight: const Radius.circular(40.0),
                  ),
                ),
                height: 250,
                width: double.infinity,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                /*SizedBoxx(
                  height: 25,
                ),
                Text(
                  "ddddddddddddddddddd",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'ggggggggggggggggggg',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'dfffffffffffffaf',
                  textAlign: TextAlign.center,
                ),
                */
              ],
            ),
          )
        ],
      ),
    );
    */
