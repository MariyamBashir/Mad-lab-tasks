void printWelcome(String appname) {
  print('=== $appname ===');
}

String generatecode(String title) {
  return '${title.substring(0, 2).toUpperCase()}101';
}

void main([List<String> args = const []]) {
  //part1: steup and welcome
  printWelcome('Course Roster Manager');

  // Part 2: Course&Roster Data[cite: 1]
  const int maxCapacity = 4;
  final DateTime createdAt = DateTime.now();
  int capacity = maxCapacity;
  double creditHours = 3.0;

  List<String> enrolledStudents = ['Aiden', 'Maria', 'Jamal'];
  Set<String> waitlist = {'Priya', 'Noah'};
  Map<String, int> attendanceCount = {'Aiden': 3, 'Maria': 4, 'Jamal': 2};

  bool isOpen = enrolledStudents.length < capacity;

  print('Capacity: $capacity | Enrolled: ${enrolledStudents.length}');

  // Part 8 (Stretch Goal)
  String courseTitle = 'CS201: Mobile App Development';
  if (args.isNotEmpty) {
    courseTitle = args[0];
  }

  // Part 3: Null-Safe Instructor Info[cite: 1]
  String? instructorEmail;
  print(instructorEmail ?? 'TBA');

  print('Instructor email length: ${instructorEmail?.length ?? 0}');

  // Part 4: Formatting Strings[cite: 1]
  String rawNames = ' Aiden , maria, JAMAL, Priya ';
  List<String> cleanNames = [];
  for (var name in rawNames.split(',')) {
    cleanNames.add(name.trim());
  }

  String multiLineDescription =
      '''
Credits: $creditHours
Created: $createdAt
''';
  print(multiLineDescription);
  print('Seats left: ${capacity - enrolledStudents.length}');

  // Part 5: Operators in Action[cite: 1]
  int fullGroups = enrolledStudents.length ~/ 3;
  int leftover = enrolledStudents.length % 3;
  print('Full groups of 3: $fullGroups, leftover: $leftover');

  Object formInput = 'twenty-two';
  if (formInput is String) {
    print('Input is a valid text string: $formInput');
  }
  if (formInput is! int) {
    print('Input is not an integer');
  }

  var report = StringBuffer()
    ..write('Report: ')
    //..write('$courseTitle | Cap: $capacity | Roster: ')
    ..write('${enrolledStudents.length}');
  print(report.toString());

  List<String>? extraNotes = args.contains('--notes') ? [] : null;
  extraNotes?..add('Room change pending');
  print('Extra notes: $extraNotes');

  int? bonusSeats;
  bonusSeats ??= 0;
  print('Bonus seats: $bonusSeats');

  // Part 6: Enrollment Logic[cite: 1]
  if (isOpen && enrolledStudents.length < capacity) {
    print("You're in! Welcome aboard.");
  } else {
    print('Course is full or closed.');
  }

  int enrollmentStatusCode = args.length > 1
      ? (int.tryParse(args[1]) ?? 200)
      : 200;
  switch (enrollmentStatusCode) {
    case 200:
      print('Enrolled');
      break;
    case 404:
      print('Course not found');
      break;
    default:
      print('Unknown error');
      break;
  }

  String statusTag = isOpen ? 'OPEN' : 'FULL';
  print(statusTag);

  // Part 7: Reports & Loops[cite: 1]
  for (var student in enrolledStudents) {
    print(student);
  }

  attendanceCount.forEach((student, count) {
    print('$student: $count');
  });

  List<String> announcements = [
    'Welcome to $courseTitle',
    if (!isOpen) 'Course is FULL - waitlist open',
    for (var student in waitlist)
      'Reminder: $student, please confirm attendance',
  ];

  for (var announcement in announcements) {
    print(announcement);
  }
}
