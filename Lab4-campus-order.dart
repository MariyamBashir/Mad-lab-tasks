// lab4 - Campus Cafe Order System
// Name: Maryam Bashir Roll no: 04072313017
const String rollNo = '04072313017';

final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit
const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];
int priceOf(int i) => 100 + 7 * i + 3 * t; // price of menu[i], in rupees
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;
// ===========================================================================

//classes
class Dish {
  late String name;
  late int price;
}

class MenuItem {
  String name;
  int price;
  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }
  MenuItem.free(this.name) : price = 0;
  MenuItem.fromString(String text)
    : name = text.split(':')[0],
      price = int.parse(text.split(':')[1]);
  @override
  String toString() => '$name (Rs $price)';
}

class OrderLog {
  static OrderLog? _instance;
  final List<String> entries = [];

  OrderLog._internal();

  factory OrderLog() {
    _instance ??= OrderLog._internal();
    return _instance!;
  }

  void add(String msg) => entries.add(msg);
}

class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;

  OrderLine(this.item, this.qty)
    : total = item.price * qty,
      tax = (item.price * qty) * taxPercent ~/ 100,
      assert(qty > 0, 'qty must be positive');

  int get grand => total + tax;
  bool get isBigOrder => grand > bigOrderLimit;
  String get label => '${item.name} x$qty';
}

OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

class StudentCard {
  final String owner;
  int _balance;

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }
}

List<MenuItem> buildMenu() {
  return [
    for (int k = 0; k <= 3; k++)
      MenuItem.fromString(
        '${menu[(u + 3 * k) % 10]}:${priceOf((u + 3 * k) % 10)}',
      ),
  ];
}

List<OrderLine> buildReceipt() {
  List<MenuItem> items = buildMenu().take(3).toList();
  return [for (int k = 0; k <= 2; k++) OrderLine(items[k], 1 + (t + k) % 4)];
}

class Coupon {
  static final Map<String, Coupon> _cache = {};
  final String code;
  final int percent;
  final int minSpend;

  Coupon(this.code, this.percent)
    : minSpend = percent * 70,
      assert(percent >= 1 && percent <= 50);

  factory Coupon.fromCode(String code) {
    return _cache.putIfAbsent(code, () => Coupon(code, couponPercent));
  }

  int discountOn(int amount) {
    if (amount >= minSpend) return amount * percent ~/ 100;
    return 0;
  }
}

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

  Dish item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);

  Dish item2 = Dish();
  int index2 = (u + 1) % 10;
  item2.name = menu[index2];
  item2.price = priceOf(index2);

  item2.price = item2.price - u;

  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
}

void step2() {
  print('--- Step 2 ---');
  MenuItem a = MenuItem(menu[u], priceOf(u));
  MenuItem b = MenuItem('Test Special', 15 * u);

  print('Step 2: ${a.name} Rs ${a.price}');
  print('Step 2: Test Special Rs ${b.price}');
  // Think Answer (Step 2): The 'price' field cannot be final because it is reassigned inside the constructor body (if it is less than the priceFloor).
  //A final variable can only be assigned exactly once during object initialization, and our price-clamping logic requires modifying it after that initial assignment.
}

void step3() {
  print('--- Step 3 ---');
  MenuItem freebie = MenuItem.free('Water');
  int i = (u + 2) % 10;
  MenuItem parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');

  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=$priceFloor, free price=${freebie.price}');
  // Think Answer (Step 3): The floor logic didnot run becaue it is inside the default constructor's body.
  // The named constructor MenuItem.free() does not call the default constructor, so it bypasses that logic entirely.
}

void step4() {
  print('--- Step 4 ---');
  OrderLog log1 = OrderLog();
  OrderLog log2 = OrderLog();

  for (int i = 1; i <= u + 2; i++) {
    String msg = 'order #${100 * t + i}';
    if (i % 2 != 0) {
      log1.add(msg);
    } else {
      log2.add(msg);
    }
  }

  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
  // Think Answer (Step 4): The underscore makes the _instance and _internal  private to the file.
  // If they were to be public, other files could use the internal constructor to create multiple instances or overwrite the shared instance, breaking the Singleton pattern, therefore this could go wrong.
}

void step5() {
  print('--- Step 5 ---');
  OrderLine line = mainOrder();
  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  try {
    OrderLine(line.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
  // Think Answer (Step 5): An initializer list cannot read another field of the same object beacuse it runs before the object is fully constructed, so 'this' is not available yet.
  // Fields like 'total' do not officially exist at that moment, so other initializers cannot read them.
}

void step6() {
  print('--- Step 6 ---');
  OrderLine line = mainOrder();
  print('Step 6: grand=${line.grand}');
  print('Step 6: big order? ${line.isBigOrder} (limit $bigOrderLimit)');
  print('Step 6: label=${line.label}');
  // Think Answer (Step 6): that line fails because 'grand' is defined as a getter, which makes it a read-only property.
  // To make it legal, you would need to define a corresponding setter.
}

void step7() {
  print('--- Step 7 ---');
  StudentCard card = StudentCard('S$seed');

  card.balance = seed * 10 + 50;
  print('Step 7: topped up -> ${card.balance}');

  card.balance = -seed - 1;
  print('Step 7: bad value -> ${card.balance}');

  card.balance = balanceCap - u;
  print('Step 7: reset -> ${card.balance}');

  card.balance = card.balance - mainOrder().grand;
  print('Step 7: paid order -> ${card.balance}');
  // Think Answer (Step 7): setter can Instead of clamping throw an exception or error (such as an ArgumentError) to immediately alert the developer that an invalid value was passed.
}

void step8() {
  print('--- Step 8 ---');
  List<MenuItem> menuItems = buildMenu();
  print('Step 8: menu = $menuItems');

  MenuItem priciest = menuItems.reduce((a, b) => a.price > b.price ? a : b);
  print('Step 8: priciest = ${priciest.name}');

  int sum = menuItems.fold(0, (prev, element) => prev + element.price);
  print('Step 8: sum = $sum');
}

void step9() {
  print('--- Step 9 ---');
  List<OrderLine> receipt = buildReceipt();
  int sumGrand = 0;

  for (OrderLine line in receipt) {
    print('Step 9: ${line.label} = ${line.grand}');
    OrderLog().add('receipt: ${line.label}');
    sumGrand += line.grand;
  }

  print('Step 9: receipt total = $sumGrand');
  print('Step 9: log size = ${OrderLog().entries.length}');
}

void step10() {
  print('--- Step 10 ---');
  String codeText = 'CAFE${seed.toString().padLeft(2, '0')}';
  Coupon c1 = Coupon.fromCode(codeText);
  Coupon c2 = Coupon.fromCode(codeText);

  List<OrderLine> receipt = buildReceipt();
  int receiptAmount = receipt.fold(0, (prev, line) => prev + line.grand);
  int discount = c1.discountOn(receiptAmount);

  print(
    'Step 10: $codeText gives ${c1.percent}% off, min spend ${c1.minSpend}',
  );
  print('Step 10: cached? ${identical(c1, c2)}');
  print(
    'Step 10: receipt $receiptAmount, discount $discount, payable ${receiptAmount - discount}',
  );
}
/*
Q1. The shorthand saves you from writing boilerplate code where you manually assign constructor arguments to the corresponding fields inside the constructor body.

Q2. Use a named constructor to offer a distinct, alternative way to create a NEW instance. Use a factory constructor when you need custom logic to decide whether to return a NEW object or an EXISTING cached one.

Q3. An initializer list executes BEFORE the constructor body and is the only place to set final fields before object creation. The constructor body runs AFTER the object is initialized, allowing you to run complex multi-step logic or validation.

Q4. Use a getter to calculate a fresh value on the fly without storing it in memory. Use a setter to validate or restrict data before saving it to a field, protecting the integrity of your object.
*/
