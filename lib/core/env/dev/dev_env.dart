import 'package:envied/envied.dart';

part 'dev_env.g.dart';

@Envied(path: './env/dev.env')
abstract class DevEnv {
  @EnviedField(varName: 'BASE_URL', obfuscate: false)
  static final String baseUrl = _DevEnv.baseUrl;
}
