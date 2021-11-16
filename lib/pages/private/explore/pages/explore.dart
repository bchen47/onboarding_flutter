import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderImages {
  final Widget background;
  final Widget above;

  SliderImages(this.background, this.above);
}

class ExplorePage extends StatelessWidget {
  ExplorePage({
    Key? key,
  }) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ExplorePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: home(context));
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  static const TextStyle optionStyleRecipes =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white);

  Widget home(context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  color: Colors.black,
                  margin: const EdgeInsets.only(top: 30),
                  child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text("Explorar", style: optionStyle))),
              sliderRow(trainingImages, "BUSCAR ENTRENAMIENTOS", context),
              sliderRow(recipesImages, "RECETAS", context),
            ]));
  }

  Widget sliderRow(items, String title, context) {
    return Container(
        // width: Medi aQuery.of(context).size.width,
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey))),
        child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                slider(items)
              ],
            )));
  }

  Widget slider(items) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        enableInfiniteScroll: true,
      ),
      items: items.map<Widget>((SliderImages i) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(children: <Widget>[
              i.background,
              Container(
                  width: 280,
                  height: 130,
                  padding: const EdgeInsets.all(40),
                  alignment: Alignment.center,
                  child: i.above)
            ]);
          },
        );
      }).toList(),
    );
  }

  final trainingImages = [
    SliderImages(
        Image.asset(
          "assets/slider/bestbalance.jpg",
          width: 280,
          height: 130,
          fit: BoxFit.cover,
        ),
        Image.asset("assets/slider/bestbalance-logo.png",
            width: 280, height: 130)),
    SliderImages(
        Image.asset(
          "assets/slider/bestcycling.jpg",
          width: 280,
          height: 130,
          fit: BoxFit.cover,
        ),
        Image.asset("assets/slider/bestcycling-logo.png",
            width: 280, height: 130)),
    SliderImages(
        Image.asset("assets/slider/bestmind.jpg",
            width: 280, height: 130, fit: BoxFit.cover),
        Image.asset("assets/slider/bestmind-logo.png",
            width: 280, height: 130, fit: BoxFit.contain)),
    SliderImages(
        Image.asset("assets/slider/bestrunning.jpg",
            width: 280, height: 130, fit: BoxFit.cover),
        Image.asset("assets/slider/bestrunning-logo.png",
            width: 280, height: 130)),
    SliderImages(
        Image.asset("assets/slider/besttraining.jpg",
            width: 280, height: 130, fit: BoxFit.cover),
        Image.asset("assets/slider/besttraining-logo.png",
            width: 280, height: 130)),
    SliderImages(
        Image.asset("assets/slider/bestwalking.jpg",
            width: 280, height: 130, fit: BoxFit.cover),
        Image.asset("assets/slider/bestwalking-logo.png",
            width: 280, height: 130))
  ];
  final recipesImages = [
    SliderImages(
        Image.asset("assets/slider/breakfast.jpg",
            width: 280, height: 130, fit: BoxFit.cover),
        const Text("Desayunos", style: optionStyleRecipes)),
    SliderImages(
        Image.asset("assets/slider/lunchdinner.jpg",
            width: 280, height: 130, fit: BoxFit.cover),
        const Text("Comidas", style: optionStyleRecipes)),
    SliderImages(
        Image.asset("assets/slider/snack.jpg",
            width: 280, height: 130, fit: BoxFit.cover),
        const Text("Snack", style: optionStyleRecipes)),
  ];
}
