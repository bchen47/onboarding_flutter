import 'package:equatable/equatable.dart';

class User extends Equatable {
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

  const User(this.attributes);
  @override
  List<Object?> get props => [attributes];
  // final String? fullName;
  // final String? avatarUrl;
  // final String? updatedAt;
  // final String? login;
  // final String? inviteCode;
  // final String? birthday;
  // final String? sex;
  // final Map<String, dynamic>? currentMembership;
  // final Map<String, dynamic>? affiliationData;
  // final String? updatedAtTimestamp;
  // final String? createdAt;
  // final bool? userTrialPeriod;

  // @override
  // List<Object?> get props => [
  //       fullName,
  //       avatarUrl,
  //       updatedAt,
  //       login,
  //       inviteCode,
  //       birthday,
  //       sex,
  //       currentMembership,
  //       affiliationData,
  //       updatedAtTimestamp,
  //       createdAt,
  //       userTrialPeriod
  //     ];
  // static User parseUser(Map<String, Object?> attributes) {
  //   var currentMemberShip =
  //       json.decode(attributes['current_membership'].toString());
  //   var affiliationData =
  //       json.decode(attributes['affiliation_data'].toString());
  //   return User(
  //       attributes['full_name'].toString(),
  //       attributes['avatar_url'].toString(),
  //       attributes['updated_at'].toString(),
  //       attributes['login'].toString(),
  //       attributes['invite_code'].toString(),
  //       attributes['birthday'].toString(),
  //       attributes['sex'].toString(),
  //       {
  //         "current_membership": {
  //           "plan": currentMemberShip["plan"],
  //           "member_until": currentMemberShip["plan"]["member_until"],
  //           "last_payment_method": currentMemberShip["plan"]
  //               ["last_payment_method"]
  //         }
  //       },
  //       {
  //         "affiliation_data": {
  //           "member_from": affiliationData["member_from"],
  //           "member_from_normalized": affiliationData["member_from_normalized"],
  //           "level": affiliationData["level"],
  //           "level_name": affiliationData["level_name"],
  //           "points": affiliationData["points"],
  //           "total_referred_count": affiliationData["total_referred_count"],
  //           "active_referred_count": affiliationData["active_referred_count"],
  //           "free_months": affiliationData["free_months"],
  //         }
  //       },
  //       attributes['updated_at_timestamp'].toString(),
  //       attributes['created_at'].toString(),
  //       attributes['user_trial_period'].toString() == "true");
  // }

  static const empty = User({});
}
