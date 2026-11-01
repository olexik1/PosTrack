class AuthException implements Exception {
  final String errorCode;

  const AuthException({
    required this.errorCode,
  });

  String translateFirebaseException() {
    String displayMessage;

    switch(errorCode) {
      case 'email-already-in-use':
        displayMessage = 'Ця електронна адреса вже зареєстрована';
        break;
      case 'invalid-email':
        displayMessage = 'Некоректна електронна адреса';
        break;
      case 'operation-not-allowed':
        displayMessage = 'Реєстрація цим способом наразі недоступна';
        break;
      case 'network-request-failed':
        displayMessage = "Помилка з'єднання. Перевірте інтернет";
        break;
      case 'too-many-requests':
        displayMessage = "Забагато спроб. Спробуйте пізніше";
        break;
      case 'weak-password':
        displayMessage = "Пароль заслабкий";
        break;
      case 'user-not-found':
        displayMessage = 'Користувача з цією електронною адресою не знайдено';
        break;
      case 'wrong-password':
        displayMessage = 'Введено неправильний пароль для цього користувача';
        break;
      default:
        displayMessage = 'Не вдалося виконати операцію. Спробуйте ще раз';
        break;
    }

    return displayMessage;
  }
}