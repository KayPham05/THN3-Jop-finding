import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String? profilePhoto;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    this.profilePhoto,
  });

  @override
  List<Object?> get props => [id, email, fullName, profilePhoto];
}
