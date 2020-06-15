import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';

class DatabaseManager{
  var db;

  Future<List<Map>> initializeDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "p30.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      //print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "p30.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      //print("Opening existing database");
    }
// open the database
    db = await openDatabase(path, readOnly: true);

    List<Map> result = await db.rawQuery('SELECT * FROM Sheet1');
    return result;
  }
}