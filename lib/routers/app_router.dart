
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../businesslogic/cubit/characters_cubit.dart';
import '../constants/string.dart';
import '../data/repository/characters_repository.dart';
import '../data/web_services/api.dart';
import '../presentation/screens/character_screen.dart';
import '../presentation/screens/characters_details.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(Api());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharacterScreen(),
          ),
        );
      case charactersDetailsScreen:
        return MaterialPageRoute(builder: (context) => CharactersDetails());
    }
    return null;
  }
}
