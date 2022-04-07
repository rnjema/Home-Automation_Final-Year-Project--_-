class AppControl {
  Map<String, RelayModel>? relays;

  AppControl({
    this.relays,
  });
}

class RelayModel {
  int? status;
  Map<String, double>? energy;

  RelayModel({
    this.status,
    this.energy,
  });

  factory RelayModel.fromMap(map) {
    return RelayModel(
      status: map['state'],
      energy: map['energy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'state': status,
      'energy': energy,
    };
  }
}
