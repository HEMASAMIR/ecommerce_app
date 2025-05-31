class ApiEndpoints {
  static const String baseUrl = "https://fakestoreapi.com";
  static const String login = '/auth/login';
  static const String register = "/users";
  static const String products = '/products';
  static const String carts = '/carts';
  static const String categories = '/products/categories';
  static const String catProducts = '/category';
  static String productByCategory(String categoryName) =>
      '/products/category/$categoryName';
}
// https://fakestoreapi.com/auth/login
