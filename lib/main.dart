import 'package:flutter/material.dart';
import 'package:netflix_clone/providers/account.dart';
import 'package:netflix_clone/providers/entry.dart';
import 'package:netflix_clone/providers/watchlist.dart';
import 'package:netflix_clone/screens/navigation.dart';
import 'package:netflix_clone/screens/onBoardingScreen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AccountProvider()),
      ChangeNotifierProvider(create: (context) => EntryProvider()),
      ChangeNotifierProvider(create: (context) => WatchListProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: context.read<AccountProvider>().isValid(),
        builder: (context, snapshot) =>
            context.watch<AccountProvider>().session == null
                ? const OnboardingScreen()
                : const NavScreen(),
      ),
    );
  }
}
