extension StringExtensions on String {
  bool get isNullOrEmpty => this == null || isEmpty;
  bool get isNotNullOrEmpty => this != null && isNotEmpty;

  static String stripString(String text) {
    return text.replaceAll(RegExp('[.!?\\-_,*/\'"(){}\[\]~`+=;|<>:]'), '').toLowerCase();
  }
}
