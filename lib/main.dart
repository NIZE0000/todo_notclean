import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_notclean/pages/home_page.dart';
import 'package:todo_notclean/providers/todo_provider.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TodoProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Todos APP',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              useMaterial3: true,
              primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.black87,
              )),
          home: Home(),
        ));
  }
}
