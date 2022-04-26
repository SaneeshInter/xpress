import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xpresshealthdev/model/visa_type_list.dart';

import '../dbmodel/allowance_category_model.dart';
import '../dbmodel/allowance_mode.dart';
import '../model/country_list.dart';
import '../model/gender_list.dart';
import '../model/loctions_list.dart';
import '../model/schedule_categegory_list.dart';
import '../model/schedule_hospital_list.dart';
import '../model/user_type_list.dart';

class Db {
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join('xprsa_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      db.execute(
        'CREATE TABLE gender(row_id INTEGER , gender TEXT)',
      );

      db.execute(
        'CREATE TABLE locations(row_id INTEGER , location TEXT)',
      );

      db.execute(
        'CREATE TABLE usertype(row_id INTEGER , type TEXT)',
      );

      db.execute(
        'CREATE TABLE visatype(row_id INTEGER , type TEXT)',
      );

      db.execute(
        'CREATE TABLE allowancecategroy(row_id INTEGER , category TEXT)',
      );

      db.execute(
        'CREATE TABLE allowance(row_id INTEGER , category TEXT, allowance TEXT, amount TEXT, max_amount TEXT, comment TEXT)',
      );

      db.execute(
        'CREATE TABLE schedulecategorylist(row_id INTEGER , user_type INTEGER , category TEXT)',
      );

      db.execute(
        'CREATE TABLE  hospitals(row_id INTEGER , name TEXT,email TEXT,phone TEXT,address TEXT,province INTEGER,city INTEGER ,longitude TEXT ,latitude TEXT'
        ', photo TEXT)',
      );

      return db.execute(
        'CREATE TABLE country(row_id INTEGER , country_name TEXT)',
      );
    },

    version: 1,
  );

  //HOSPITAL
  Future<void> insertAllowanceList(AllowanceList dog) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      'allowance',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<AllowanceList>> getAllowanceList(int type) async {
    final db = await database;
    // Query the table for all The Dogs.
    List<AllowanceList> allocaions = [];
    final List<Map<String, dynamic>> maps = await db.query('allowance');

    List.generate(maps.length, (i) {
      print("type");
      print(type);
      print(maps[i]['category']);

      var categro = maps[i]['category'].toString();
      print("categro");
      int intcate = int.parse(categro);

      if (intcate == type) {
        var item = AllowanceList(
            rowId: maps[i]['row_id'],
            category: intcate,
            allowance: maps[i]['allowance'],
            amount: int.parse(maps[i]['amount'].toString()),
            maxAmount: int.parse(maps[i]['max_amount'].toString()),
            comment: maps[i]['comment']);
        allocaions.add(item);
      }
    });
    return allocaions;
  }

  // Future<List<AllowanceCategoryList>> getAllowanceCategory() async {
  //   final db = await database;
  //   // Query the table for all The Dogs.
  //
  //   final List<Map<String, dynamic>> maps = await db.query('allowancecategroy');
  //
  //   return List.generate(maps.length, (i) {
  //     return AllowanceCategoryList(
  //       rowId: maps[i]['row_id'],
  //       category: maps[i]['category'],
  //     );
  //   });
  // }

  Future<List<AllowanceCategoryList>> getAllowanceCategoryList() async {
    final db = await database;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('allowancecategroy');
    print("maps");
    print(maps.length);
    return List.generate(maps.length, (i) {
      print("maps[i]['category']");
      print(maps[i]['category']);
      return AllowanceCategoryList(
        rowId: maps[i]['row_id'],
        category: maps[i]['category'],
      );
    });
  }

  //HOSPITAL
  Future<void> insertAllowanceCategoryList(AllowanceCategoryList dog) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflict algorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'allowancecategroy',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //HOSPITAL
  Future<void> inserthospitalList(HospitalList dog) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflict algorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'hospitals',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Define a function that inserts dogs into the database
  Future<void> insertCountryList(CountryList dog) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflict algorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'country',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Define a function that inserts dogs into the database
  Future<void> insertCategegoryList(ScheduleCategoryList dog) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflict algorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'schedulecategorylist',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Define a function that inserts dogs into the database
  Future<void> insertGenderList(GenderList dog) async {
    // Get a reference to the database.
    final db = await database;
    // Insert the Dog into the correct table. You might also specify the
    // `conflict algorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'gender',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<GenderList>> getGenderList() async {
    final db = await database;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('gender');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return GenderList(rowId: maps[i]['row_id'], gender: maps[i]['gender']);
    });
  }

  Future<List<ScheduleCategoryList>> getCategory() async {
    final db = await database;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps =
        await db.query('schedulecategorylist');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return ScheduleCategoryList(
          rowId: maps[i]['row_id'],
          category: maps[i]['category'],
          userType: maps[i]['user_type']);
    });
  }

  Future<List<HospitalList>> getHospitalList() async {
    final db = await database;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('hospitals');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      var city = maps[i]['city'];
      var prov = maps[i]['province'];
      print("city");
      print(city);

      print("prov");
      print(prov);
      int cityvalue = 0;
      int provvalue = 0;

      // if(city!=null)
      //   {
      //     cityvalue= city as int;
      //   }
      // if(prov!=null)
      // {
      //   provvalue= prov as int;
      // }
      print("cityvalue");
      print(cityvalue);
      print("cityvalue");
      print(cityvalue);
      return HospitalList(
          rowId: maps[i]['row_id'],
          name: maps[i]['name'],
          email: maps[i]['email'],
          phone: maps[i]['phone'],
          address: maps[i]['address'],
          province: provvalue,
          city: cityvalue,
          longitude: maps[i]['longitude'],
          latitude: maps[i]['latitude'],
          photo: maps[i]['photo']);
    });
  }

  Future<List<UserTypeList>> getUserTypeList() async {
    final db = await database;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('usertype');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return UserTypeList(rowId: maps[i]['row_id'], type: maps[i]['type']);
    });
  }

  Future<List<CountryList>> getGetCountryList() async {
    final db = await database;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('country');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return CountryList(
          rowId: maps[i]['row_id'], countryName: maps[i]['country_name']);
    });
  }

  Future<List<VisaTypeList>> getGetVisaTypeList() async {
    final db = await database;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('visatype');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return VisaTypeList(rowId: maps[i]['row_id'], type: maps[i]['type']);
    });
  }

// Define a function that inserts dogs into the database
  Future<void> insertLoctionsList(LoctionsList dog) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflict algorithm` to use in case the same dog is inserted twice.
    // In this case, replace any previous data.
    await db.insert(
      'locations',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Define a function that inserts dogs into the database
  Future<void> insertVisaTypeList(VisaTypeList dog) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflict algorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'visatype',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Define a function that inserts dogs into the database
  Future<void> insertUserTypeList(UserTypeList dog) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflict algorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'usertype',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Define a function that inserts dogs into the database
  Future<void> clearDb() async {
    // Get a reference to the database.
    final db = await database;
    db.delete("country");
    db.delete("gender");
    db.delete("locations");
    db.delete("visatype");
    db.delete("usertype");
    db.delete("schedulecategorylist");
    db.delete("hospitals");
    db.delete("allowance");
    db.delete("allowancecategroy");
  }
}
