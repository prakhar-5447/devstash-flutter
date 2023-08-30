import 'dart:convert';

class Helper {
  dynamic responseFromJson(String json) {
    final res = jsonDecode(json);
    return {"success": res['success'], "msg": res['msg']};
  }
}
