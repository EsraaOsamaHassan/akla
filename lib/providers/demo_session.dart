class DemoSession {
  static String displayName = 'User';
  static String email = '';

  static void setUser({required String name, required String userEmail}) {
    displayName = name;
    email = userEmail;
  }

  static void clear() {
    displayName = 'User';
    email = '';
  }
}
