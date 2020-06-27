enum Permission { Admin, Public }

class Routes {
  final String publicURL = "http://10.0.2.2:8080/";
  final String adminURL = "http://10.0.2.2:8081/";

  String baseRoute(Permission permission, String id) {
    switch (permission) {
      case Permission.Admin:
        return "$adminURL$id";
        break;
      case Permission.Public:
        return "$publicURL$id";
        break;
      default:
        return "";
    }
  }
}
