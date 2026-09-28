import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'core/theme/app_theme.dart';
import 'home/welcome_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  databaseFactory = databaseFactoryFfiWeb;

  runApp(
    const KuendaClean(),
  );
}

class KuendaClean extends StatelessWidget {
  const KuendaClean({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kuenda Clean',
      theme: AppTheme.light,
      home: const WelcomePage(),
    );
  }
}