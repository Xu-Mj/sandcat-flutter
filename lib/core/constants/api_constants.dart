/// API related constants
class ApiConstants {
  // Base URLs
  static const String baseUrl = 'http://localhost:3000/api';

  // Auth endpoints
  static const String sendEmailEndpoint = '/send_email';
  static const String userEndpoint = '/user';
  static const String loginEndpoint = '/login';
  static const String refreshTokenEndpoint = '/refresh_token';

  // Chat endpoints
  static const String messagesEndpoint = '/messages';
  static const String chatsEndpoint = '/chats';

  // Group endpoints
  static const String groupsEndpoint = '/groups';

  // Media endpoints
  static const String uploadEndpoint = '/upload';
  static const String mediaEndpoint = '/media';

  // Do not instantiate
  ApiConstants._();
}
