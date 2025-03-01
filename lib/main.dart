import 'package:flutter/material.dart';
import 'package:flutter_qlnv/models/employee.dart';
import 'package:flutter_qlnv/models/student.dart';
import 'package:flutter_qlnv/models/task.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

showAlertDialog({
  required BuildContext context,
  required String title,
  required String message,
}) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [okButton],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/",
      routes: {
        "/": (_) => const MyHomePage(title: 'Quản Lý Nhân Viên'),
        "/danh-sach-lop": (_) => const MyClassListPage(title: 'Danh Sách Lớp'),
        "/danh-sach-cong-viec":
            (_) => const MyTaskListPage(title: "Danh Sách Công Việc"),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Employee> _employeeList = List.empty(growable: true);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _addNewEmloyee(Employee newEmployee) {
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

                            _addNewEmloyee(newEmployee);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class MyClassListPage extends StatefulWidget {
  const MyClassListPage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _MyClassListPageState();
}

class _MyClassListPageState extends State<MyClassListPage> {
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

class MyStudentDetailPage extends StatelessWidget {
  const MyStudentDetailPage({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(student.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text("Thông tin sinh viên: ${student.name} - ${student.code}"),
      ),
    );
  }
}

class MyTaskListPage extends StatefulWidget {
  const MyTaskListPage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _MyTaskListPageState();
}

class _MyTaskListPageState extends State<MyTaskListPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final List<Task> _taskList = List.empty(growable: true);

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        // _dateController.text = "${picked.toLocal()}".split(' ')[0];
        _dateController.text = DateFormat("dd-MM-yyyy").format(picked);
      });
      _formKey.currentState?.validate();
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay currentTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (picked != null) {
      setState(() {
        final now = DateTime.now();
        final DateTime dateTime = DateTime(
          now.year,
          now.month,
          now.day,
          picked.hour,
          picked.minute,
        );

        // _timeController.text = picked.format(context);
        _timeController.text = DateFormat("HH:mm").format(dateTime);
      });
      _formKey.currentState?.validate();
    }
  }

  void _addNewTask(Task newTask) {
    if (_formKey.currentState!.validate()) {
      if (_taskList.any((t) => t.title == newTask.title)) {
        showAlertDialog(
          context: context,
          title: "Thông báo lỗi",
          message: "Công việc đã tồn tại!",
        );
        return;
      }
      setState(() {
        _taskList.add(newTask);
      });

      _dateController.clear();
      _timeController.clear();
      _titleController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
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
        margin: EdgeInsets.all(5),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // TextFormField for Job Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Tên công việc:",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn ngày'; // Validation message
                  }
                  return null;
                },
                onChanged: (value) {
                  // Trigger re-validation on input change
                  setState(() {
                    _formKey.currentState
                        ?.validate(); // Revalidate the form on input change
                  });
                },
              ),
              // Date Picker
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Ngày:",
                  suffixIcon: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepOrange, // Background color for the icon
                      borderRadius: BorderRadius.circular(
                        30,
                      ), // Rounded corners
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.black, // Icon color
                      size: 20,
                    ),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn giờ'; // Validation message
                  }
                  return null;
                },
              ),
              // Time Picker
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: "Giờ:",
                  suffixIcon: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepOrange, // Background color for the icon
                      borderRadius: BorderRadius.circular(
                        30,
                      ), // Rounded corners
                    ),
                    child: Icon(
                      Icons.access_time_filled,
                      color: Colors.black, // Icon color
                      size: 20,
                    ),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectTime(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên công việc'; // Validation message
                  }
                  return null;
                },
              ),
              // Task List Container
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, // Border color
                    ),
                    borderRadius: BorderRadius.circular(
                      8,
                    ), // Optional: for rounded corners
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: _taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var task = _taskList[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onLongPress: () => {},
                            onTap: () => {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${task.title} - ${task.startDate} - ${task.startTime}",
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var newTask = Task(
            startDate: _dateController.text,
            startTime: _timeController.text,
            title: _titleController.text,
          );
          _addNewTask(newTask);
        },
        tooltip: "Add new task",
        backgroundColor: Colors.deepOrange, // Background color
        foregroundColor: Colors.black, // Icon color
        elevation: 8, // Shadow elevation
        shape: RoundedRectangleBorder(
          // Custom shape (can use CircleBorder, etc.)
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
        mini: true,
        child: const Icon(Icons.add),
      ),
    );
  }
}
