class Employee {
  String code;
  String name;
  String phone;

  Employee(this.code, this.name, this.phone);

  static Employee createFactory({
    required code,
    required String name,
    required String phone,
  }) {
    return Employee(code, name, phone);
  }
}
