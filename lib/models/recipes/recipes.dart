import 'package:equatable/equatable.dart';

class Recipes extends Equatable {
  // const User(
  //     this.fullName,
  //     this.avatarUrl,
  //     this.updatedAt,
  //     this.login,
  //     this.inviteCode,
  //     this.birthday,
  //     this.sex,
  //     this.currentMembership,
  //     this.affiliationData,
  //     this.updatedAtTimestamp,
  //     this.createdAt,
  //     this.userTrialPeriod);
  final List<Map<String, dynamic>> attributes;
  const Recipes(this.attributes);
  @override
  List<Object?> get props => [attributes];

  static const empty = Recipes([]);
}
