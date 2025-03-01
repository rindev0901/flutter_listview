class Student {
  String code;
  String name;

  Student(this.code, this.name);

  static Student createFactory({required String code, required String name}) {
    return Student(code, name);
  }
}
