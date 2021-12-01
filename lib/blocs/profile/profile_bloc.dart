import 'dart:async';

import 'package:prueba/providers/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba/models/profile/profile.dart';
part 'profile_events.dart';
part 'profile_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(const ProfileState._()) {
    on<ProfileChanged>(_onLoadProfile);

    _profileLoadedSuscription = profileRepository.status.listen(
      (status) => {add(ProfileChanged(status.attributes))},
    );
  }

  final ProfileRepository _profileRepository;
  late StreamSubscription<Profile> _profileLoadedSuscription;

  @override
  Future<void> close() {
    _profileLoadedSuscription.cancel();
    _profileRepository.dispose();
    return super.close();
  }

  void _onLoadProfile(
    ProfileChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(profile: Profile(event.attributes)));
  }
}
