import 'package:flutter/foundation.dart';

class SecuritySetupParams {
  SecuritySetupParams({
    required this.androidConfig,
    required this.iosConfig,
    this.watcherMail = '',
    this.isEnabled = kReleaseMode,
  });

  final AndroidSecurityConfig androidConfig;
  final IosSecurityConfig iosConfig;
  final String watcherMail;
  final bool isEnabled;
}

class AndroidSecurityConfig {
  AndroidSecurityConfig({
    required this.packageName,
    required this.signingCertHashes,
    this.supportedStores = const ['adb'],
  });

  final String packageName;
  final List<String> signingCertHashes;
  final List<String> supportedStores;
}

class IosSecurityConfig {
  IosSecurityConfig({
    required this.bundleIds,
    required this.teamId,
  });

  final List<String> bundleIds;
  final String teamId;
}
