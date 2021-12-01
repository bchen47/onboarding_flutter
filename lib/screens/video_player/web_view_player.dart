import "dart:async";
import 'package:flutter/material.dart';
import 'package:bestcycling_webview/bestcycling_webview.dart';
import './web_view_manager.dart';
import './player_data.dart';

/// Debe ser sustituido por un Access Token válido.
late String accessToken;
dynamic playerData;

class WebViewPlayer extends StatefulWidget {
  WebViewPlayer({Key? key, required String token, required data})
      : super(key: key) {
    accessToken = token;
    playerData = data;
  }

  @override
  _WebViewPlayerState createState() => _WebViewPlayerState();
}

class _WebViewPlayerState extends State<WebViewPlayer>
    with WidgetsBindingObserver {
  String url = "";

  bool loading = true;

  late final WebviewManager webviewManager;

  late final StreamSubscription onUrlChangeSubscription;

  final bestcyclingWebview = BestcyclingWebview();

  final Map<String, dynamic> configuration = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    webviewManager = WebviewManager(type: "cycling");
    _setupPlayer(accessToken, playerData);
    _activateListeners();
  }

  @override
  void dispose() {
    _disableListeners();
    super.dispose();
  }

  /// Parsea los datos de la clase y creamos el HTML del webview.
  _setupPlayer(accessToken, playerData) async {
    final data = playerData;
    final options = PlayerData.preferences;

    final Map<String, dynamic> trainingData = data;
    trainingData['url'] =
        "${trainingData["media"][0]["url"]}&access_token=$accessToken";
    //"${trainingData["url"]}&access_token=$accessToken";

    if (trainingData['progression'].length == 0) {
      trainingData['progression'] = null;
    }
    if (trainingData['progression_watts'].length == 0) {
      trainingData['progression_watts'] = null;
    }
    trainingData['mediaType'] = "video";

    String webplayerUrl = await webviewManager
        .configure({"training_data": trainingData, "options": options});

    setState(() {
      url = webplayerUrl;
      loading = false;
    });
  }

  /// Nos ponemos a la escucha de los cambios en la URL del webview.
  _activateListeners() {
    String lastUrl = "";
    onUrlChangeSubscription =
        bestcyclingWebview.onUrlChanged.listen((String? url) async {
      // Si cambia la url en el player
      if (lastUrl != url) {
        // Parseamos la URL
        Uri uri = Uri.parse(url!);
        List<String> fragment = uri.fragment.split(RegExp(r"(\?|\&|/|_)"));
        String action = fragment.first;

        // Evento de volver o finalizar
        if (action == "close" || action == "end" || action == "ended") {
          _onClose(url);
        }
      }
    });
  }

  _disableListeners() {
    onUrlChangeSubscription.cancel();
  }

  Future<bool> _onBackPressed() async {
    return true;
  }

  Future<bool> _onClose(String url) async {
    // En este demo no tenemos página anterior.
    // Navigator.of(context).pop();
    return true;
  }

  Widget _buildLoading() {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: const Center(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget webView(String url) {
    return SafeArea(
      child: WillPopScope(
          onWillPop: _onBackPressed,
          child: WebviewScaffold(
            url: url,
            withZoom: false,
            withLocalStorage: true,
            withJavascript: true,
            withLocalUrl: true,
            hidden: false,
            allowFileURLs: true,
            initialChild: _buildLoading(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading ? _buildLoading() : webView(url);
  }
}
