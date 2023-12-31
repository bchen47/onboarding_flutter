import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/blocs/recipes/recipes_bloc.dart';
import 'package:prueba/blocs/recipe/recipe_bloc.dart';
import 'package:prueba/repository/recipe_repository.dart';
import 'package:prueba/screens/recipe_individual/recipe_individual_page.dart';
import 'package:prueba/utils/style.dart';
import 'package:prueba/blocs/authentication/authentication_bloc.dart';

class RecipesListPage extends StatelessWidget {
  final String category;
  final String title;

  const RecipesListPage({Key? key, category, title})
      : category = category ?? "",
        title = title ?? "",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<RecipesBloc>(context);
    context.read<RecipesBloc>().add(GetRecipes(
        context.read<AuthenticationBloc>().state.token.accessToken, category));
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Scaffold(appBar: Customs.appBar(title), body: home(context))),
    );
  }

  Widget home(context) {
    return BlocBuilder<RecipesBloc, RecipesState>(builder: (context, state) {
      return ListView.separated(
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        itemCount: state.recipes.attributes.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: state.recipes.attributes.isNotEmpty
                  ? card(context, state.recipes.attributes[index])
                  : Container());
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    });
  }

  Widget _loader(BuildContext context, String url) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error(BuildContext context, String url, dynamic error) {
    return const Center(child: Icon(Icons.error));
  }

  Widget card(context, Map<String, dynamic> recipes) {
    return Column(children: [
      GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (BuildContext context) =>
                              RecipeBloc(recipeRepository: RecipeRepository()),
                          child: RecipeIndividualPage(id: recipes["id"]),
                        )));
          },
          child: Column(
            children: [topSideCard(recipes), bottomSide(recipes)],
          ))
    ]);
  }

  Widget bottomSide(
    Map<String, dynamic> recipes,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.grey[850],
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(recipes["minutes_time"].toString() + "' min",
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text((recipes["nutrients"][0]["value"]).round().toString() + " kcal",
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(recipes["difficulty_name"].toString(),
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ]),
    );
  }

  Widget topSideCard(Map<String, dynamic> recipes) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: recipes["image"] ?? "",
          placeholder: _loader,
          errorWidget: _error,
        ),
        Positioned(
          child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Text(recipes["name"].toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
        ),
      ],
    );
  }
}
