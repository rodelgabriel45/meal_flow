class AppValidators {
  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }

    return null;
  }

  static String? positiveNumber(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }

    final number = int.tryParse(value);

    if (number == null) {
      return '$fieldName must be a number';
    }

    if (number <= 0) {
      return '$fieldName must be greater than 0';
    }

    return null;
  }
}
