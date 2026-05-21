class Teacher {
  final String name;
  Teacher(this.name);
}

class Subject {
  final String name;
  final List<Teacher> teachers;

  Subject({required this.name, required this.teachers});
}

class Department {
  final String name;
  final List<Subject> subjects;

  Department({required this.name, required this.subjects});
}

class Institute {
  final String name;
  final String location;
  final String image;
  final double rating;
  final List<Department> departments;

  Institute({
    required this.name,
    required this.location,
    required this.image,
    required this.rating,
    required this.departments,
  });
}
