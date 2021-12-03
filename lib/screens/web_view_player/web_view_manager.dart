import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:assets_path_provider/assets_path_provider.dart';
import 'package:path_provider/path_provider.dart';

class WebviewManager {
  static const nameWebView = 'webview.html';

  late String _type;
  static const String assetNameIndex = "assets/player.html";

  static const List<String> typeAllowed = [
    'graph',
    'running',
    'cycling',
    'balance',
    'training',
    'mind',
    'cycling_audio',
    'simple_video'
  ];

  WebviewManager({required String type}) : assert(typeAllowed.contains(type)) {
    _type = type;
  }

  Future<String> configure(Map<String, dynamic> configuration) async {
    //String _html ="<!DOCTYPE html> <html> <head> <title>Bestcycling Life Media Player</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no, __FIT_COVER__\" /> <!-- css --> <link href=\"file://__ASSETS_PATH__/www/__TYPE_PLAYER__.css\" rel=\"stylesheet\" type=\"text/css\" /> <script type=\"application/javascript\"> BTD_trainingClass = __TRAINING_CLASS__; BTD_app_name = \"__APP_NAME__\"; BTD_PATH = \"__PATH__\"; BVO_options = __OPTIONS__; </script> </head> <body> <div id=\"app\"></div> <script src=\"file://__ASSETS_PATH__/www/__LIBS__.js\"></script> <script src=\"file://__ASSETS_PATH__/www/__TYPE_PLAYER__.js\"></script> </body> </html> ";
    String _html = await rootBundle.loadString(assetNameIndex);

    _html = await _replaceAssets(_html, configuration);
    await _savePlayer(_html);
    final String playerPath = await _getPlayerPath();

    return "file://$playerPath";
  }

  Future<String> _replaceAssets(
      String html, Map<String, dynamic> configuration) async {
    html = html.replaceAll(
        "__TRAINING_CLASS__", jsonEncode(configuration['training_data']));

    html = html.replaceAll("__OPTIONS__", jsonEncode(configuration['options']));

    html = html.replaceAll("__APP_NAME__", "Bestcycling");
    html = html.replaceAll("__TYPE_PLAYER__", _type);

    if (_type == 'graph') {
      html = html.replaceAll("__LIBS__", "graph_libs");
    } else {
      html = html.replaceAll("__LIBS__", "libs");
    }

    if (_type != "graph" && _type != "cycling_audio") {
      html = html.replaceAll("__FIT_COVER__", "viewport-fit=cover");
    } else {
      html = html.replaceAll("__FIT_COVER__", "");
    }

    final path = await AssetsPathProvider.getAssetPath("assets");
    html = html.replaceAll("__ASSETS_PATH__", path);

    return html;
  }

  Future<String> getCompleteHtmlString(String pathFile) async {
    File file = File(pathFile.replaceAll(RegExp(r'file:\/\/'), ''));
    String content = await file.readAsString();
    RegExp regExp = RegExp(r'<script src\=\"file:\/\/(.*)\"');
    var hrefMatch = regExp.allMatches(content);

    for (var ref in hrefMatch) {
      //group 0 es el objeto html completo "<script>...</script>"
      String toReplace = ref.group(0).toString();
      //group 1 es la ruta del fichero
      String pathResource = ref.group(1).toString();

      File fileResource = File(pathResource);
      String pathResourceContent = await fileResource.readAsString();
      content = content.replaceAll(
          RegExp(toReplace),
          "<script type='application/javascript'>" +
              pathResourceContent +
              "</script>");
    }

    RegExp regExp2 = RegExp(r'<link\s*href=("file:\/\/(.*?)\")(.*?|\s*)+?>',
        multiLine: true);
    var hrefMatch2 = regExp2.allMatches(content);
    for (var ref in hrefMatch2) {
      //group 2 es la ruta del fichero
      String pathResource = ref.group(2).toString();
      File fileResource = File(pathResource);
      String pathResourceContent = await fileResource.readAsString();
      content = content.replaceAll(
          "</head>", "<style>" + pathResourceContent + "</style></head>");
    }
    return Uri.dataFromString(content,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _getPlayerPath();
    return File(path);
  }

  Future<String> _getPlayerPath() async {
    final path = await _localPath;
    return "$path/$nameWebView";
  }

  Future<File> _savePlayer(String html) async {
    final file = await _localFile;
    return await file.writeAsString(html);
  }
}
