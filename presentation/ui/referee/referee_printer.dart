import '../../../domain/entities/referee.dart';

class RefereePrinter {
  static void printReferee(Referee referee) {
    print('''
=== Referee Details ===
ID: ${referee.id}
Name: ${referee.name}
Experience: ${referee.experienceYears} years
Strictness: ${referee.strictness}
=======================
''');
  }

  static void printReferees(List<Referee> referees) {
    if (referees.isEmpty) {
      print('No referees found!');
      return;
    }

    print('\n=== All Referees ===');
    for (var referee in referees) {
      printReferee(referee);
    }
    print('===================\n');
  }
}
