import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'screens/screen01.dart';
import 'screens/screen02.dart';
import 'screens/screen03.dart';
import 'screens/screen04.dart';
import 'screens/screen05.dart';
import 'screens/screen06.dart';
import 'screens/screen07.dart';
import 'screens/screen08.dart';
import 'screens/screen09.dart';
import 'screens/screen10.dart';
import 'screens/screen11.dart';

void main() {
  runApp(const ProviderScope(child: BookLoopApp()));
}

class BookLoopApp extends ConsumerWidget {
  const BookLoopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (c, s) => Screen01()),
        GoRoute(path: '/screen02', builder: (c, s) => Screen02()),
        GoRoute(path: '/screen03', builder: (c, s) => Screen03()),
        GoRoute(path: '/screen04', builder: (c, s) => Screen04()),
        GoRoute(path: '/screen05', builder: (c, s) => Screen05()),
        GoRoute(path: '/screen06', builder: (c, s) => Screen06()),
        GoRoute(path: '/screen07', builder: (c, s) => Screen07()),
        GoRoute(path: '/screen08', builder: (c, s) => Screen08()),
        GoRoute(path: '/screen09', builder: (c, s) => Screen09()),
        GoRoute(path: '/screen10', builder: (c, s) => Screen10()),
        GoRoute(path: '/screen11', builder: (c, s) => Screen11()),
      ],
    );

    return MaterialApp.router(
      title: 'BookLoop Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: _router,
    );
  }
}
