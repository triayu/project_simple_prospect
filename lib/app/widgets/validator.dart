class Validator {
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (!_isValidEmail(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  static String? minLength(String? value, int minLength) {
    if (value == null || value.length < minLength) {
      return "Minimum length should be $minLength characters";
    }
    return null;
  }

  static String? maxLength(String? value, int maxLength) {
    if (value == null || value.length > maxLength) {
      return "Maximum length should be $maxLength characters";
    }
    return null;
  }

  static bool _isValidEmail(String email) {
    // Regular expression untuk validasi email
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegExp.hasMatch(email);
  }
}





// class Validator {
//   static String? rule(
//     String? value, {
//       required bool = false,
//     }
//   )
//   {
//     if (required && value!.isEmpty){
//       return "This Field is required";
//     }
//     return null;
//   }

//   // /String Validator
//   static String? required(String? value) {
//     if (value!.isEmpty) return "This field is required";
//     return null;
//   }

//   static String? email(String? value) {
//     if (value!.isEmpty) return "This field is required";

//     final bool isValidEmail = RegExp(
//         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/-?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+" )
//       .hasMatch(value);

//       if (!isvalidEmail){
//         return "This field is not in a valid email format";
//       }
//       return null;
//   }

//   static String? number(String? value) {
//     if (value.isEmpty) return "This field is required";

//     final bool isNumber = RegExp(r"^[0-9]+$").hasMatch(value);
//     if (!isNumber) {
//       return "This field is not in a valid number format";
//     }
//   }
// }