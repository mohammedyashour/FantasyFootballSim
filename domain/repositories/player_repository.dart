
import '../entities/player.dart';

abstract class PlayerRepository {
  void add(Player player);
  List<Player> getAll();
  Player? getByPlayerNumber(int playerNumber);
  Player? getByName(String name);
}
