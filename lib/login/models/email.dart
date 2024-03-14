import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    if (value?.isEmpty == true) return EmailValidationError.empty;
    // Simple email validation for demonstration
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value ?? '')) {
      return EmailValidationError.invalid;
    }
    return null;
  }
}




// import 'package:formz/formz.dart';

// enum UsernameValidationError { empty }

// class Username extends FormzInput<String, UsernameValidationError> {
//   const Username.pure() : super.pure('');
//   const Username.dirty([super.value = '']) : super.dirty();

//   @override
//   UsernameValidationError? validator(String value) {
//     if (value.isEmpty) return UsernameValidationError.empty;
//     return null;
//   }
// }
