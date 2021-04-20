import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyRepairIDDisplay extends StatefulWidget {
  @override
  _MyRepairIDDisplayState createState() => _MyRepairIDDisplayState();
}

class _MyRepairIDDisplayState extends State<MyRepairIDDisplay> {
  final _inputIdController = TextEditingController();
  bool _search = false;
  String _input = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyRepair ID'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  TextFormField(
                    controller: _inputIdController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_inputIdController.text.isNotEmpty) {
                            _search = true;
                            _input = _inputIdController.text.toString();
                            print(_input);
                          }
                        });
                      },
                      child: Text('Cari'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Divider(),
                  ),
                ],
              ),
            ),
            _search == true
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('MyrepairID')
                        .doc(_input)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading...');
                      } else if (!snapshot.data.exists) {
                        return Text('Tiada data ditemui');
                      }
                      var userDocument = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Model: ${userDocument['Model']}'),
                          Text('Kerosakkan: ${userDocument['Kerosakkan']}'),
                          Text('Status: ${userDocument['Status']}'),
                        ],
                      );
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
