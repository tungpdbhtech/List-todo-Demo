class Todo {
  late  String _title;
  late  bool _isDone;

  Todo({
    required String title,
    bool isDone = false,
  })  : _title = title,
        _isDone = isDone;

  String get title => _title;
  bool get isDone => _isDone;

  set title(String value) {
    _title = value;
  }

  set isDone(bool value) {
    _isDone = value;
  }
}
