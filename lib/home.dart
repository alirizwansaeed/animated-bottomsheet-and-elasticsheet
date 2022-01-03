import 'package:animatedbttomsheet/elasticsheet.dart';
import 'package:animatedbttomsheet/newsnap_sheet.dart';
import 'package:flutter/material.dart';

///
///
///
///
/// if you face bottom overflow error wrap the last elemet of column in Expanded
///
///
///if u apply elastic effect of all element of column wrap all element in Expanded(one by one, not all)
///
///
///
///
///
///
///
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      bottomSheet: NewSnapsheet(
        listWidget: ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: 100,
          physics: const ScrollPhysics(),
          //TODO shrinkwrap must be provide
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const ListTile(
              title: Text(
                'what should ',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
        listfirstElementWidget: const ListTile(
          title: Text(
            'Erkunde die Wolt Stade',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
            'header',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        headerTextWidget: Text(
          'Erkunde die wolt stadete',
          style: TextStyle(
              color: Colors.grey.shade200, fontWeight: FontWeight.bold),
        ),
      ),

      ///
      //////
      ///
      ///
      ///
      ///
      ///
      ///
      body: Center(
        child:
            ElevatedButton(onPressed: _bottomSheet, child: const Text('show')),
      ),
    );
  }

  void _bottomSheet() {
    showModalBottomSheet(
      context: context,

      //TODO is for dismiss outside of widget
      isDismissible: false,

      ///shape to bottomsheet top border
      ///TODO border must provide to sheet to make upper border rounded
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      builder: (context) => ElasticSheet(
//TODO this is for dismissable for dragdown
        isDismissible: false,
        child: _sheetChild(context),
      ),
    );
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  Widget _sheetChild(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,

      ///TODO list view is impulsory for avoiding bottomoverflow
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Standort",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ListTile(
            leading: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.near_me),
            ),
            title: Text('Aktuellen Standort verwenden'),
            subtitle: Text('Aktuellen Standort verwenden'),
          ),
          const ListTile(
            leading: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
            title: Text('Neue Adresse hinzufugen'),
          ),
          const ListTile(
            tileColor: Colors.blue,
            leading: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.format_list_bulleted,
                color: Colors.blue,
              ),
            ),
            title: Text(
              'wolt stadte durchsuchen',
              style: TextStyle(color: Colors.blue),
            ),
            subtitle: Text('Humburg', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
