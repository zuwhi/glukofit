import 'package:appwrite/appwrite.dart';
import 'package:glukofit/constants/appwrite.dart';


class AppwriteClientHelper {
  static final Client _appwriteClient = Client()
      .setEndpoint(AppwriteConstants.endpoint)
      .setProject(AppwriteConstants.projectId)
      .setSelfSigned(status: true);
  AppwriteClientHelper._();

  static final instance = AppwriteClientHelper._();

  Client get appwriteClient => _appwriteClient;
}
