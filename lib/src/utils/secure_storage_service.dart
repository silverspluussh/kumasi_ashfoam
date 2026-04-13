import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

/// Secure storage service for storing sensitive data like API keys and user data
/// Designed for offline-first applications with minimal server authentication
class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  // Storage keys
  static const String _apiKeyKey = 'api_key';
  static const String _apiSecretKey = 'api_secret';
  static const String _userDataKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _serverUrlKey = 'server_url';
  static const String _branchIdKey = 'branch_id';
  static const String _deviceIdKey = 'device_id';

  // ============================================================================
  // API KEY MANAGEMENT
  // ============================================================================

  /// Store API key and secret
  Future<void> storeApiCredentials({
    required String apiKey,
    required String apiSecret,
  }) async {
    await Future.wait([
      _storage.write(key: _apiKeyKey, value: apiKey),
      _storage.write(key: _apiSecretKey, value: apiSecret),
    ]);
  }

  /// Get API key
  Future<String?> getApiKey() async {
    return await _storage.read(key: _apiKeyKey);
  }

  /// Get API secret
  Future<String?> getApiSecret() async {
    return await _storage.read(key: _apiSecretKey);
  }

  /// Check if API credentials are stored
  Future<bool> hasApiCredentials() async {
    final apiKey = await getApiKey();
    return apiKey != null && apiKey.isNotEmpty;
  }

  // ============================================================================
  // USER DATA MANAGEMENT
  // ============================================================================

  /// Store user data (as JSON string)
  Future<void> storeUserData(Map<String, dynamic> userData) async {
    await _storage.write(
      key: _userDataKey, 
      value: jsonEncode(userData)
    );
  }

  /// Get user data
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final dataString = await _storage.read(key: _userDataKey);
      if (dataString == null) return null;
      return jsonDecode(dataString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // ============================================================================
  // LOGIN STATUS
  // ============================================================================

  /// Set login status
  Future<void> setLoggedIn(bool value) async {
    await _storage.write(key: _isLoggedInKey, value: value.toString());
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: _isLoggedInKey);
    return value == 'true';
  }

  // ============================================================================
  // DEVICE & SERVER CONFIGURATION
  // ============================================================================

  /// Store server URL
  Future<void> storeServerUrl(String url) async {
    await _storage.write(key: _serverUrlKey, value: url);
  }

  /// Get server URL
  Future<String?> getServerUrl() async {
    return await _storage.read(key: _serverUrlKey);
  }

  /// Store branch ID
  Future<void> storeBranchId(String branchId) async {
    await _storage.write(key: _branchIdKey, value: branchId);
  }

  /// Get branch ID
  Future<String?> getBranchId() async {
    return await _storage.read(key: _branchIdKey);
  }

  /// Store device ID
  Future<void> storeDeviceId(String deviceId) async {
    await _storage.write(key: _deviceIdKey, value: deviceId);
  }

  /// Get device ID
  Future<String?> getDeviceId() async {
    return await _storage.read(key: _deviceIdKey);
  }

  // ============================================================================
  // GENERIC STORAGE
  // ============================================================================

  /// Store a generic key-value pair
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read a generic value
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a specific key
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // ============================================================================
  // CLEAR DATA
  // ============================================================================

  /// Clear all authentication-related data
  Future<void> clearAuthData() async {
    await Future.wait([
      _storage.delete(key: _apiKeyKey),
      _storage.delete(key: _apiSecretKey),
      _storage.delete(key: _userDataKey),
      _storage.delete(key: _isLoggedInKey),
    ]);
  }

  /// Clear all storage (use with caution)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// Get all stored keys (for debugging)
  Future<List<String>> getAllKeys() async {
    final knownKeys = [
      _apiKeyKey,
      _apiSecretKey,
      _userDataKey,
      _isLoggedInKey,
      _serverUrlKey,
      _branchIdKey,
      _deviceIdKey,
    ];
    
    final existingKeys = <String>[];
    for (final key in knownKeys) {
      final value = await _storage.read(key: key);
      if (value != null) {
        existingKeys.add(key);
      }
    }
    return existingKeys;
  }

  /// Complete logout - clears all auth data
  Future<void> logout() async {
    await clearAuthData();
  }

  // ============================================================================
  // API HEADERS
  // ============================================================================

  /// Get authentication headers for API requests using API key
  Future<Map<String, String>> getAuthHeaders() async {
    final apiKey = await getApiKey();
    if (apiKey == null) return {};
    return {
      'X-API-Key': apiKey,
      'Content-Type': 'application/json',
    };
  }

  /// Get API key and secret for direct use
  Future<Map<String, String>?> getApiCredentials() async {
    final apiKey = await getApiKey();
    final apiSecret = await getApiSecret();
    if (apiKey == null || apiSecret == null) return null;
    return {
      'apiKey': apiKey,
      'apiSecret': apiSecret,
    };
  }
}