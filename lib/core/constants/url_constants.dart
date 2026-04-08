class UrlConstants {
  UrlConstants._();

  static const String baseUrl = 'https://sunshelter-api.testmywebsite.in/api/admin/';

  static const String authLogin = 'auth/login';
  static const String authRegister = 'auth/register';

  static const String users = 'users';
  static const String familyTree = 'family-tree';
  static const String events = 'events';
  static const String suggestions = 'suggestions';
  static const String files = 'files';
  static const String videos = 'videos';

  static String withBase(String path) => '$baseUrl$path';
}
