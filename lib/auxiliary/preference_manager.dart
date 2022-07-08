import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';

class PreferenceManager {
  static bool gotPreferences = false;

  // 0 = Female, 1 = Male
  static int _gender = 0;
  static int _weight = 100;
  static var _unitTypes = ['lbs', 'kg'];
  static var _units = Units.lbs.index;
  static double _strengthLevel = 0;
  static EquipmentLevel _equipmentSelected = EquipmentLevel.none;
  static double _restLevel = 2;
  static bool _setup = true;
  static Map<String, dynamic> _workouts = {};
  static bool _workoutViewIsVertical = false;

  static Future<void> getPreferences(final prefs) async {
    _gender = prefs.getInt('gender') ?? 0;
    _weight = prefs.getInt('weight') ?? 100;
    _units = prefs.getInt('units') ?? Units.lbs.index;
    _strengthLevel = prefs.getDouble('strength-level') ?? 0.0;
    int selectedEquip = prefs.getInt('EquipmentLevel') ?? 0;
    _equipmentSelected = EquipmentLevel.values[selectedEquip];
    _restLevel = prefs.getDouble('rest-level') ?? 0.0;
    _setup = prefs.getBool('setup') ?? false;
    _workoutViewIsVertical = prefs.getBool('workout_view_is_vertical') ?? false;

    //Get Calendar Events from Preferences
    String json = prefs.getString('workout-events') ?? "";
    //convert from json to
    if (json.isNotEmpty) {
      _workouts = jsonDecode(json);
    } else {
      _workouts = {};
    }
  }

  static Future<void> setPreferenceBool(key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<void> setPreferenceInt(key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<void> setPreferenceDouble(key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  static Future<void> setPreferenceString(key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static addWorkout(String hashCode, Map<String, dynamic> workout) {
    _workouts[hashCode] = workout;
    setPreferenceString('workout-events', jsonEncode(_workouts));
  }

  //Getters
  static int getGender() {
    return _gender;
  }

  static int getWeight() {
    return _weight;
  }

  static List<String> getUnitTypes() {
    return _unitTypes;
  }

  static int getUnits() {
    return _units;
  }

  static double getStrengthLevel() {
    return _strengthLevel;
  }

  static EquipmentLevel getEquipmentLevel() {
    return _equipmentSelected;
  }

  static double getRestLevel() {
    return _restLevel;
  }

  static bool getSetup() {
    return _setup;
  }

  static List<Map<String, dynamic>?> getWorkout(DateTime? day) {
    return day == null
        ? []
        : _workouts[getHashCode(day).toString()] == null
            ? []
            : [_workouts[getHashCode(day).toString()]];
  }

  static bool getWorkoutViewIsVertical() {
    return _workoutViewIsVertical;
  }

  //Setters
  static void setGender(int value) {
    _gender = value;
    setPreferenceInt('gender', value);
  }

  static void setWeight(int value) {
    _weight = value;
    setPreferenceInt('weight', value);
  }

  static void setUnits(int value) {
    _units = value;
    setPreferenceInt('units', value);
  }

  static void setStrengthLevel(double value) {
    _strengthLevel = value;
    setPreferenceDouble('strength-level', value);
  }

  static void setEquipmentLevel(int value) {
    _equipmentSelected = EquipmentLevel.values[value];
    setPreferenceInt('EquipmentLevel', value);
  }

  static void setRestLevel(double value, {bool save = true}) {
    _restLevel = value;
    if (save) {
      setPreferenceDouble('rest-level', value);
    }
  }

  static void setSetup(bool value) {
    _setup = value;
    setPreferenceBool('setup', value);
  }

  static void toggleWorkoutViewIsVertical() {
    _workoutViewIsVertical = !_workoutViewIsVertical;
    setPreferenceBool('workout_view_is_vertical', _workoutViewIsVertical);
  }

  static String toJson() {
    Map map = {
      "gender": _gender,
      "weight": _weight,
      "unitTypes": _unitTypes,
      "units": _units,
      "strengthLevel": _strengthLevel,
      "equipmentSelected": _equipmentSelected.index,
      "restLevel": _restLevel,
      "setup": _setup,
      "workouts": _workouts
    };
    String json = jsonEncode(map);
    return json;
  }

  static String fromJson(String json) {
    Map map = jsonDecode(json);
    try {
      _gender = map["gender"];
      _weight = map["weight"];
      _unitTypes = map["unitTypes"];
      _units = map[_units];
      _strengthLevel = map["strengthLevel"];
      _equipmentSelected = EquipmentLevel.values[map["equipmentSelected"]];
      _restLevel = map["equipmentSelected"];
      _setup = map["setup"];
      _workouts = map["workouts"];
    } catch (e) {
      //do something based off of the error
      //Print Error to screen?
      return "ERROR: Make sure you have the right file";
    }
    return "Information Uploaded Successfully";
  }
}
