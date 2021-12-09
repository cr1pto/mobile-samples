import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../models/password.dart';

class SembastDb {
  DatabaseFactory dbFactory = databaseFactoryIo;
  late Database _db;
  final store = intMapStoreFactory.store('passwords');
  static SembastDb _singleton = SembastDb._internal();

  SembastDb._internal() {}

  factory SembastDb() {
    return _singleton;
  }

  Future<Database> init() async {
    if(_db == null){
      _db = await _openDb();
    }
    return _db;
  }

  Future _openDb() async {
    final docsDir = await getApplicationDocumentsDirectory(); //pathprovider
    final dbPath = join(docsDir.path, 'pass.db'); //path.dart
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }

  Future<int> addPassword(Password password) async {
    int id = await store.add(_db, password.toMap());
    return id;
  }
}