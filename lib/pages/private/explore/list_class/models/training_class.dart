import 'package:equatable/equatable.dart';

class TrainingClass extends Equatable {
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
  final Map<String, dynamic> attributes;

  const TrainingClass(this.attributes);
  @override
  List<Object?> get props => [attributes];

  static const empty = TrainingClass({});
}
