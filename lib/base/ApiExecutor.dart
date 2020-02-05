import 'dart:convert';
import 'dart:io';

typedef OnSuccess = void Function(Object o);
typedef OnError = void Function(Exception e);

class ApiExecutor {
  static void exec(String url, bool isPost, Map<String, String> params,
      OnSuccess onSuccess, OnError onError) async {
    try {
      var httpClient = new HttpClient();

      var uri = new Uri.https('mp.mhealth100.com',
          '/ip-healthmanager-dtr-app-web/' + url, isPost ? {} : params);
      var request = await httpClient.postUrl(uri);
      request.headers.add("Content-Type", "application/json");
      request.headers.add("Accept", "application/json; charset=utf-8");
      request.headers.add("Brand", "HUAWEI");
      request.headers.add("Equipment-Model", "EML-AL00");
      request.headers.add("System", "9.0.0");
      request.headers.add("Version", "2.5.3");
      request.headers.add("Build", "175");
      request.headers.add("User-Agent",
          "KingdeeDoctor/2.5.3.175 (Android;Android 9.0.0;EML-AL00) NetType/WIFI");
      if (isPost) {
        request.add(utf8.encode(json.encode(params)));
      }
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      httpClient.close();

      onSuccess(responseBody);
    } catch (e) {
      onError(e);
    }
  }
}
