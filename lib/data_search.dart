import 'package:flutter/material.dart';

import 'package:cnupogo/pokehub.dart';
import 'package:cnupogo/pokemon_detail.dart';

class DataSearch extends SearchDelegate<String> {
  PokeHub pokeHub;
  String selectedTile = "";

  DataSearch(this.pokeHub);

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on selection
    Pokemon pokemon = PokeDetail.queryPokemon(selectedTile, pokeHub);
    return PokeDetail(pokemon: pokemon, pokeHub: pokeHub);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    List queriedList = pokeHub.pokemon
        .where(
            (poke) => poke.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
            onTap: () {
              selectedTile = queriedList[index].name;
              showResults(context);
            },
            leading: Icon(Icons.arrow_forward_ios),
            title: RichText(
              text: TextSpan(
                  text: queriedList[index].name.substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: queriedList[index].name.substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ]),
            ),
          ),
      itemCount: queriedList.length,
    );
  }
}
