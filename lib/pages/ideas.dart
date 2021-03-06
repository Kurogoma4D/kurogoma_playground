import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class IdeasPage extends StatefulWidget {
  @override
  _IdeasPageState createState() => _IdeasPageState();
}

class _IdeasPageState extends State<IdeasPage> {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    const dummyData = [
      ["dummy1", "dummy-dummy"],
      ["lolThisIsDummy", "yeeehhDummy", "whoa"],
      ["hooooo", "varr", "huh", "ooops", "lastOfThem"]
    ];

    return Column(
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        Container(
          height: 360,
          // TODO: after organize UI, revive this
          /* =====================================
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('ideas').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return AlertDialog(actions: <Widget>[FlatButton(child: Text("OK"),)]);
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return new CircularProgressIndicator();
                default:
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) =>
                      _buildIdea(context, snapshot.data.documents[index]["keywords"])
              );
            }
            }
          ),
          ========================================= */
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dummyData.length,
              itemBuilder: (context, index) =>
                  _buildIdea(context, dummyData[index])),
        ),
      ],
    );
  }

  Widget _buildIdea(BuildContext context, List<dynamic> keywords) {
    return Container(
      width: 280,
      child: Card(
        margin: const EdgeInsets.all(16),
          child: AbsorbPointer(
            child: ListView.builder(
              itemCount: keywords.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    keywords[index].toString(),
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                );
              },
            ),
          ),
        ),
    );
  }
}
