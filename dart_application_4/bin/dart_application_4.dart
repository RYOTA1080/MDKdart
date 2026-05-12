class Mug {
  double volume;
  double current;
  Mug(this.volume) : current = volume;
  double drink(double ml) {
    double taken = current < ml ? current : ml;
    current -= taken;
    return taken;
  }
}

class Person {
  String name;
  Person(this.name);
  void drinkFromMug(Mug mug, double ml) {
    double amount = mug.drink(ml);
    print('$name выпил $amount мл');
  }
}

class Wardrobe {
  List<List<String>> shelves = [];
  Wardrobe(int count) {
    for (int i = 0; i < count; i++) {
      shelves.add([]);
    }
  }
  void put(int index, String item) {
    shelves[index].add(item);
    print('Вещь $item добавлена на полку $index');
  }
  String take(int index) {
    if (shelves[index].isEmpty) {
      return 'Полка пуста';
    }
    String item = shelves[index].removeLast();
    return 'Забрана вещь: $item';
  }
}

class Weight {
  double weight;
  Weight(this.weight);
}

class Barbell {
  double maxWeight;
  List<Weight> left = [];
  List<Weight> right = [];
  double currentWeight = 0;
  Barbell(this.maxWeight);
  void add(Weight w, bool isLeft) {
    if (currentWeight + w.weight > maxWeight) {
      print('Превышен лимит веса');
      return;
    }
    if (isLeft) {
      left.add(w);
    } else {
      right.add(w);
    }
    currentWeight += w.weight;
    print('Добавлено ${w.weight} кг. Итого: $currentWeight кг');
  }
}

class CurrencyConverter {
  Map<String, double> rates = {
    'USD': 1.0,
    'RUB': 90.0,
    'EUR': 0.92
  };
  double convert(double amount, String from, String to) {
    double inDollars = amount / rates[from]!;
    return inDollars * rates[to]!;
  }
}

class Garage<T> {
  List<T> items = [];
  void put(T object) {
    items.add(object);
    print('В гараж добавлен: $object');
  }
  T? get() {
    if (items.isEmpty) {
      return null;
    }
    return items.removeLast();
  }
}

class MyNumber {
  int value;
  MyNumber(this.value);
  MyNumber operator +(MyNumber other) => MyNumber(value + other.value);
  MyNumber operator -(MyNumber other) => MyNumber(value - other.value);
  MyNumber operator *(MyNumber other) => MyNumber(value * other.value);
  @override
  String toString() => '[$value]';
}

enum State { stopped, moving, turning }

class Car {
  State state = State.stopped;
  int speed = 0;
  void start() {
    state = State.moving;
    speed = 60;
    print('Машина едет со скоростью $speed');
  }
  void turn() {
    state = State.turning;
    speed = 30;
    print('Машина поворачивает со скоростью $speed');
  }
  void stop() {
    state = State.stopped;
    speed = 0;
    print('Машина остановилась');
  }
}

abstract class Shape {
  double area();
}

class Rectangle extends Shape {
  double width, height;
  Rectangle(this.width, this.height);
  @override
  double area() => width * height;
}

class Circle extends Shape {
  double radius;
  Circle(this.radius);
  @override
  double area() => 3.14 * radius * radius;
}

class Triangle extends Shape {
  double base, height;
  Triangle(this.base, this.height);
  @override
  double area() => (base * height) / 2;
}

class BaseConverter {
  String convertTo(int number, int base) {
    return number.toRadixString(base).toUpperCase();
  }
  int convertToDecimal(String number, int base) {
    return int.parse(number, radix: base);
  }
}

class ShapeManager {
  List<Shape> shapes = [];
  void add(Shape shape) {
    shapes.add(shape);
  }
  Shape? findLargest() {
    if (shapes.isEmpty) {
      return null;
    }
    Shape largest = shapes[0];
    for (Shape s in shapes) {
      if (s.area() > largest.area()) {
        largest = s;
      }
    }
    return largest;
  }
}

class Utensil {
  String name;
  Utensil(this.name);
}

class Fork extends Utensil {
  Fork() : super('Fork');
}

class Spoon extends Utensil {
  Spoon() : super('Spoon');
}

class Table {
  List<Utensil> utensils = [];
  void place(Utensil u) {
    utensils.add(u);
    print('На стол положено: ${u.name}');
  }
  void remove(Utensil u) {
    utensils.remove(u);
    print('Со стола убрано: ${u.name}');
  }
}

void main() {
  print('Задача 1');
  Mug mug = Mug(300);
  Person person = Person('Иван');
  person.drinkFromMug(mug, 150);

  print('Задача 2');
  Wardrobe wardrobe = Wardrobe(3);
  wardrobe.put(0, 'Куртка');
  print(wardrobe.take(0));

  print('Задача 3');
  Barbell barbell = Barbell(100);
  barbell.add(Weight(20), true);
  barbell.add(Weight(20), false);

  print('Задача 4');
  CurrencyConverter converter = CurrencyConverter();
  print('Результат конвертации: ${converter.convert(1000, 'RUB', 'USD')}');

  print('Задача 5');
  Garage<String> garage = Garage();
  garage.put('BMW');
  garage.get();

  print('Задача 6');
  MyNumber a = MyNumber(10);
  MyNumber b = MyNumber(5);
  print('Сумма: ${a + b}');
  print('Разность: ${a - b}');
  print('Произведение: ${a * b}');

  print('Задача 7');
  Car car = Car();
  car.start();
  car.turn();
  car.stop();

  print('Задача 8');
  Shape s1 = Rectangle(5, 4);
  Shape s2 = Circle(3);
  print('Площадь прямоугольника: ${s1.area()}');
  print('Площадь круга: ${s2.area()}');

  print('Задача 9');
  BaseConverter baseConv = BaseConverter();
  print('255 в HEX: ${baseConv.convertTo(255, 16)}');
  print('1010 (binary) в DEC: ${baseConv.convertToDecimal('1010', 2)}');

  print('Задача 10');
  ShapeManager manager = ShapeManager();
  manager.add(Rectangle(2, 3));
  manager.add(Circle(2));
  manager.add(Triangle(4, 2));
  Shape? largest = manager.findLargest();
  print('Максимальная площадь: ${largest?.area()}');

  print('Задача 11');
  Table table = Table();
  Fork fork = Fork();
  Spoon spoon = Spoon();
  table.place(fork);
  table.place(spoon);
  table.remove(fork);
}