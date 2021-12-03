import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Widget row(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.all(3.125),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12.5,
            ),
          ),
        ),
      ),
    );
  }

  void _onFinishPlaying(ImageSequenceAnimatorState _imageSequenceAnimator) {
    //Navigator.pushNamed(context, "/welcome");
    _imageSequenceAnimator.stop();

    Navigator.of(context).pushNamedAndRemoveUntil<void>(
      "/welcomepage",
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
                padding: const EdgeInsets.all(25),
                child: ImageSequenceAnimator(
                    "assets/splash", "logo-animado-sprites", 0, 2, "png", 37,
                    isAutoPlay: true,
                    onFinishPlaying: _onFinishPlaying,
                    fps: 30)),
          ),
        ],
      ),
    );
  }
}
