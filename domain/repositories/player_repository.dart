import '../entities/player.dart';

abstract class PlayerRepository {
  void add(Player player);
  List<Player> getAll();
  Player? getById(String id);
  Player? getByName(String name);
}
