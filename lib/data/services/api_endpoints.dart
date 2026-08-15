class ApiEndpoint {
  static const String baseUrl = 'https://test.api.hesabupos.co.ke/api/v1';
  
  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';
  static const String google = '$baseUrl/auth/google';
  static const String logout = '$baseUrl/auth/logout';
  static const String verifications = '$baseUrl/auth/verifications';
  static const String verificationsCheck = '$baseUrl/auth/verifications-check';
  static const String refresh = '$baseUrl/auth/refresh';
  static const String profile = '$baseUrl/auth/profile';
  static const String password = '$baseUrl/auth/password';
  static const String passwordResetRequest = '$baseUrl/auth/password-reset/request';
  static const String passwordResetVerify = '$baseUrl/auth/password-reset/verify';
  static const String passwordReset = '$baseUrl/auth/password-reset';
  static const String onboardingStep = '$baseUrl/auth/onboarding-step';
  
  static const String businesses = '$baseUrl/businesses';
  static const String businessesMe = '$baseUrl/businesses/me';
  static const String businessesSwitch = '$baseUrl/businesses/switch';
  static const String businessesCurrent = '$baseUrl/businesses/current';
  
  static const String branches = '$baseUrl/branches';
  static const String branchesSwitch = '$baseUrl/branches/switch';
  static const String branchesCurrent = '$baseUrl/branches/current';
  
  static const String transactions = '$baseUrl/transactions';
  
  static const String categories = '$baseUrl/categories';
  
  static const String products = '$baseUrl/products';
  static const String productsSearch = '$baseUrl/products/search';
  
  static const String report = '$baseUrl/report';
  static const String reportCategories = '$baseUrl/report/categories';
  
  static const String sales = '$baseUrl/sales';
  
  static const String inventory = '$baseUrl/inventory';
  
  static const String industry = '$baseUrl/industry';
}