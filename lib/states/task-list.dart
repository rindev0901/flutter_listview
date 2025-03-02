import 'package:flutter_qlnv/helpers/index.dart';
import 'package:flutter_qlnv/models/task.dart';
import 'package:flutter_qlnv/pages/task-list.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class MyTaskListPageState extends State<MyTaskListPage> {
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
