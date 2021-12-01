import 'dart:async';
import 'package:prueba/models/list_class/training_class.dart';
import 'package:prueba/models/profile/profile.dart';
import 'package:prueba/models/recipe/recipe.dart';
import 'package:prueba/models/recipes/recipes.dart';
import 'package:prueba/providers/profile_repository.dart';
import 'package:prueba/providers/recipe_repository.dart';
import 'package:prueba/providers/recipes_repository.dart';
import 'package:prueba/providers/training_class_list_repository.dart';
import 'package:prueba/providers/training_class_repository.dart';
import 'package:prueba/providers/user_repository.dart';
import 'package:prueba/models/user.dart';
import 'package:prueba/models/training_class/class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:prueba/models/token.dart';
import 'package:equatable/equatable.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
    required ProfileRepository profileRepository,
    required TrainingClassRepository trainingClassRepository,
    required RecipesRepository recipesRepository,
    required ClassRepository classRepository,
    required RecipeRepository recipeRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _profileRepository = profileRepository,
        _trainingClassRepository = trainingClassRepository,
        _recipesRepository = recipesRepository,
        _classRepository = classRepository,
        _recipeRepository = recipeRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationCheckAuthenticated>(_checkAuthenticated);

    on<LogIn>(_tryGetUser);
    on<GetProfile>(_tryGetProfile);
    on<GetTrainingClasses>(_tryGetTrainingClasses);
    on<GetRecipes>(_tryGetRecipes);
    on<GetTrainingClass>(_tryGetTrainingClass);
    on<GetRecipe>(_tryGetRecipe);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => {add(AuthenticationStatusChanged(status))},
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final ProfileRepository _profileRepository;
  final TrainingClassRepository _trainingClassRepository;
  final RecipesRepository _recipesRepository;
  final ClassRepository _classRepository;
  final RecipeRepository _recipeRepository;

  late StreamSubscription<AuthenticationStatusLogin>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("access_token", event.status.token.accessToken);
        prefs.setString("refresh_token", event.status.token.refreshToken);
        prefs.setString("expires_in", event.status.token.expiresIn);
        prefs.setString("token_type", event.status.token.tokenType);
        _userRepository.getUser(event.status.token.accessToken);
        return emit(AuthenticationState.authenticated(event.status.token));
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _userRepository.logOut();
    SharedPreferences.getInstance()
        .then((SharedPreferences value) => value.clear());
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser(
      LogIn event, Emitter<AuthenticationState> emit) async {
    try {
      final user = _userRepository.getUser(event.token);
      return user;
    } catch (_) {
      return null;
    }
  }

  Future<Profile?> _tryGetProfile(
      GetProfile event, Emitter<AuthenticationState> emit) async {
    try {
      final profile = _profileRepository.getProfile(event.token);
      return profile;
    } catch (_) {
      return null;
    }
  }

  Future<TrainingClass?> _tryGetTrainingClasses(
      GetTrainingClasses event, Emitter<AuthenticationState> emit) async {
    try {
      final trainingClasses =
          _trainingClassRepository.getClass(event.token, event.category);
      return trainingClasses;
    } catch (_) {
      return null;
    }
  }

  Future<Recipes?> _tryGetRecipes(
      GetRecipes event, Emitter<AuthenticationState> emit) async {
    try {
      final recipes =
          _recipesRepository.getRecipes(event.token, event.category);
      return recipes;
    } catch (_) {
      return null;
    }
  }

  Future<Recipe?> _tryGetRecipe(
      GetRecipe event, Emitter<AuthenticationState> emit) async {
    try {
      final recipe = _recipeRepository.getRecipe(event.token, event.id);
      return recipe;
    } catch (_) {
      return null;
    }
  }

  Future<Class?> _tryGetTrainingClass(
      GetTrainingClass event, Emitter<AuthenticationState> emit) async {
    try {
      final trainingClass =
          _classRepository.getTrainingClass(event.token, event.id);
      return trainingClass;
    } catch (_) {
      return null;
    }
  }

  void _checkAuthenticated(
    AuthenticationCheckAuthenticated event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.checkAutenticated();
  }
}
