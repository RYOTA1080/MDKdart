import 'dart:math';

class Student {
  final String firstName;
  final String lastName;
  final Map<String, int> grades;

  Student(this.firstName, this.lastName, this.grades);

  String get fullName => '$firstName $lastName';
  
  double get averageGrade {
    if (grades.isEmpty) return 0.0;
    return grades.values.reduce((a, b) => a + b) / grades.length;
  }
  
  String get performanceCategory {
    double avg = averageGrade;
    if (avg >= 4.5) return 'Отличник';
    if (avg >= 3.5) return 'Хорошист';
    return 'Остальные';
  }
}

void main() {
  // Список предметов
  final subjects = ['Математика', 'Физика', 'Информатика', 'Литература', 'Химия', 'Биология', 'История', 'Английский'];
  
  // Базы данных имен и фамилий
  final firstNames = ['Иван', 'Петр', 'Мария', 'Анна', 'Дмитрий', 'Елена', 'Александр', 'Ольга', 
                      'Сергей', 'Татьяна', 'Андрей', 'Наталья', 'Максим', 'Юлия', 'Владимир', 
                      'Екатерина', 'Николай', 'Ирина', 'Павел', 'Ксения'];
  
  final lastNames = ['Иванов', 'Петров', 'Сидоров', 'Смирнов', 'Козлов', 'Морозов', 'Волков', 
                     'Новиков', 'Лебедев', 'Соколов', 'Михайлов', 'Федоров', 'Алексеев', 
                     'Никитин', 'Орлов', 'Андреев', 'Макаров', 'Захаров', 'Чернов', 'Кузнецов'];
  
  final random = Random();
  
  // Генерируем 20 случайных студентов
  List<Student> students = List.generate(20, (index) {
    String firstName = firstNames[index % firstNames.length];
    String lastName = lastNames[index % lastNames.length];
    
    // Генерируем оценки для каждого предмета
    Map<String, int> grades = {};
    for (var subject in subjects) {
      // Случайная оценка от 2 до 5, но с большей вероятностью 3-5
      int grade;
      if (random.nextDouble() < 0.7) {
        // 70% шанс получить 3,4,5
        grade = random.nextInt(3) + 3; // 3,4,5
      } else {
        // 30% шанс получить 2
        grade = 2;
      }
      grades[subject] = grade;
    }
    
    return Student(firstName, lastName, grades);
  });
  
  // Далее весь код отчета остается таким же, как в предыдущем примере
  print('=' * 80);
  print('РАСШИРЕННЫЙ ОТЧЕТ ПО ГРУППЕ (20 студентов)');
  print('=' * 80);
  
  // 1. Сводная таблица
  print('\n1. СВОДНАЯ ТАБЛИЦА УСПЕВАЕМОСТИ');
  print('-' * 80);
  
  // Заголовок таблицы
  String header = 'Студент'.padRight(20);
  for (var subject in subjects) {
    header += subject.padLeft(12);
  }
  header += 'Ср.балл'.padLeft(12);
  print(header);
  print('-' * 80);
  
  // Строки студентов
  for (var student in students) {
    String row = student.fullName.padRight(20);
    for (var subject in subjects) {
      int grade = student.grades[subject] ?? 0;
      row += grade.toString().padLeft(12);
    }
    row += student.averageGrade.toStringAsFixed(2).padLeft(12);
    print(row);
  }
  
  // Строка средних баллов по предметам
  String footer = 'Ср. по предм.'.padRight(20);
  double totalAverage = 0;
  for (var subject in subjects) {
    double subjectAvg = _calculateSubjectAverage(students, subject);
    footer += subjectAvg.toStringAsFixed(2).padLeft(12);
    totalAverage += subjectAvg;
  }
  double overallAverage = totalAverage / subjects.length;
  footer += overallAverage.toStringAsFixed(2).padLeft(12);
  print('-' * 80);
  print(footer);
  
  // 2. Поиск по фамилии (пример)
  print('\n2. ПОИСК ПО СТУДЕНТУ (пример: Иванов)');
  print('-' * 80);
  _searchStudent(students, 'Иванов');
  
  // 3. Уникальные оценки
  print('\n3. УНИКАЛЬНЫЕ ОЦЕНКИ В ЖУРНАЛЕ');
  print('-' * 80);
  Set<int> uniqueGrades = _getUniqueGrades(students);
  print('Оценки: ${uniqueGrades.toList()..sort()}');
  
  // 4. Максимальные и минимальные оценки по предметам
  print('\n4. МАКСИМАЛЬНЫЕ И МИНИМАЛЬНЫЕ ОЦЕНКИ ПО ПРЕДМЕТАМ');
  print('-' * 80);
  for (var subject in subjects) {
    _printSubjectExtremes(students, subject);
  }
  
  // 5. Студенты с ровно одной двойкой
  print('\n5. СТУДЕНТЫ С РОВНО ОДНОЙ ДВОЙКОЙ');
  print('-' * 80);
  _findStudentsWithSingleGrade(students, 2);
  
  // 6. Предметы со средним баллом выше общего среднего
  print('\n6. ПРЕДМЕТЫ СО СРЕДНИМ БАЛЛОМ ВЫШЕ ОБЩЕГО СРЕДНЕГО');
  print('-' * 80);
  _findSubjectsAboveOverallAverage(students, subjects);
  
  // 7. Категории успеваемости
  print('\n7. РАСПРЕДЕЛЕНИЕ ПО КАТЕГОРИЯМ УСПЕВАЕМОСТИ');
  print('-' * 80);
  _printPerformanceCategories(students);
  
  print('\n' + '=' * 80);
}

// Все вспомогательные функции остаются теми же
double _calculateSubjectAverage(List<Student> students, String subject) {
  var grades = students
      .map((s) => s.grades[subject])
      .where((g) => g != null)
      .cast<int>()
      .toList();
  
  if (grades.isEmpty) return 0.0;
  return grades.reduce((a, b) => a + b) / grades.length;
}

void _searchStudent(List<Student> students, String searchName) {
  var found = students.where((s) => 
      s.lastName.toLowerCase().contains(searchName.toLowerCase()) ||
      s.firstName.toLowerCase().contains(searchName.toLowerCase())).toList();
  
  if (found.isEmpty) {
    print('Студент "$searchName" не найден');
    return;
  }
  
  for (var student in found) {
    print('\nСтудент: ${student.fullName}');
    print('Оценки по предметам:');
    student.grades.forEach((subject, grade) {
      print('  $subject: $grade');
    });
    print('Средний балл: ${student.averageGrade.toStringAsFixed(2)}');
    print('Категория: ${student.performanceCategory}');
    print('-' * 40);
  }
}

Set<int> _getUniqueGrades(List<Student> students) {
  Set<int> grades = {};
  for (var student in students) {
    grades.addAll(student.grades.values);
  }
  return grades;
}

void _printSubjectExtremes(List<Student> students, String subject) {
  var grades = students
      .where((s) => s.grades.containsKey(subject))
      .map((s) => MapEntry(s, s.grades[subject]!))
      .toList();
  
  if (grades.isEmpty) {
    print('$subject: нет оценок');
    return;
  }
  
  int maxGrade = grades.map((e) => e.value).reduce((a, b) => a > b ? a : b);
  int minGrade = grades.map((e) => e.value).reduce((a, b) => a < b ? a : b);
  
  var maxStudents = grades.where((e) => e.value == maxGrade).map((e) => e.key.fullName);
  var minStudents = grades.where((e) => e.value == minGrade).map((e) => e.key.fullName);
  
  print('$subject:');
  print('  Максимальная оценка $maxGrade: ${maxStudents.join(', ')}');
  print('  Минимальная оценка $minGrade: ${minStudents.join(', ')}');
}

void _findStudentsWithSingleGrade(List<Student> students, int targetGrade) {
  var result = students.where((s) {
    int count = s.grades.values.where((g) => g == targetGrade).length;
    return count == 1;
  }).toList();
  
  if (result.isEmpty) {
    print('Нет студентов с ровно одной оценкой $targetGrade');
    return;
  }
  
  for (var student in result) {
    var subject = student.grades.entries.firstWhere((e) => e.value == targetGrade).key;
    print('${student.fullName} - $subject');
  }
}

void _findSubjectsAboveOverallAverage(List<Student> students, List<String> subjects) {
  double overallAverage = _calculateOverallAverage(students, subjects);
  print('Общий средний балл по группе: ${overallAverage.toStringAsFixed(2)}');
  
  var aboveAverage = <String>[];
  for (var subject in subjects) {
    double subjectAvg = _calculateSubjectAverage(students, subject);
    if (subjectAvg > overallAverage) {
      aboveAverage.add('$subject (${subjectAvg.toStringAsFixed(2)})');
    }
  }
  
  if (aboveAverage.isEmpty) {
    print('Нет предметов со средним баллом выше общего');
  } else {
    print('Предметы выше общего среднего:');
    aboveAverage.forEach((s) => print('  $s'));
  }
}

double _calculateOverallAverage(List<Student> students, List<String> subjects) {
  double total = 0;
  int count = 0;
  
  for (var student in students) {
    for (var subject in subjects) {
      if (student.grades.containsKey(subject)) {
        total += student.grades[subject]!;
        count++;
      }
    }
  }
  
  return count > 0 ? total / count : 0.0;
}

void _printPerformanceCategories(List<Student> students) {
  var categories = {
    'Отличники': students.where((s) => s.performanceCategory == 'Отличник').toList(),
    'Хорошисты': students.where((s) => s.performanceCategory == 'Хорошист').toList(),
    'Остальные': students.where((s) => s.performanceCategory == 'Остальные').toList(),
  };
  
  categories.forEach((category, studentList) {
    print('$category: ${studentList.length} ${_getStudentWord(studentList.length)}');
    if (studentList.isNotEmpty) {
      print('  ${studentList.map((s) => s.fullName).join(', ')}');
    }
  });
}

String _getStudentWord(int count) {
  if (count % 10 == 1 && count % 100 != 11) return 'студент';
  if ([2, 3, 4].contains(count % 10) && ![12, 13, 14].contains(count % 100)) {
    return 'студента';
  }
  return 'студентов';
}