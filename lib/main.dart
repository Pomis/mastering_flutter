import 'package:flutter/material.dart';
import 'package:mastering_flutter/common/list_item.dart';
import 'package:mastering_flutter/common/navigation_items.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        scaffoldBackgroundColor: Colors.white,

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 242, 244, 247),
        ),
        
        // InkWell styling
        splashColor: Colors.amberAccent.withValues(alpha: 0.2),
        hoverColor: Colors.purpleAccent.withValues(alpha: 0.1),
        highlightColor: Colors.redAccent.withValues(alpha: 0.1),
        checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateColor.fromMap({
            WidgetState.hovered: Colors.white.withValues(alpha: 0.8),
            WidgetState.disabled: Colors.grey,
            WidgetState.any: Colors.white,
          }),
          fillColor: WidgetStateProperty.fromMap({
            WidgetState.hovered & WidgetState.selected: Colors.red,
            WidgetState.hovered | WidgetState.disabled: Colors.grey.withValues(alpha: 0.1),
            WidgetState.selected: Colors.blue,
            WidgetState.any: Colors.white,
          }),
          overlayColor: WidgetStateColor.fromMap({
            WidgetState.selected: Colors.red.withValues(alpha: 0.1),
            WidgetState.any: Colors.grey.withValues(alpha: 0.1),
          }),
        ),
        // listTileTheme: ListTileThemeData(
        //   textColor: WidgetStateColor.fromMap({
        //     WidgetState.disabled: Colors.pinkAccent,
        //     WidgetState.any: Colors.blue,
        //   }),
        //   iconColor: WidgetStateColor.fromMap({
        //     WidgetState.disabled: Colors.pinkAccent,
        //     WidgetState.any: Colors.blue,
        //   }),
        // ),
        cardTheme: CardTheme(color: Color.fromARGB(255, 242, 244, 247)),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mastering Flutter')),
      body: ListView.builder(
        itemCount: navigationItems.length,
        itemBuilder: (context, index) {
          return ListItem(
            title: navigationItems[index].title,
            subtitle: navigationItems[index].subtitle,
            onTap: () {
              navigationItems[index].navigate(context);
            },
          );
        },
      ),
    );
  }
}
