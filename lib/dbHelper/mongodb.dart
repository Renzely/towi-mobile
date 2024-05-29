import 'dart:developer';
import 'package:demo_app/dbHelper/constant.dart';
import 'package:demo_app/dbHelper/mongodbDraft.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;

  static Future<void> connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrdata = await userCollection.find().toList();
    return arrdata;
  }

  static Future<String> insert(MongoDemo data) async {
    try {
      await connect(); // Ensure connection is established
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something went wrong while inserting data.";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    } finally {
      await db.close(); // Close the database connection after insertion
    }
  }

  static Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      await connect(); // Ensure connection is established
      if (db.state == State.OPEN) {
        final userData = await userCollection.findOne();
        print('User Data: $userData'); // Print user data for debugging
        return userData;
      } else {
        print('Error: Database connection not open');
        return null;
      }
    } catch (e) {
      print('Error fetching user info: $e');
      return null;
    } finally {
      if (db != null && db.state == State.OPEN) {
        await db.close(); // Close the database connection if it's open
      }
    }
  }

  static Future<Map<String, dynamic>?> getUserDetailsById(String userId) async {
    try {
      await connect(); // Ensure connection is established
      final user =
          await userCollection.findOne({'_id': ObjectId.parse(userId)});
      return user;
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getUserDetailsByUsername(
      String username) async {
    try {
      await connect(); // Ensure connection is established
      final user = await userCollection.findOne({'username': username});
      return user;
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getBranchData() async {
    var db = await Db.create(MONGO_CONN_URL);
    await db.open();
    var collection =
        db.collection(USER_COLLECTION); // Ensure this is the correct collection
    var branches = await collection.find().toList();
    await db.close();
    return branches;
  }
}
