enum Env { DEVELOPMENT, STAGING, PRODUCTION }

class BuildConfig {
  static Map<String, String> _config = _Config.development;

  static void setEnvironment(Env env) {
    switch (env) {
      case Env.DEVELOPMENT:
        _config = _Config.development;
        break;
      case Env.STAGING:
        _config = _Config.staging;
        break;
      case Env.PRODUCTION:
        _config = _Config.production;
        break;
    }
  }

  static String get BASE_URL => _config[_Config.BASE_URL] as String;
}

class _Config {
  static const BASE_URL = 'BASE_URL';

  static const development = {
    BASE_URL: 'https://api.themoviedb.org/3',
  };

  static const staging = {
    BASE_URL: 'https://api.themoviedb.org/3',
  };

  static const production = {
    BASE_URL: 'https://api.themoviedb.org/3',
  };
}
