class HeroModel {
  final String id;
  final String name;
  final Powerstats powerstats;
  final Biography biography;
  final String image;
  final Appearance appearance;

  HeroModel({this.id, this.name, this.powerstats, this.biography, this.image, this.appearance});

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    var powerstats = Powerstats.fromJson(json['powerstats']);
    var biography = Biography.fromJson(json['biography']);
    var appearance = Appearance.fromJson(json['appearance']);
    String image = json['image']['url'];

    return HeroModel(
        id: json['id'],
        name: json['name'],
        powerstats: powerstats,
        biography: biography,
        image: image,
        appearance: appearance);
  }
}

class Appearance {
  final String gender;
  final String race;
  final String height;
  final String weight;

  Appearance({this.gender, this.race, this.height, this.weight});

  factory Appearance.fromJson(Map<String, dynamic> json) {
    return Appearance(
      gender: json['gender'],
      race: json['race'],
      height: json['height'][1],
      weight: json['weight'][1],
    );
  }
}

class Powerstats {
  final String intelligence;
  final String strength;
  final String speed;
  final String durability;
  final String power;
  final String combat;

  Powerstats(
      {this.intelligence,
      this.strength,
      this.speed,
      this.durability,
      this.power,
      this.combat});

  factory Powerstats.fromJson(Map<String, dynamic> json) {
    return Powerstats(
        intelligence: json['intelligence'],
        strength: json['strength'],
        speed: json['speed'],
        durability: json['durability'],
        power: json['power'],
        combat: json['combat']);
  }
}

class Biography {
  final String fullName;
  final String alterEgos;
  final String placeOfBirth;
  final String firstAppearance;
  final String publisher;
  final String alignment;

  Biography(
      {this.fullName,
      this.alterEgos,
      this.placeOfBirth,
      this.firstAppearance,
      this.publisher,
      this.alignment});
  factory Biography.fromJson(Map<String, dynamic> json) {
    return Biography(
        fullName: json['"full-name'],
        alterEgos: json['alter-egos'],
        placeOfBirth: json['place-of-birth'],
        firstAppearance: json['first-appearance'],
        publisher: json['publisher'],
        alignment: json['alignment']);
  }
}
