// library_lab.dart - Campus Library System
// Name: Maryam Bashir Roll no: 04072313017
const String rollNo = 'BCS-23-017'; // e.g. '21F-0347'
// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit
const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];
int yearOf(int i) => 1995 + 2 * i + t; // publication year of titles[i]
final int feePerDay = 5 + t; // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6; // normal number of days late
final int daysBig = 10 + u; // a long overdue period
final int feeCap = 150 + 10 * t; // no single fee may exceed this
final int renewLimit = 1 + t % 3; // renewals allowed per item
final int renewAttempts = 2 + u; // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4; // items on the shelf in Steps 9-10
// ===========================================================================

abstract class LibraryItem {
  //step 9
  static int created = 0;
  final String title;
  final int year;
  int lateFee(int days);
  //LibraryItem(this.title, this.year);
  LibraryItem(this.title, this.year) {
    created++;
  }
  String describe() => '$title ($year)';
  static int capFee(int fee) => fee > feeCap ? feeCap : fee;
}

//step 9
List<LibraryItem> buildShelf() {
  List<LibraryItem> shelf = [];
  for (int k = 0; k < shelfSize; k++) {
    int i = (u + k) % 10;
    if (k % 3 == 0) {
      shelf.add(Book(titles[i], yearOf(i), 100 + 3 * seed));
    } else if (k % 3 == 1) {
      shelf.add(Magazine(titles[i], yearOf(i), 1 + (t + k) % 12));
    } else {
      shelf.add(Dvd(titles[i], yearOf(i), 90 + seed % 40));
    }
  }
  return shelf;
}

abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

mixin Renewable {
  int renewals = 0;
  bool renew(int limit) {
    if (renewals >= limit) return false;
    renewals++;
    return true;
  }
}

class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  Book(super.title, super.year, this.pages);
  @override
  String describe() => '${super.describe()}, $pages pages';
  @override
  int lateFee(int days) => days * feePerDay;

  bool _out = false;

  @override
  bool get isAvailable => !_out;

  @override
  void borrow() => _out = true;

  @override
  void giveBack() => _out = false;
}

Book mainBook() => Book(titles[u], yearOf(u), 100 + 3 * seed);

//step2
class Magazine extends LibraryItem {
  final int issue;
  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';
  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

//step 3
//we made library class an  abstract class and added @override in both magazine and in book class
class Dvd extends LibraryItem with Renewable {
  final int minutes;
  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

Dvd mainDvd() {
  int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

//step 6
enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;
  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) => fee - (fee * discountPercent) ~/ 100;
}

//step 7
extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials => split(' ').map((w) => w[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) => fold(0, (sum, i) => sum + i.lateFee(days));
}

//step 8
class Fine {
  final int amount;
  const Fine(this.amount);

  Fine operator +(Fine o) => Fine(amount + o.amount);
  bool operator >(Fine o) => amount > o.amount;

  @override
  bool operator ==(Object other) => other is Fine && other.amount == amount;

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'Fine($amount)';
}

// ===========================================================================
void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  print('--- Step 1 ---');
  Book b = mainBook();
  LibraryItem item = b;
  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');
  // Think: item.pages is a compile error because the variable type is
  // LibraryItem, and LibraryItem has no pages field. Dart checks the
  // variable type, not the real object.
}

void step2() {
  print('--- Step 2 ---');
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');
  // Think: If I forget @override and mistype the name as descibe(), Dart
  // creates a NEW method instead of replacing describe(). So describe()
  // would still run the parent version and the output would not change.
}

void step3() {
  print('--- Step 3 ---');
  print(
    'Step 3: Book late fee for $daysLate days = ${mainBook().lateFee(daysLate)}',
  );
  print(
    'Step 3: Magazine late fee for $daysLate days = ${mainMagazine().lateFee(daysLate)}',
  );
  print(
    'Step 3: Dvd late fee for $daysLate days = ${mainDvd().lateFee(daysLate)}',
  );
  // Think: An abstract class is only a plan with missing method bodies,
  // so Dart does not allow creating an object directly from it.
}

void step4() {
  print('--- Step 4 ---');
  Book book = mainBook();
  print('Step 4: available? ${book.isAvailable}');
  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');
  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');
  List<LibraryItem> items = [book, mainMagazine(), mainDvd()];
  for (LibraryItem item in items) {
    print('Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}');
  }
  // Think: extends would give us the parent's ready-made code for free.
  // We did not want that, because Borrowable is only a list of promises
  // and we wanted to write our own method bodies.
}

void step5() {
  print('--- Step 5 ---');
  Book book = mainBook();
  int ok = 0;
  for (int k = 0; k < renewAttempts; k++) {
    if (book.renew(renewLimit)) ok++;
  }
  print('Step 5: renewed $ok of $renewAttempts attempts (limit $renewLimit)');
  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');
  // Think: Magazine must not renew. If renew was in LibraryItem, every
  // item would get it. A mixin gives it only to Book and Dvd.
}

void step6() {
  print('--- Step 6 ---');
  MemberType type = MemberType.values[seed % 3];
  int fee = mainBook().lateFee(daysLate);
  print('Step 6: member type = ${type.name} (index ${type.index})');
  print('Step 6: max loans = ${type.maxLoans}');
  print('Step 6: book fee $fee -> ${type.applyDiscount(fee)} after discount');
  // Think: MemberType.student cannot be mistyped, Dart checks it. The
  // string 'studnet' would compile fine and cause a hidden bug.
}

void step7() {
  print('--- Step 7 ---');
  MemberType type = MemberType.values[seed % 3];
  int discounted = type.applyDiscount(mainBook().lateFee(daysLate));
  List<LibraryItem> shelf = [mainBook(), mainMagazine(), mainDvd()];
  print('Step 7: ${discounted.rs}');
  print('Step 7: initials of "${titles[u]}" = ${titles[u].initials}');
  print(
    'Step 7: shelf fee for $daysLate days = ${shelf.totalLateFee(daysLate).rs}',
  );
  // Think: 72.rs reads like a natural property of the number and is easy
  // to chain, instead of wrapping the number inside a function rs(72).
}

void step8() {
  print('--- Step 8 ---');
  Fine f1 = Fine(mainBook().lateFee(daysLate));
  Fine f2 = Fine(mainMagazine().lateFee(daysLate));
  print('Step 8: $f1 + $f2 = ${f1 + f2}');
  print('Step 8: first bigger? ${f1 > f2}');
  print('Step 8: equal copies? ${f1 == Fine(f1.amount)}');
  print('Step 8: set size = ${{f1, Fine(f1.amount), f2}.length}');
  // Think: Without hashCode, equal Fines get different hash codes, so the
  // set treats them as different and the size becomes 3. Sets use
  // hashCode first and then ==, so both must agree.
}

void step9() {
  print('--- Step 9 ---');
  LibraryItem.created = 0;
  buildShelf();
  List<LibraryItem> shelf = buildShelf();
  print('Step 9: items created = ${LibraryItem.created}');
  print(
    'Step 9: capped fee = ${LibraryItem.capFee(shelf.first.lateFee(daysBig))} (cap $feeCap)',
  );
  print(
    'Step 9: const copies identical? ${identical(const Fine(10), const Fine(10))}',
  );
  print('Step 9: new copies identical? ${identical(Fine(10), Fine(10))}');
  // Think: static belongs to the class itself, not to any object, so it
  // can be read as LibraryItem.created without creating an object first.
}

void step10() {
  print('--- Step 10 ---');
}
