import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movizone/features/Search/bloc/search_bloc.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/home/data/model/movie_details_model.dart';
import 'features/home/pages/home_screen.dart';
import 'features/main/pages/mainscreen.dart';
import 'features/onboarding/page/splash_screen.dart';
import 'features/witshlist/bloc/wishlist_bloc.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MovieDetailsResponseModelAdapter());
  Hive.registerAdapter(GenreAdapter());
  await Hive.openBox<MovieDetailsResponseModel>('wishlist');

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => HomeBloc(),
      ),
      BlocProvider(
        create: (context) => WishlistBloc(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color(0xff242A32),
            selectedLabelStyle: TextStyle(
              color: Color(0xff12CDD9),
            ),
            selectedItemColor: Color(0xff12cdd9),
            unselectedItemColor: Colors.grey,
            unselectedLabelStyle: TextStyle(color: Colors.grey)),
        scaffoldBackgroundColor: Color(0xff1F1D2B),
        appBarTheme: AppBarTheme(
            backgroundColor: Color(0xff1F1D2B), foregroundColor: Colors.white),
      ),
      home: SplahScreen(),
    );
  }
}
