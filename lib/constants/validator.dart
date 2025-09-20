class Validator {
  static String? email(String? value, {String label = "Email"}) {
    value = value?.trim();
    if (value == null || value.isEmpty) return "⚠ Please enter $label";

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "⚠ Enter a valid email address";

    return null;
  }

  static String? password(String? value, {String label = "Password"}) {
    value = value?.trim();
    if (value == null || value.isEmpty) return "⚠ Please enter $label";
    if (value.length < 6) return "⚠ Password must be at least 6 characters";

    final hasUpper = RegExp(r'[A-Z]');
    final hasLower = RegExp(r'[a-z]');
    final hasDigit = RegExp(r'\d');
    final hasSpecial = RegExp(r'[!@#\$&*~]');

    if (!hasUpper.hasMatch(value))
      return "⚠ Password must contain at least 1 uppercase letter";
    if (!hasLower.hasMatch(value))
      return "⚠ Password must contain at least 1 lowercase letter";
    if (!hasDigit.hasMatch(value))
      return "⚠ Password must contain at least 1 number";
    if (!hasSpecial.hasMatch(value))
      return "⚠ Password must contain at least 1 special character (!@#\$&*~)";

    return null;
  }

  static String? name(String? value, {String label = "Name"}) {
    value = value?.trim();
    if (value == null || value.isEmpty) return "⚠ Please enter $label";
    if (value.length < 3) return "⚠ Name must be at least 3 characters long";

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) return "⚠ Name can only contain letters";

    return null;
  }

  static String? phone(String? value, {String label = "Phone Number"}) {
    value = value?.trim();
    if (value == null || value.isEmpty) return "⚠ Please enter $label";

    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value))
      return "⚠ Enter a valid 10-digit phone number";

    return null;
  }
}
