class PokeHub {
  List<Pokemon> pokemon;

  PokeHub({this.pokemon});

  PokeHub.fromJson(Map<String, dynamic> json) {
    if (json['pokemon'] != null) {
      pokemon = new List<Pokemon>();
      json['pokemon'].forEach((v) {
        pokemon.add(new Pokemon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pokemon != null) {
      data['pokemon'] = this.pokemon.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pokemon {
  int id;
  String num;
  String name;
  String img;
  String description;
  String height;
  String weight;
  String category;
  List<String> abilities;
  List<String> types;
  List<String> weaknesses;
  List<EvolutionTree> evolutionTree;

  Pokemon(
      {this.id,
      this.num,
      this.name,
      this.img,
      this.description,
      this.height,
      this.weight,
      this.category,
      this.abilities,
      this.types,
      this.weaknesses,
      this.evolutionTree});

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    name = json['name'];
    img = json['img'];
    description = json['description'];
    height = json['height'];
    weight = json['weight'];
    category = json['category'];
    abilities = json['abilities'].cast<String>();
    types = json['types'].cast<String>();
    weaknesses = json['weaknesses'].cast<String>();
    if (json['evolution_tree'] != null) {
      evolutionTree = new List<EvolutionTree>();
      json['evolution_tree'].forEach((v) {
        evolutionTree.add(new EvolutionTree.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['num'] = this.num;
    data['name'] = this.name;
    data['img'] = this.img;
    data['description'] = this.description;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['category'] = this.category;
    data['abilities'] = this.abilities;
    data['types'] = this.types;
    data['weaknesses'] = this.weaknesses;
    if (this.evolutionTree != null) {
      data['evolution_tree'] =
          this.evolutionTree.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EvolutionTree {
  String name;

  EvolutionTree({this.name});

  EvolutionTree.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
