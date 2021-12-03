import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/blocs/recipe/recipe_bloc.dart';
import 'package:prueba/blocs/authentication/authentication_bloc.dart';

class RecipeIndividualPage extends StatelessWidget {
  final String id;
  const RecipeIndividualPage({Key? key, required id})
      : id = id ?? "",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            context.read<RecipeBloc>().add(GetRecipe(
                context.read<AuthenticationBloc>().state.token.accessToken,
                id));
            return BlocBuilder<RecipeBloc, RecipeState>(
                builder: (context, state) {
              return Scaffold(
                  appBar: appBar(
                      state.recipe.attributes["name"],
                      state.recipe.author[
                          state.recipe.attributes["author_id"].toString()]),
                  body: home(context, state));
            });
          })),
    ));
  }

  PreferredSizeWidget appBar(String? title, String? recipe) {
    return AppBar(
      elevation: 0, // 1
      backgroundColor: Colors.grey[900],
      title: Column(children: [
        Text(title ?? "Cargando...",
            style: TextStyle(fontSize: 16, color: Colors.grey[300])),
        Text(recipe ?? "...",
            style: const TextStyle(fontSize: 14, color: Colors.grey))
      ]),
      centerTitle: true,
    );
  }

  Widget home(context, RecipeState state) {
    return Container(
        child: state.recipe.attributes.isNotEmpty
            ? card(context, state.recipe.attributes)
            : const Center(child: CircularProgressIndicator()));
  }

  Widget _loader(BuildContext context, String url) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error(BuildContext context, String url, dynamic error) {
    return const Center(child: Icon(Icons.error));
  }

  Widget card(context, Map<String, dynamic> trainingClass) {
    return Container(
      color: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          topSideCard(trainingClass),
          middleSide(),
          bottomSide(trainingClass),
          categories(trainingClass["categories"]),
          statsRow(trainingClass["nutrients"]),
          const Spacer(),
          buttons()
        ],
      ),
    );
  }

  Widget buttons() {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Center(
          child: Column(children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('INGREDIENTES',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ),
            ),
          ]),
        ));
  }

  Widget statsRow(nutrients) {
    final children = <Widget>[];
    for (var i = 1; i < nutrients.length; i++) {
      children.add(stats(
          nutrients[i]["name"].toString(), nutrients[i]["value"].toString()));
    }
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey[850] ?? Colors.grey),
              top: BorderSide(
                color: Colors.grey[850] ?? Colors.grey,
              ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }

  Widget stats(label, value) {
    return Column(children: [
      Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      Container(
        margin: const EdgeInsets.all(5),
      ),
      Text(value + " g",
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey))
    ]);
  }

  Widget middleSide() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 90),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey[850] ?? Colors.grey,
      ))),
      child: imageButton(Icons.star, "Añadir favorito"),
    );
  }

  Widget categories(categories) {
    final children = <Widget>[];
    for (var i = 0; i < categories.length; i++) {
      children.add(category(categories[i]["name"].toString()));
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Wrap(
        spacing: 15,
        children: children,
      ),
    );
  }

  Widget category(text) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white60, fontSize: 14, fontWeight: FontWeight.bold),
        ));
  }

  Widget imageButton(icon, text) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey))
          ],
        ));
  }

  Widget bottomSide(
    Map<String, dynamic> recipes,
  ) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey[850] ?? Colors.grey,
      ))),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(recipes["difficulty_name"].toString(),
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
            (recipes["nutrients"][0]["value"] as double).round().toString() +
                " kcal",
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(recipes["minutes_time"].toString() + "' min",
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ]),
    );
  }

  Widget topSideCard(Map<String, dynamic> trainingClass) {
    return CachedNetworkImage(
      imageUrl: trainingClass["image"] ?? "",
      placeholder: _loader,
      errorWidget: _error,
    );
  }
}
