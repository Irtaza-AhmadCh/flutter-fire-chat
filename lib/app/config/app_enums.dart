enum UserRole { BARNOWNER, WORKER }

extension UserRoleExtension on String? {
  UserRole toUserRole() {
    switch (this?.toLowerCase()) { // Use toLowerCase for consistent matching
      case 'barn':
        return UserRole.BARNOWNER;
      case 'worker':
        return UserRole.WORKER;
      default:
        throw ArgumentError('Invalid user role: $this');
    }
  }
}