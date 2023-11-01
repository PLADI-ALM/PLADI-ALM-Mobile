
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// BASE URL
const baseUrl = 'http://13.124.122.173/api';

/// token 로컬 저장을 위한 키값
const accessTokenKey = 'accessTokenKey';
const refreshTokenKey = 'refreshTokenKey';

/// token 로컬 저장을 위한 storage
const storage = FlutterSecureStorage();