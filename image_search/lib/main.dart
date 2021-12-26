import 'package:flutter/material.dart';
import 'package:image_search/screen/home/home_screen.dart';
import 'package:image_search/screen/home/home_view_model.dart';
import 'package:provider/provider.dart';

import 'data/pixabay_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => HomeViewModel(repository: PixabayApi()),
        child: const HomeScreen(),
      ),
    );
  }
}
