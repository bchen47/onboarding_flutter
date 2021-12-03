import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/blocs/profile/profile_bloc.dart';
import 'package:prueba/blocs/user/user_bloc.dart';
import 'package:prueba/screens/explore/explore_page.dart';
import 'package:prueba/blocs/home/home_bloc.dart';
import 'package:prueba/repository/profile_repository.dart';
import 'package:prueba/screens/profile/profile_page.dart';
import 'package:prueba/blocs/authentication/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static final List<Widget> _widgetOptions = <Widget>[
    ExploreTab(),
    const Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    const Text(
      'Index 2: School',
      style: optionStyle,
    ),
    const Text(
      'Index 3: School',
      style: optionStyle,
    ),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProfileBloc>(
            create: (_) => ProfileBloc(
              profileRepository: ProfileRepository(),
            ),
          ),
        ],
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          BlocProvider.of<UserBloc>(context);
          context.read<UserBloc>().add(UserLogedIn(state.token.accessToken));
          context.read<ProfileBloc>().add(GetProfile(
              context.read<AuthenticationBloc>().state.token.accessToken));

          return Scaffold(body: home());
        }));

    // );
  }

  /// Get the asset icon for the given tab
  String _getAssetForTab(_Tab tab, int index) {
    // check if the given tab parameter is the current active tab
    final active = tab != _Tab.values[index];

    // now given the tab param get its icon considering the fact that if it is active or not
    if (tab == _Tab.tab1) {
      return active
          ? 'assets/navigation/IconSearch-OFF@3x.png'
          : 'assets/navigation/IconSearch-ON@3x.png';
    } else if (tab == _Tab.tab2) {
      return active
          ? 'assets/navigation/IconNutricion-OFF@3x.png'
          : 'assets/navigation/IconNutricion-ON@3x.png';
    } else if (tab == _Tab.tab3) {
      return active
          ? 'assets/navigation/IconSensei-OFF@3x.png'
          : 'assets/navigation/IconSensei-ON@3x.png';
    } else if (tab == _Tab.tab4) {
      return active
          ? 'assets/navigation/IconSensei-OFF@3x.png'
          : 'assets/navigation/IconSensei-ON@3x.png';
    }
    return active
        ? 'assets/navigation/IconPerfil-OFF@3x.png'
        : 'assets/navigation/IconPerfil-ON@3x.png';
  }

  Widget home() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(state.index),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(_getAssetForTab(_Tab.tab1, state.index),
                    width: 24.0, height: 24.0),
                label: 'Explorar',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(_getAssetForTab(_Tab.tab2, state.index),
                    width: 24.0, height: 24.0),
                label: 'Nutrición',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(_getAssetForTab(_Tab.tab3, state.index),
                    width: 24.0, height: 24.0),
                label: 'Sensei',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(_getAssetForTab(_Tab.tab4, state.index),
                    width: 24.0, height: 24.0),
                label: 'Social',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(_getAssetForTab(_Tab.tab5, state.index),
                    width: 24.0, height: 24.0),
                label: 'Perfil',
              ),
            ],
            currentIndex: state.index,
            selectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey[850],
            unselectedItemColor: Colors.grey[400],
            onTap: (item) {
              context.read<HomeBloc>().add(HomeIndexChanged(item));
            },
          ));
    });
  }
}

enum _Tab { tab1, tab2, tab3, tab4, tab5 }
