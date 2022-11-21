import 'package:equatable/equatable.dart';

// ignore_for_file: must_be_immutable
class AvailableStatesModel extends Equatable {
  bool success;
  List<StateData> state;

  AvailableStatesModel({this.success, this.state});

  AvailableStatesModel.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["data"] is List) {
      state = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => StateData.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if (state != null) {
      _data["data"] = state.map((e) => e.toJson()).toList();
    }
    return _data;
  }

  @override
  List<Object> get props => [state];
}

class StateData {
  int id;
  String name;

  StateData({this.id, this.name});

  StateData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    return _data;
  }
}
