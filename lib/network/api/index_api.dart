import '../http/base_api.dart';
import '../service/custom_service.dart';

class IndexApi extends BaseApi {
  @override
  String path() {
    return "/api/7mm/get7mmPage/1";
  }

  @override
  RequestMethod method() {
    return RequestMethod.get;
  }

  @override
  String serviceKey() {
    return customServiceKey;
  }
}
