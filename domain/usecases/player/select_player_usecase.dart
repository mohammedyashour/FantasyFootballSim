import '../../entities/player.dart';

class SelectPlayerUseCase {
  final List<Player> currentPlayers;

  SelectPlayerUseCase(this.currentPlayers);

  Player? findPlayer(String name) {
    try {
      return currentPlayers.firstWhere(
        (p) => p.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  List<Player> filterByAgeRange(int minAge, int maxAge) {
    return currentPlayers
        .where((p) => p.age >= minAge && p.age <= maxAge)
        .toList();
  }

  List<Player> filterByPosition(String position) {
    return currentPlayers
        .where((p) => p.position.name.toLowerCase() == position.toLowerCase())
        .toList();
  }

  List<Player> filterByMinimumOverall(double minOverall) {
    return currentPlayers.where((p) => p.overallRate >= minOverall).toList();
  }

  List<Player> sortByOverall({bool descending = true}) {
    final sorted = List<Player>.from(currentPlayers);
    sorted.sort(
      (a, b) =>
          descending
              ? b.overallRate.compareTo(a.overallRate)
              : a.overallRate.compareTo(b.overallRate),
    );
    return sorted;
  }

  List<Player> sortByAge({bool descending = false}) {
    final sorted = List<Player>.from(currentPlayers);
    sorted.sort(
      (a, b) => descending ? b.age.compareTo(a.age) : a.age.compareTo(b.age),
    );
    return sorted;
  }
}
