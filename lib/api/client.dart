import 'package:appwrite/appwrite.dart';

import '../utils/api.dart';

class ApiClient {
  Client get _client {

    Client client = Client()
      .setEndpoint(ApiInfo.url)
      .setProject(ApiInfo.projectId)
      .setSelfSigned(status: true);

    return client;
  }

  static Account get account => Account(_instance._client);
  static Storage get storage => Storage(_instance._client);
  static Databases get databases => Databases(_instance._client);
  static Realtime get realtime => Realtime(_instance._client);

  static final ApiClient _instance = ApiClient._internal();
  ApiClient._internal();
  factory ApiClient() => _instance;
}