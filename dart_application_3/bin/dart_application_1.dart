import 'dart:io';
import 'dart:math';
import 'package:characters/characters.dart';

enum Mood {
  excited('\u{1F60E}', 'взволнованный', 9),
  happy('\u{1F600}', 'счастливый', 7),
  calm('\u{1F60C}', 'спокойный', 5),
  tired('\u{1F62B}', 'уставший', 3);

  final String emoji;
  final String desc;
  final int energy;

  const Mood(this.emoji, this.desc, this.energy);
}

void main() {
  print('Введите ваше имя: ');
  String name = stdin.readLineSync() ?? 'Гость';

  print('Генерируем случайное настроение...');
  Random random = Random();
  
  List<Mood> allMoods = Mood.values;
  int randomIndex = random.nextInt(allMoods.length); 
  Mood chosenMood = allMoods[randomIndex];

  print('Привет, $name! Твое настроение: ${chosenMood.emoji} ${chosenMood.desc} (энергия: ${chosenMood.energy}/10)');

  
  int codePoint = chosenMood.emoji.runes.first;
  String hexCode = codePoint.toRadixString(16).toUpperCase();
  print('Юникод вашего эмодзи: U+$hexCode');

  print('Хотите просмотреть сложные эмодзи? (/нет): ');
  String answer = stdin.readLineSync() ?? 'нет';

  if (answer != '/нет' && answer != 'нет') {
    print('Введите комбинацию эмодзи: ');
    String input = stdin.readLineSync() ?? '';

    if (input.isNotEmpty) {
      print('Анализ строки "$input":');

      int utf16Units = input.length;
      int codePoints = input.runes.length;
      int realChars = input.characters.length;

      print('- 16-битных единиц: $utf16Units');
      print('- Кодовых точек: $codePoints');
      print('- Реальных символов: $realChars');

      print('Подробный вывод юникода:');
      int counter = 1;
      for (int rune in input.runes) {
        String ch = String.fromCharCode(rune);
        String h = rune.toRadixString(16).toUpperCase();
        print('Символ $counter: $ch → U+$h');
        counter++;
      }
    }
  }

  print('Спасибо, приходите снова!');
}