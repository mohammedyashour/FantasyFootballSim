import '../../domain/entities/player.dart';
import '../../domain/repositories/player_repository.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final List<Player> _players = [];

  @override
  void add(Player player) => _players.add(player);

  @override
  List<Player> getAll() => List.unmodifiable(_players);



  @override
  Player? getById(String id) {
    try {
      return _players.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Player? getByName(String name) {
    try {
      return _players.firstWhere((p) => p.name == name);
    } catch (_) {
      return null;
    }
  }
}
