import 'package:flutter_qlnv/helpers/index.dart';
import 'package:flutter_qlnv/models/employee.dart';
import 'package:flutter_qlnv/pages/home.dart';
import 'package:flutter/material.dart';

class MyHomePageState extends State<MyHomePage> {
  final List<Employee> _employeeList = List.empty(growable: true);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _addNewEmployee(Employee newEmployee) {
    if (_employeeList.any((e) => e.code == newEmployee.code)) {
      showAlertDialog(
        context: context,
        title: "Thông báo lỗi",
        message: "Mã nhân viên đã tồn tại!",
      );
      return;
    }

    setState(() {
      _employeeList.add(newEmployee);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
            Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _codeController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Mã:",
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Tên:",
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "SĐT:",
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Employee newEmployee = Employee.createFactory(
                              code: _codeController.text,
                              name: _nameController.text,
                              phone: _phoneController.text,
                            );

                            _addNewEmployee(newEmployee);
                            _codeController.clear();
                            _nameController.clear();
                            _phoneController.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 5,
                          ),
                          backgroundColor: Colors.green, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              2,
                            ), // Rounded corners
                          ),
                        ),
                        child: const Text(
                          "Lưu",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: _employeeList.length,
                itemBuilder: (BuildContext context, int index) {
                  final employee = _employeeList[index];

                  return Container(
                    // Add a border to each item using BoxDecoration
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        spacing: 2,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mã: ${employee.code}"),
                              Text("Tên: ${employee.name}"),
                              Text("SĐT: ${employee.phone}"),
                            ],
                          ),
                        ],
                      ),
                    ),
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
      floatingActionButton: new FloatingActionButton(
        child: const Icon(Icons.arrow_right),
        onPressed: () => {Navigator.pushNamed(context, "/danh-sach-lop")},
      ),
    );
  }
}
