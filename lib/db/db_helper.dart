// Database Helper Class
// Author: Chris Kneller
// Date: March 2022
// Version: 1

import 'dart:io' as io;
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../utility/success.dart';
import '../providers/cards.dart';
import 'package:sqflite/sqflite.dart';
import 'package:either_dart/either.dart';
import '../utility/failure.dart';

/// Provides Functionality to:
///
/// - Initialise the local database.
/// - Open a connection to the local database.
/// - Retrieve, Save, Delete items from local database.
class DBHelper {
  static const String truthTableName = 'TRUTH';
  static const String truthTextColumn = 'TEXTCONTENT';
  static const String truthPlayerGenColumn = 'PLAYERGEN';

  static const String dareTableName = 'DARE';
  static const String dareTextColumn = 'TEXTCONTENT';
  static const String darePlayerGenColumn = 'PLAYERGEN';

  // Creates a database variable.
  Database? _db;

  Future<Database?> get db async {
    _db = await initDB();
    return _db;
  }

  /// Async method to initiate the local database.
  Future<Database> initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "tomdata.db");

    // Checks if db exists in the correct directory
    bool dbExists = await io.File(path).exists();

    if (!dbExists) {
      // Translates asset database into byte data.
      ByteData data = await rootBundle.load(join("assets/data", "tomdata.db"));

      // Creates a list of integers from the byte data.
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Writes the new file from these bytes.
      await io.File(path).writeAsBytes(bytes, flush: true);
    }
    var theDb = await openDatabase(path, version: 1);

    // Returns open database.
    return theDb;
  }

  /// Async method to get Truths and Dares from database.
  ///
  /// Either type returns either a [Failure] object if connection fails
  /// or a [Map] of data if successfull.
  static Future<Either<Failure, Map<String, List<dynamic>>>>
      getAppData() async {
    // Creates instance of database class
    DBHelper dbHelper = DBHelper();

    // Awaits connection to database.
    var dbClient = await dbHelper.db;

    // Stores truth and dare data to be output.
    Map<String, List> appData = {};

    try {
      // Queries database for Truths and dares.
      List<Map> truthList = await dbClient!.rawQuery('SELECT * FROM TRUTH');
      List<Map> dareList = await dbClient.rawQuery('SELECT * FROM DARE');

      appData['truthList'] = truthList;
      appData['dareList'] = dareList;

      dbClient.close();

      // Returns retrieved app data.
      return Right(appData);
    } on DatabaseException {
      // returns instance of Failure object if there is an error.
      dbClient?.close();
      return Left(
          Failure("Error connecting to database, try re-installing the app"));
    }
  }

  /// Provides functionality to save either a Truth or a Dare to database.
  ///
  /// Accepts [text] content to save to DB and [cardElement] to determine if
  /// element is a [Truth] or a [Dare].
  static Future<Either<Failure, Map<String, dynamic>>> saveToDatabase(
      String text, CardElement cardElement) async {
    bool isTruth = cardElement == CardElement.truth;

    // Sets up the correct columns/tables based on whether Truth or Dare.
    String table = isTruth ? truthTableName : dareTableName;
    String textColumn = isTruth ? truthTextColumn : dareTextColumn;
    String playerGen = isTruth ? truthPlayerGenColumn : darePlayerGenColumn;

    // Creates instance of database, and opens it.
    DBHelper dbHelper = DBHelper();
    var dbClient = await dbHelper.db;

    try {
      // Both inserts a row into the database, but also retrieves an ID.
      int id = await dbClient!.insert(table, {
        textColumn: text,
        playerGen: 1,
      });

      // Closes database.
      dbClient.close();

      // Returns a map, with both an Id for the element and success instance.
      return Right(
        {'id': id, 'success': Success(cardElement.name + " sucessfully saved")},
      );
    } on DatabaseException {
      dbClient?.close();

      // Returns Failure instance.
      return Left(
        Failure("Error saving " + cardElement.name + " to database"),
      );
    }
  }

  /// Method to remove either a Truth or Dare from the database.
  ///
  /// Accepts [id] to determine which element to delete and a
  /// [cardElement] to determine if element is a [Truth] or a [Dare].
  static Future<Either<Failure, Success>> deleteFromDatabase(
      int id, CardElement cardElement) async {
    bool isTruth = cardElement == CardElement.truth;

    // Sets table name based on if element is a Truth or Dare.
    String table = isTruth ? truthTableName : dareTableName;
    
    // Creates instance of database and opens it.
    DBHelper dbHelper = DBHelper();
    var dbClient = await dbHelper.db;

    try {
      // Deletes row based on id passed as an argument.
      await dbClient?.delete(table, where: "id = ?", whereArgs: [id]);

      // Returns a Success instance if succesfull.
      dbClient?.close();
      return Right(
        Success(cardElement.name + " successfully deleted"),
      );
    } on DatabaseException {
      dbClient?.close();
      return Left(
        // Returns a Failure if unsuccesfull.
        Failure("Error deleting " + cardElement.name + " from database"),
      );
    }
  }
}
