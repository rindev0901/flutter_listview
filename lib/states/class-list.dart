import 'package:flutter_qlnv/helpers/index.dart';
import 'package:flutter_qlnv/models/student.dart';
import 'package:flutter_qlnv/pages/class-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qlnv/pages/student-detail.dart';

class MyClassListPageState extends State<MyClassListPage> {
  final List<Student> _studentList = [
    Student("DH52107825", "DUC"),
    Student("DH52107821", "ABC"),
    Student("DH52107822", "KJKJ"),
    Student("DH52107823", "MD"),
    Student("DH52107824", "L:M:DAS:D"),
  ];

  String? _oneSelected = "";

  @override
  void initState() {
    super.initState();
    // Initialize _oneSelected in initState after _studentList is available
    _oneSelected =
        _studentList[0]
            .code; // Set the initial selected value to the first student's code
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        margin: EdgeInsets.all(10),
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: _studentList.length,
                itemBuilder: (BuildContext context, int index) {
                  var student = _studentList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onLongPress:
                            () => {
                              setState(() {
                                _studentList.remove(student);
                              }),
                            },
                        onTap:
                            () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          MyStudentDetailPage(student: student),
                                ),
                              ),
                            },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Radio(
                              activeColor: Colors.blue,
                              value: student.code,
                              groupValue: _oneSelected,
                              onChanged: (value) {
                                showAlertDialog(
                                  context: context,
                                  title: "Thông tin sinh viên",
                                  message: "${student.name} - ${student.code}",
                                );
                                setState(() {
                                  _oneSelected =
                                      value
                                          as String; // Update the selected value
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                "${student.name} - ${student.code}",
                                // style: Typographies.largeBodyStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder:
                    (BuildContext context, int index) =>
                        const Padding(padding: EdgeInsets.all(10)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_right),
        onPressed: () => {Navigator.pushNamed(context, "/danh-sach-lop")},
      ),
    );
  }
}
