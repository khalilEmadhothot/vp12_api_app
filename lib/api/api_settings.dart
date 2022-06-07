class ApiSettings {

  static const String _baseUrl = 'http://demo-api.mr-dev.tech/';
  static const String _baseApiUrl = _baseUrl + 'api/';
  static const String imageUrl = _baseUrl + 'images/';

  static const String readUsers = _baseApiUrl + 'users';
  static const String login = _baseApiUrl + 'students/auth/login';
  static const String logout = _baseApiUrl + 'students/auth/logout';
  static const String register = _baseApiUrl + 'students/auth/register';
  static const String forgetPassword = _baseApiUrl + 'students/auth/forget-password';
  static const String resetPassword = _baseApiUrl + 'students/auth/reset-password';
  static const String images = _baseApiUrl + 'student/images/{id}';
}