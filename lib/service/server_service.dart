import 'package:aiko/constant/app_urls.dart';
import 'package:aiko/entity/server_entity.dart';
import 'package:aiko/utils/http_util.dart';

class ServerService {
  Future<List<ServerEntity>> server() {
    return HttpUtil.instance.get(AppUrls.server).then((result) {
      return serverEntityFromList(result['data']);
    });
  }
}
