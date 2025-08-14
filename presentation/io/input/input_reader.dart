abstract class InputReader {
  String readString(String prompt, {bool required = true});

  int readInt(
    String prompt, {
    int? min,
    int? max,
    int? defaultValue,
    bool required = true,
  });

  bool readBoolean(String prompt, {bool defaultValue = false});

  double readDouble(
    String prompt, {
    double? min,
    double? max,
    double? defaultValue,
    bool required = true,
  });

  void waitForEnter(String prompt);

  int chooseFromMenu(String header, List<String> options);
}
