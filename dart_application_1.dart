import 'dart:io';
import 'dart:math';

void main() {
  print('Введите первое число (a):');
  double a = double.parse(stdin.readLineSync()!);
  
  print('Введите второе число (b):');
  double b = double.parse(stdin.readLineSync()!);
  
  print('Выберите операцию (+, -, *, /, ~/, %, pow, ==, !=, >, <, >=, <=, &&, ||, !):');
  String operation = stdin.readLineSync()!;
  
  dynamic result;
  
  switch (operation) {

    case '+': result = a + b; break;
    case '-': result = a - b; break;
    case '*': result = a * b; break;
    case '/': result = a / b; break;
    case '~/': result = (a ~/ b).toDouble(); break;
    case '%': result = a % b; break;
    case 'pow': result = pow(a, b).toDouble(); break;
    case '==': result = a == b; break;
    case '!=': result = a != b; break;
    case '>': result = a > b; break;
    case '<': result = a < b; break;
    case '>=': result = a >= b; break;
    case '<=': result = a <= b; break;
    
    case '&&':
    case '||':
    case '!':
      print('Введите первое логическое значение:');
      bool bool1 = stdin.readLineSync()!.toLowerCase() == 'true';
      print('Введите второе логическое значение:');
      bool bool2 = stdin.readLineSync()!.toLowerCase() == 'true';
      
      if (operation == '&&') result = bool1 && bool2;
      else if (operation == '||') result = bool1 || bool2;
      else result = !bool1; 
      
      if (operation == '!' && !bool1) {
        result = true;
      } else if (operation == '!' && bool1) {
        result = false;
      }
      break;
    
    default: 
      print('Недопустимая операция.'); 
      return;
  }
  
  print('Result: $result');
}






