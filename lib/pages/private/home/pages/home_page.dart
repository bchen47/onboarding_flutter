import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/pages/private/home/bloc/home_bloc.dart';
import 'package:prueba/pages/private/profile/pages/profile_page.dart';
import 'package:prueba/src/bloc/authentication_bloc.dart';
import 'package:prueba/src/bloc/authentication_repository.dart';
import 'package:prueba/src/bloc/user_bloc.dart';
import 'package:prueba/src/bloc/user_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: School',
      style: optionStyle,
    ),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
          userRepository: RepositoryProvider.of<UserRepository>(context),
        );
      },
      child: BlocProvider(
          create: (_) => UserBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context)),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            context.read<UserBloc>();
            context
                .read<AuthenticationBloc>()
                .add(LogIn(state.token.accessToken));

            return Scaffold(body: home());
          })),
    );
  }

  /// Get the asset icon for the given tab
  String _getAssetForTab(_Tab tab, int index) {
    // check if the given tab parameter is the current active tab
    final active = tab != _Tab.values[index];

    // now given the tab param get its icon considering the fact that if it is active or not
    if (tab == _Tab.TAB1) {
      return active
          ? 'assets/navigation/IconSearch-OFF@3x.png'
          : 'assets/navigation/IconSearch-ON@3x.png';
    } else if (tab == _Tab.TAB2) {
      return active
          ? 'assets/navigation/IconNutricion-OFF@3x.png'
          : 'assets/navigation/IconNutricion-ON@3x.png';
    } else if (tab == _Tab.TAB3) {
      return active
          ? 'assets/navigation/IconSensei-OFF@3x.png'
          : 'assets/navigation/IconSensei-ON@3x.png';
    } else if (tab == _Tab.TAB4) {
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
                icon: Image.asset(_getAssetForTab(_Tab.TAB1, state.index),
                    width: 24.0, height: 24.0),
                label: 'Explorar',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(_getAssetForTab(_Tab.TAB2, state.index),
                    width: 24.0, height: 24.0),
                label: 'Nutrición',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(_getAssetForTab(_Tab.TAB3, state.index),
                    width: 24.0, height: 24.0),
                label: 'Sensei',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(_getAssetForTab(_Tab.TAB4, state.index),
                    width: 24.0, height: 24.0),
                label: 'Social',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(_getAssetForTab(_Tab.TAB5, state.index),
                    width: 24.0, height: 24.0),
                label: 'Perfil',
              ),
            ],
            currentIndex: state.index,
            selectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey[800],
            onTap: (item) {
              context.read<HomeBloc>().add(HomeIndexChanged(item));
            },
          ));
    });
  }
}

enum _Tab { TAB1, TAB2, TAB3, TAB4, TAB5 }
