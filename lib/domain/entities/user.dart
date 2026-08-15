
class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String role;
  final String? onboardingStep;
  final String? status;
  final String? defaultBranchId;
  final String? defaultBranchName;
  final String? defaultBusinessId;
  final String? defaultBusinessName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.role = 'user',
    this.onboardingStep,
    this.status,
    this.defaultBranchId,
    this.defaultBranchName,
    this.defaultBusinessId,
    this.defaultBusinessName,
  });

  String get fullName => '$firstName $lastName';

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    String? onboardingStep,
    String? status,
    String? defaultBranchId,
    String? defaultBranchName,
    String? defaultBusinessId,
    String? defaultBusinessName,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      onboardingStep: onboardingStep ?? this.onboardingStep,
      status: status ?? this.status,
      defaultBranchId: defaultBranchId ?? this.defaultBranchId,
      defaultBranchName: defaultBranchName ?? this.defaultBranchName,
      defaultBusinessId: defaultBusinessId ?? this.defaultBusinessId,
      defaultBusinessName: defaultBusinessName ?? this.defaultBusinessName,
    );
  }
}