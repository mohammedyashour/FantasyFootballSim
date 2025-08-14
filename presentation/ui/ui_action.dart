typedef AsyncAction = Future<void> Function();
typedef SyncAction = void Function();

class UiAction {
  final String name;
  final dynamic action;

  UiAction({required this.name, required this.action});
}
