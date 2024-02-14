import 'dart:convert';

import '../../common/models/failure.dart';
import '../../common/models/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/ioc/service_locator.dart';
import '../../core/logging/logger.dart';

abstract class LocalStorage<T extends Object> {
  LocalStorage(this._logger);

  // Static secure storage instance to be used to fetch Hive encryption key.
  static const _secureStorage = FlutterSecureStorage();

  final Logger _logger;

  // Unique item key consists of the given generic type's string representation
  // and some random characters appended to it. Because it's important
  // not to match with any other key when another item is manually added.
  final String _uniqueItemKey = '${T.toString()}-11ffbf9b510648da';

  var _isInitialized = false;

  /// Adds or updates a single [item] in [T] type by [key] in the storage.
  @protected
  Future<Result> putSingle(String key, T? item) async {
    try {
      final box = await _getBox();
      if (item == null || _isTypePrimitive()) {
        // Put the item into the box directly if it's null or primitive.
        await box.put(key, item);
      } else {
        // Serialize the item and add into the box as String.
        final jsonMap = (item as dynamic).toJson();
        final value = json.encode(jsonMap);
        await box.put(key, value);
      }
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
    return Result.success();
  }

  /// Removes a single item in [T] type by [key] from the storage.
  @protected
  Future<Result> removeSingle(String key) async {
    try {
      final box = await _getBox();
      await box.delete(key);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
    return Result.success();
  }

  /// Gets all the items in [T] type from the storage.
  @protected
  Future<Result<Iterable<T>, Failure>> getAll() async {
    final box = await _getBox();
    final items = <T>[];
    try {
      for (final key in box.keys) {
        final value = await box.get(key);
        if (value == null || _isTypePrimitive()) {
          // Add the value into the list directly if it's null or primitive.
          items.add(value);
        } else {
          // Deserialize the value and add into the list as object.
          final jsonMap = json.decode(value);
          final item = locator<T>(param1: jsonMap);
          items.add(item);
        }
      }
    } catch (e) {
      _logger.error('Fetching items from local storage failed: $e');
      return Result.failure(Failure(message: e.toString()));
    }
    _logger.debug('Items fetched from local storage: $items');
    return Result.success(value: items);
  }

  /// Updates the unique [item] representing [T] type in the storage.
  @protected
  Future<void> updateUniqueItem(T? item) {
    return putSingle(_uniqueItemKey, item);
  }

  /// Removes the unique [item] representing [T] type from the storage.
  @protected
  Future<void> removeUniqueItem() {
    return removeSingle(_uniqueItemKey);
  }

  static Future<void> dispose() {
    return Hive.close();
  }

  // Helpers
  Future<void> _initialize() async {
    try {
      if (_isInitialized) return;
      // Check if the encryption key exists in the secure storage.
      const secureStorage = FlutterSecureStorage();
      final encryptionKey = await secureStorage.read(
        key: _SecureStorageConstants.hiveEncryptionStorageKey,
        aOptions: _SecureStorageConstants.androidOptions,
        iOptions: _SecureStorageConstants.iosOptions,
      );
      // If the encryption key doesn't exist, generate and save a new one.
      if (encryptionKey == null) {
        final key = Hive.generateSecureKey();
        await secureStorage.write(
          key: _SecureStorageConstants.hiveEncryptionStorageKey,
          value: base64UrlEncode(key),
          aOptions: _SecureStorageConstants.androidOptions,
          iOptions: _SecureStorageConstants.iosOptions,
        );
      }
      // Initialize Hive. Saved encryption key will be used in unique storages.
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
      _isInitialized = true;
    } catch (_) {}
  }

  Future<LazyBox<dynamic>> _getBox() async {
    await _initialize();
    final boxName = T.toString();
    // Return the box if it's already open.
    if (Hive.isBoxOpen(boxName)) {
      return Hive.lazyBox(boxName);
    }
    // Open a lazy box using encryption key fetched from secure storage.
    final key = await _secureStorage.read(
      key: _SecureStorageConstants.hiveEncryptionStorageKey,
      aOptions: _SecureStorageConstants.androidOptions,
      iOptions: _SecureStorageConstants.iosOptions,
    );
    final encryptionKey = base64Url.decode(key!);
    return Hive.openLazyBox(
      boxName,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }

  bool _isTypePrimitive() =>
      T == int || T == double || T == bool || T == String;
  // - Helpers
}

abstract class _SecureStorageConstants {
  /// Storage key to save local storage encryption key generated by Hive.
  static const hiveEncryptionStorageKey = 'hiveEncryptionStorageKey';

  /// Secure storage Android options.
  static const androidOptions = AndroidOptions(
    // Use encrypted shared preferences.
    // See: https://developer.android.com/topic/security/data
    encryptedSharedPreferences: true,
  );

  /// Secure storage iOS options.
  static const iosOptions = IOSOptions(
    // Fetch secure values while the app is backgrounded.
    accessibility: KeychainAccessibility.first_unlock,
  );
}
