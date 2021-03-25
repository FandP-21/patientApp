class Tests {
  int patient;
  int laboratory;
  TestName testName;
  Category category;
  List<TestResult> testResult;

  Tests(
      {this.patient,
      this.laboratory,
      this.testName,
      this.category,
      this.testResult});

  Tests.fromJson(Map<String, dynamic> json) {
    patient = json['patient'];
    laboratory = json['laboratory'];
    testName = json['test_name'] != null
        ? new TestName.fromJson(json['test_name'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['test_result'] != null) {
      testResult = new List<TestResult>();
      json['test_result'].forEach((v) {
        testResult.add(new TestResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient'] = this.patient;
    data['laboratory'] = this.laboratory;
    if (this.testName != null) {
      data['test_name'] = this.testName.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.testResult != null) {
      data['test_result'] = this.testResult.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestName {
  int id;
  String name;
  int service;

  TestName({this.id, this.name, this.service});

  TestName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['service'] = this.service;
    return data;
  }
}

class Category {
  int id;
  String name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class TestResult {
  int id;
  String name;
  String value;

  TestResult({this.id, this.name, this.value});

  TestResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}
