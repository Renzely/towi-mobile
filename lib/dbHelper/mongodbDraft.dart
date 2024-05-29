import 'dart:convert';
import 'dart:ffi';
import 'package:demo_app/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:bcrypt/bcrypt.dart';

MongoDemo welcomeFromJson(String str) => MongoDemo.fromJson(json.decode(str));

String welcomeToJson(MongoDemo data) => json.encode(data.toJson());

class MongoDemo {
  final ObjectId id;
  final String remarks;
  final String firstName;
  final String middleName;
  final String lastName;
  final String emailAddress;
  final String contactNum;
  final String username;
  final String password;
  final String accountNameBranchManning;
  final bool isActivate;

  MongoDemo({
    required this.remarks,
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.emailAddress,
    required this.contactNum,
    required this.username,
    required this.password,
    required this.accountNameBranchManning,
    required this.isActivate,
  });

  factory MongoDemo.fromJson(Map<String, dynamic> json) {
    return MongoDemo(
      id: json['_id'],
      remarks: json['remarks'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      emailAddress: json['email_Address'],
      contactNum: json['contactNum'],
      username: json['username'],
      password: json['password'],
      accountNameBranchManning: json['accountNameBranchManning'],
      isActivate: json['isActivate'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'remarks': remarks,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'email_Address': emailAddress,
        'contactNum': contactNum,
        'username': username,
        'password': password,
        'accountNameBranchManning': accountNameBranchManning,
        'isActivate': isActivate
      };
}

Future<String> hashPassword(String password) async {
  // Generate a random salt for each password
  final rounds =
      8; // Adjust the number of rounds based on security requirements
  final salt = await BCrypt.gensalt(logRounds: rounds);

  // Hash the password with the generated salt
  final hashedPassword = await BCrypt.hashpw(password, salt);
  return hashedPassword;
}

// // // INVENTORY DATABASE // // //

class InventoryItem {
  ObjectId id;
  String userEmail;
  String date;
  String inputId;
  String name;
  String accountNameBranchManning;
  String period;
  String month;
  String week;
  String category;
  String skuDescription;
  String products;
  String skuCode;
  String status; // Carried, Not Carried, Delisted
  dynamic beginning;
  dynamic delivery;
  dynamic ending;
  dynamic offtake;
  final double inventoryDaysLevel;
  dynamic noOfDaysOOS;

  InventoryItem({
    required this.id,
    required this.userEmail,
    required this.date,
    required this.inputId,
    required this.name,
    required this.accountNameBranchManning,
    required this.period,
    required this.month,
    required this.week,
    required this.category,
    required this.skuDescription,
    required this.products,
    required this.skuCode,
    required this.status,
    required this.beginning,
    required this.delivery,
    required this.ending,
    required this.offtake,
    required this.inventoryDaysLevel,
    required this.noOfDaysOOS,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
        id: json['_id'] ?? ObjectId(),
        userEmail: json['userEmail'] ?? '',
        date: json['date'] ?? '',
        inputId: json['inputId'] ?? '',
        name: json['name'] ?? '',
        accountNameBranchManning: json['accountNameBranchManning'] ?? '',
        period: json['period'] ?? '',
        month: json['month'] ?? '',
        week: json['week'] ?? '',
        category: json['category'] ?? '',
        skuDescription: json['skuDescription'] ?? '',
        products: json['products'] ?? '',
        skuCode: json['skuCode'] ?? '',
        status: json['status'] ?? '',
        beginning: json['beginning'] ?? 0,
        delivery: json['delivery'] ?? 0,
        ending: json['ending'] ?? 0,
        offtake: json['offtake'] ?? 0,
        inventoryDaysLevel: (json['inventoryDaysLevel'] != null)
            ? double.parse(json['inventoryDaysLevel'].toStringAsFixed(2))
            : 0.0, // Default value if null
        noOfDaysOOS: json['noOfDaysOOS'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userEmail': userEmail,
        'date': date,
        'inputId': inputId,
        'name': name,
        'accountNameBranchManning': accountNameBranchManning,
        'period': period,
        'month': month,
        'week': week,
        'category': category,
        'skuDescription': skuDescription,
        'products': products,
        'skuCode': skuCode,
        'status': status,
        'beginning': beginning,
        'delivery': delivery,
        'ending': ending,
        'offtake': offtake,
        'inventoryDaysLevel': inventoryDaysLevel,
        'noOfDaysOOS': noOfDaysOOS,
      };
  void _saveToDatabase(InventoryItem newItem) async {
    // Connect to your MongoDB database
    final db = Db(MONGO_CONN_URL);
    await db.open();

    // Get a reference to the collection where you want to save items
    final collection = db.collection(USER_INVENTORY);

    // Convert the InventoryItem to a Map using the toJson() method
    final Map<String, dynamic> itemMap = newItem.toJson();

    // Insert the item into the collection
    try {
      await collection.insert(itemMap);
      print('Item saved to database');
    } catch (e) {
      // Handle any errors that occur during saving
      print('Error saving item: $e');
    }

    // Close the database connection when done
    await db.close();
  }
}

class ReturnToVendor {
  ObjectId id;
  String userEmail;
  String date;
  String merchandiserName;
  String outlet;
  String category;
  String item;
  String quantity;
  String driverName;
  String plateNumber;
  String pullOutReason;

  ReturnToVendor({
    required this.id,
    required this.userEmail,
    required this.date,
    required this.merchandiserName,
    required this.outlet,
    required this.category,
    required this.item,
    required this.quantity,
    required this.driverName,
    required this.plateNumber,
    required this.pullOutReason,
  });

  factory ReturnToVendor.fromJson(Map<String, dynamic> json) => ReturnToVendor(
        id: json['_id'] ?? ObjectId(),
        userEmail: json['userEmail'] ?? '',
        date: json['date'] ?? '',
        merchandiserName: json['merchandiserName'] ?? '',
        outlet: json['outlet'] ?? '',
        category: json['category'] ?? '',
        item: json['item'] ?? '',
        quantity: json['quantity'] ?? '',
        driverName: json['driverName'] ?? '',
        plateNumber: json['plateNumber'] ?? '',
        pullOutReason: json['pullOutReason'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userEmail': userEmail,
        'date': date,
        'merchandiserName': merchandiserName,
        'outlet': outlet,
        'category': category,
        'Item': item,
        'quantity': quantity,
        'driverName': driverName,
        'plateNumber': plateNumber,
        'pullOutReason': pullOutReason,
      };

  void saveToDatabase(ReturnToVendor newItem) async {
    final db = Db(MONGO_CONN_URL);
    await db.open();

    final collection = db.collection(USER_RTV);

    final Map<String, dynamic> itemMap = newItem.toJson();

    try {
      await collection.insert(itemMap);
      print('Return to vendor saved to database');
    } catch (e) {
      print('Error saving return to vendor: $e');
    }

    await db.close();
  }
}
