num maxOfThree(num a, num b, num c) {
  if (a >= b && a >= c) return a;
  if (b >= a && b >= c) return b;
  return c;
}

num sumList(List list) {
  num sum = 0;
  for (var value in list) {
    sum += value;
  }
  return sum;
}

num productList(List list) {
  num product = 1;
  for (var value in list) {
    product *= value;
  }
  return product;
}

List removeDuplicates(List list) {
  return list.toSet().toList();
}

int factorial(int n) {
  if (n < 0) throw ArgumentError('Факториал определён только для неотрицательных чисел');
  int result = 1;
  for (int i = 2; i <= n; i++) {
    result *= i;
  }
  return result;
}

bool containsElement(Iterable<Object?> container, dynamic element) {
  return container.contains(element);
}

void printOddIndexElements(List list) {
  for (int i = 1; i < list.length; i += 2) {
    print(list[i]);
  }
}

List reverseList(List list) {
  return list.reversed.toList();
}

double averageList(List list) {
  if (list.isEmpty) return 0.0;
  return sumList(list) / list.length;
}

int countOccurrences(List list, dynamic value) {
  int count = 0;
  for (var element in list) {
    if (element == value) count++;
  }
  return count;
}

void main() {
  print(maxOfThree(10, 25, 7));
  print(maxOfThree(-5, -1, -3));
  print(sumList([1, 2, 3, 4]));
  print(sumList([1.5, 2.5, 3.0]));
  print(productList([1, 2, 3, 4]));
  print(productList([2, 3, 4]));
  print(removeDuplicates([1, 2, 2, 3, 3, 3]));
  print(removeDuplicates(['a', 'b', 'a', 'c']));
  print(factorial(5));
  print(factorial(0));
  print(containsElement([1, 2, 3], 2));
  print(containsElement({1, 2, 3}, 5));
  print(containsElement([1,2,3], 1));
  printOddIndexElements(['a', 'b', 'c', 'd', 'e']);
  print(reverseList([1, 2, 3, 4]));
  print(reverseList(['x', 'y', 'z']));
  print(averageList([10, 20, 30]));
  print(averageList([1.5, 2.5, 3.5]));
  print(countOccurrences([1, 2, 1, 3, 1], 1));
  print(countOccurrences(['a', 'b', 'a', 'c'], 'a'));
}