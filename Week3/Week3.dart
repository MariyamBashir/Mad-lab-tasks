// Week3.dart - Library Desk Assistant
// Name: Maryam Bashir
// Reg no: 04072313017

final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming'],
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile'],
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design'],
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math'],
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile'],
  },
];

// --- Part 1 ---
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

String formatTitle(String title, [String? author]) {
  return author == null ? title : '$title by $author';
}

Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {'title': title, 'author': author, 'year': year, 'copies': copies};
}

bool isClassic(int year) => year < 2000;

// --- Part 2 ---
List<String> transformAll(List<String> items, String Function(String) fn) {
  return items.map(fn).toList();
}

int Function() makeCounter() {
  int count = 0;
  return () => ++count;
}

double Function(int) makeFeeCalculator(double rate) {
  return (int days) => days * rate;
}

int sumDigits(int n) {
  if (n < 10) return n;
  return (n % 10) + sumDigits(n ~/ 10);
}

// --- Part 3 (Task 3.4 needs this top-level function and the remaining tasks are in void part3()) ---
Map<String, int> buildStock() {
  return {for (var b in books) b['title'] as String: b['copies'] as int};
}

// --- Part 4 ---
class Box<T> {
  T value;
  Box(this.value);
}

T firstOr<T>(List<T> items, T fallback) {
  return items.isEmpty ? fallback : items.first;
}

class Pair<A, B> {
  A first;
  B second;

  Pair(this.first, this.second);

  @override
  String toString() => '($first, $second)';
}
// --- Part 5 ---
class BookNotFoundException implements Exception {
  final String title;
  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;
  BookNotAvailableException(this.title);
}

void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }
  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }
  stock[title] = stock[title]! - 1;
}

Map<String, dynamic> findBook(String title) {
  return books.firstWhere((b) => b['title'] == title);
}

// --- Part 6 ---
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Dart in Action';
}

Future<String> fetchBroken() async {
  await Future.delayed(const Duration(milliseconds: 500));
  throw Exception('Server down');
}


void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

void part1() {
  print('--- Part 1 ---');
  print('Late fee: ${lateFee(5, 0.5)}');
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));
  print(makeBook(title: 'Clean Code', author: 'Martin'));
  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));
  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');
  var titles = ['Dart in Action', 'Clean Code'];

  print(transformAll(titles, (item) => item.toUpperCase()));
  print(transformAll(titles, (item) => '$item!'));

  var desk1 = makeCounter();
  var desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  var studentFee = makeFeeCalculator(0.25);
  var staffFee = makeFeeCalculator(0.10);
  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');

  print('Sum of digits: ${sumDigits(17)}');
}

void part3() {
  print('--- Part 3 ---');

  //task3.1
  var allTitles = books.map((b) => b['title'] as String).toList();
  var availableTitles = books
      .where((b) => (b['copies'] as int) > 0)
      .map((b) => b['title'] as String)
      .toList();
  print('Titles: $allTitles');
  print('Available: $availableTitles');

  //task3,2
  int totalCopies = books.fold(0, (sum, b) => sum + (b['copies'] as int));
  var years = books.map((b) => b['year'] as int).toList();
  int oldestYear = years.reduce((min, yr) => yr < min ? yr : min);
  print('Total copies: $totalCopies');
  print('Oldest year: $oldestYear');

  //task3.3
  var sortedBooks = List.of(books);
  sortedBooks.sort((x, y) => (x['year'] as int).compareTo(y['year'] as int));
  var sortedTitles = sortedBooks.map((b) => b['title'] as String).toList();
  print('By year: $sortedTitles');

  // Task 3.4: Map
  var stock = buildStock();
  print('Stock: $stock');
  stock.forEach((title, copies) {
    if (copies == 0) print('Out of stock: $title');
  });
  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');

  //task3.5
  Set<String> allTags = {
    for (var book in books) ...(book['tags'] as List<String>),
  };
  print('All tags: $allTags');

  var listA = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var listB = {'Clean Code', 'Flutter Basics', 'Algorithms'};

  print('Union: ${listA.union(listB)}');
  print('Common: ${listA.intersection(listB)}');
  print('Only in A: ${listA.difference(listB)}');
}

void part4() {
  print('--- Part 4 ---');

  var intBox = Box<int>(5);
  var stringBox = Box<String>('dart');
  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${stringBox.value}');
  // intBox.value = 'hello'; // Compile error: String can't be assigned to int

  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));
  print(firstOr<String>([], 'z'));

  print(Pair('Dart in Action', 3));
}
void part5() {
  print('--- Part 5 ---');
  var stock = buildStock();

  for (var title in ['Dart in Action', 'Flutter Basics', 'Unknown Book']) {
    try {
      checkOut(stock, title);
      print('Checked out: $title');
    } on BookNotAvailableException {
      print('Sorry: "$title" has no copies left');
    } on BookNotFoundException {
      print('Not found: "$title"');
    } finally {
      print('Transaction logged.');
    }
  }

  print('Copies left of Dart in Action: ${stock['Dart in Action']}');

  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}

Future<void> part6() async {
  print('--- Part 6 ---');

  print('Fetching...');
  String book = await fetchBookOfTheDay();
  print('Book of the day: $book');

  //task6.2
  // "Instance of '_Future<String>'" because the Future is not finished yet.

  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}

/*
REFLECTION ANSWERS
1. When would you choose fold over reduce?
I choose fold when I need a starting value, when the list might be
empty (reduce throws an error on an empty list), or when the result type is different from the item type.

2. What does it mean that a closure "captures" a variable? Which
variable was captured in makeCounter?
A closure keeps access to variables from the function where it was
created, even after that function has finished. In makeCounter, the
variable 'count' was captured.

3. Why must on BookNotAvailableException come before a general catch (e)?
Dart checks catch clauses from top to bottom and uses the first one
that matches. A general catch (e) matches everything, so the specific
handlers below it would never run.

4. Why does forgetting await still compile, but give the wrong result?
Calling an async function returns a Future straight away, and that is
valid code. Without await you get the unfinished Future object instead of the actual value.
*/
