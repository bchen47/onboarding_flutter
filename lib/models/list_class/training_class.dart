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
  final List<Map<String, dynamic>> attributes;
  final Map<String, dynamic> trainers;
  const TrainingClass(this.attributes, this.trainers);
  @override
  List<Object?> get props => [attributes, trainers];

  static const empty = TrainingClass([], {});
}