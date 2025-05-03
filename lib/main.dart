
import 'package:charcter/routers/app_router.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(Home(
    appRouter: AppRouter(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    // home:CharactersScreen(),
     //initialRoute: charactersScreen,
    );
  }
}

