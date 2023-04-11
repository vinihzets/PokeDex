class PokemonEvosEntity {
  int? id;
  String? num;
  String? name;
  String? img;
  List<NextEvolution>? nextEvolution;
  List<PrevEvolution>? prevEvolution;

  PokemonEvosEntity(
      {this.id,
      this.num,
      this.name,
      this.img,
      this.nextEvolution,
      this.prevEvolution});

  factory PokemonEvosEntity.fromJson(Map<String, dynamic> json) {
    final List<NextEvolution> nextEvolution = [];
    if (json['next_evolution'] != null) {
      json['next_evolution'].forEach((v) {
        nextEvolution.add(NextEvolution.fromJson(v));
      });
    }
    final List<PrevEvolution> prevEvolution = [];
    if (json['prev_evolution'] != null) {
      json['prev_evolution'].forEach((v) {
        prevEvolution.add(PrevEvolution.fromJson(v));
      });
    }
    return PokemonEvosEntity(
        id: json['id'],
        num: json['num'],
        name: json['name'],
        img: json['img'],
        nextEvolution: nextEvolution,
        prevEvolution: prevEvolution);
  }
}

class NextEvolution {
  String? num;
  String? name;

  NextEvolution({this.num, this.name});

  NextEvolution.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['num'];
    data['name'];
    return data;
  }
}

class PrevEvolution {
  String? num;
  String? name;

  PrevEvolution({this.num, this.name});

  PrevEvolution.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['num'];
    data['name'];

    return data;
  }
}
