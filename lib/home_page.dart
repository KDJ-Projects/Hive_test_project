import 'dart:ffi';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference our box
  final _myBox = Hive.box("mybox");
  final _myDateController = TextEditingController();
  final _myVacationController = TextEditingController();
  final _myInputDate = TextEditingController();
  final _myOutPutlabelText = TextEditingController();

  // clear text inputfields
  void clearText() {
    _myDateController.clear();
    _myVacationController.clear();
    _myInputDate.clear();
    _myOutPutlabelText;
  }

  // write data to database
  void writeData() {
    _myBox.put(_myDateController.text, _myVacationController.text);

    clearText();
  }

  // fetch data out of database
  String fetchData() {
    // print(_myBox.get("20-08-2022"));
    // var myHours = _myBox.get("14-08-2022");
    var myDate = _myInputDate.text;
    print(myDate);
    var myHours = _myBox.get(myDate);
    print(myHours);
    clearText();

    return _myOutPutlabelText.text =
          "Je hebt op $myDate $myHours uur opgenomen";
      
    

    // total database entry's
    // print(_myBox.length);

    // print all database entry's
    // print(_myBox.toMap());
  }

  // delete data out of database
  void deletData() {
    _myBox.delete("20-08-2022");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Text input fields
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextField(
                  controller: _myDateController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Enter Date"),
                ),
              ),
            ),

            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextField(
                  controller: _myVacationController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Vacation houres"),
                ),
              ),
            ),

            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextField(
                  controller: _myInputDate,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Datum voor opvragen verlofuren"),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: TextField(
                controller: _myOutPutlabelText,
                decoration: const InputDecoration(
                  isCollapsed: true,
                ),
              ),
            ),

            // Buttons
            SizedBox(
              width: 300,
              child: MaterialButton(
                onPressed: writeData,
                child: Text("Add Vacation"),
                color: Colors.green[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: MaterialButton(
                onPressed: fetchData,
                child: Text("Fetch Vacation"),
                color: Colors.blue[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: MaterialButton(
                onPressed: deletData,
                child: Text("Delete Vacation"),
                color: Colors.red[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
