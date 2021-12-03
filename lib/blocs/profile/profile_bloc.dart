import 'dart:async';

import 'package:prueba/repository/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba/models/profile.dart';
part 'profile_events.dart';
part 'profile_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(const ProfileState._()) {
    on<ProfileChanged>(_onLoadProfile);
    on<GetProfile>(_tryGetProfile);

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

  void _tryGetProfile(GetProfile event, Emitter<ProfileState> emit) async {
    try {
      final profile = _profileRepository.getProfile(event.token);
      profile.then(
          (value) => emit(state.copyWith(profile: Profile(value!.attributes))));
    } catch (_) {
      return null;
    }
  }
}
