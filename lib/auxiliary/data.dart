enum Units { lbs, kg }

enum EquipmentLevel {
  none,
  basic,
  full,
}

enum Equipment {
  barbell,
  bench,
  rack,
  bar,
  dumbbell,
  workoutPad,
}

enum Exercise {
  benchPress,
  squat,
  deadLift,
  shoulderPress,
  pullUps,
  dumbbellBenchPress,
  dumbbellCurl,
  barbellCurl,
  bentOverRow,
  pushUps,
  dumbbellShoulderPress,
  frontSquat,
}

enum Category {
  legs,
  full,
  torso,
  push,
  pull,
}

enum setStyle {
  standard,
  strength,
  endurance,
  burnouts,
}

enum repUnit {
  bodyWeightRatio,
  count,
}

String getHashCode(DateTime key) {
  return (key.day * 1000000 + key.month * 10000 + key.year).toString();
}

const workoutIntensityRestLevels = [
  {'label': 'Leisure', 'description': '~2min between workouts', 'rest': 2.0},
  {'label': 'Paced', 'description': '~1.5min between workouts', 'rest': 1.5},
  {'label': 'Dedicated', 'description': '~45s between workouts', 'rest': .75},
  {'label': 'Intense', 'description': '~30s between workouts', 'rest': .5},
  {'label': 'EXTREME', 'description': 'No rest between workouts', 'rest': 0.167},
];

class Data {
  static const strengthLevels = [
    {'label': 'Beginner'},
    {'label': 'Beginner-Novice'},
    {'label': 'Novice'},
    {'label': 'Novice-Intermediate'},
    {'label': 'Intermediate'},
    {'label': 'Intermediate-Advanced'},
    {'label': 'Advanced'},
    {'label': 'Advanced-Elite'},
    {'label': 'Elite'}
  ];

  static const categoryInfo = {
    Category.legs: [
      Exercise.squat,
      Exercise.frontSquat,
    ],
    Category.full: [
      Exercise.squat,
      Exercise.frontSquat,
      Exercise.benchPress,
      Exercise.deadLift,
      Exercise.shoulderPress,
      Exercise.pullUps,
      Exercise.dumbbellBenchPress,
      Exercise.dumbbellCurl,
      Exercise.barbellCurl,
      Exercise.bentOverRow,
      Exercise.pushUps,
      Exercise.dumbbellShoulderPress,
      Exercise.benchPress,
      Exercise.shoulderPress,
      Exercise.dumbbellBenchPress,
      Exercise.pushUps,
      Exercise.dumbbellShoulderPress,
      Exercise.deadLift,
      Exercise.pullUps,
      Exercise.dumbbellCurl,
      Exercise.barbellCurl,
      Exercise.bentOverRow,
    ],
    Category.torso: [
      Exercise.benchPress,
      Exercise.deadLift,
      Exercise.shoulderPress,
      Exercise.pullUps,
      Exercise.dumbbellBenchPress,
      Exercise.dumbbellCurl,
      Exercise.barbellCurl,
      Exercise.bentOverRow,
      Exercise.pushUps,
      Exercise.dumbbellShoulderPress,
    ],
    Category.push: [
      Exercise.benchPress,
      Exercise.shoulderPress,
      Exercise.dumbbellBenchPress,
      Exercise.pushUps,
      Exercise.dumbbellShoulderPress,
    ],
    Category.pull: [
      Exercise.deadLift,
      Exercise.pullUps,
      Exercise.dumbbellCurl,
      Exercise.barbellCurl,
      Exercise.bentOverRow,
    ],
  };

  static const exerciseInfo = {
    Exercise.benchPress: {
      'index': 0,
      'name': 'Bench Press',
      'units': repUnit.bodyWeightRatio,
      'key': 'bench_press',
      'preference_key': 'bench_press',
      'male_levels': [0.50, 0.625, 0.75, 1.00, 1.25, 1.5, 1.75, 1.875, 2.00],
      'female_levels': [0.25, 0.375, 0.50, 0.625, 0.75, 0.875, 1.0, 1.25, 1.50],
      'equipment': [Equipment.barbell, Equipment.bench, Equipment.rack]
    },
    Exercise.squat: {
      'index': 1,
      'name': 'Squat',
      'units': repUnit.bodyWeightRatio,
      'key': 'squat',
      'male_levels': [0.75, 1.00, 1.25, 1.375, 1.50, 1.875, 2.25, 2.5, 2.75],
      'female_levels': [0.50, 0.625, 0.75, 1, 1.25, 1.375, 1.50, 1.75, 2.0],
      'equipment': [Equipment.barbell, Equipment.rack]
    },
    Exercise.deadLift: {
      'index': 2,
      'name': 'Deadlift',
      'units': repUnit.bodyWeightRatio,
      'key': 'dead_lift',
      'male_levels': [1.00, 1.125, 1.25, 1.625, 2.00, 2.25, 2.50, 2.75, 3.00],
      'female_levels': [0.50, 0.75, 1.00, 1.125, 1.25, 1.50, 1.75, 2.125, 2.50],
      'equipment': [Equipment.barbell]
    },
    Exercise.shoulderPress: {
      'index': 3,
      'name': 'Shoulder Press',
      'units': repUnit.bodyWeightRatio,
      'key': 'shoulder_press',
      'male_levels': [0.35, 0.45, 0.55, 0.675, 0.80, 0.925, 1.05, 1.20, 1.35],
      'female_levels': [0.20, 0.55, 0.35, 0.425, 0.50, 0.625, 0.75, 0.85, 0.95],
      'equipment': [Equipment.barbell, Equipment.rack]
    },
    Exercise.pullUps: {
      'index': 4,
      'name': 'Pull Ups',
      'units': repUnit.count,
      'key': 'pull_ups',
      'male_levels': [0.0, 1.0, 4.0, 8.0, 13.0, 18.0, 24.0, 30.0, 36.0],
      'female_levels': [0.0, 0.0, 0.0, 1.0, 6.0, 10.0, 14.0, 19.0, 24.0],
      'equipment': [Equipment.bar]
    },
    Exercise.dumbbellBenchPress: {
      'index': 5,
      'name': 'Dumbbell Bench Press',
      'units': repUnit.bodyWeightRatio,
      'key': 'dumbbell_bench_press',
      'male_levels': [0.20, 0.275, 0.35, 0.425, 0.50, 0.60, 0.70, 0.85, 0.95],
      'female_levels': [0.10, 0.15, 0.20, 0.25, 0.30, 0.40, 0.50, 0.60, 0.70],
      'equipment': [Equipment.bench, Equipment.dumbbell]
    },
    Exercise.dumbbellCurl: {
      'index': 6,
      'name': 'Dumbbell Curl',
      'units': repUnit.bodyWeightRatio,
      'key': 'dumbbell_curl',
      'male_levels': [0.10, 0.125, 0.15, 0.225, 0.30, 0.375, 0.45, 0.55, 0.65],
      'female_levels': [0.05, 0.075, 0.10, 0.15, 0.20, 0.25, 0.30, 0.375, 0.45],
      'equipment': [Equipment.dumbbell]
    },
    Exercise.barbellCurl: {
      'index': 7,
      'name': 'Barbell Curl',
      'units': repUnit.bodyWeightRatio,
      'key': 'barbell_curl',
      'male_levels': [0.20, 0.30, 0.40, 0.50, 0.60, 0.725, 0.85, 1.00, 1.15],
      'female_levels': [0.10, 0.15, 0.20, 0.30, 0.40, 0.50, 0.60, 0.725, 0.85],
      'equipment': [Equipment.barbell, Equipment.rack]
    },
    Exercise.bentOverRow: {
      'index': 8,
      'name': 'Bent Over Row',
      'units': repUnit.bodyWeightRatio,
      'key': 'bent_over_row',
      'male_levels': [0.50, 0.625, 0.75, 0.875, 1.00, 1.25, 1.50, 1.625, 1.75],
      'female_levels': [0.25, 0.325, 0.40, 0.525, 0.65, 0.775, 0.90, 1.05, 1.2],
      'equipment': [Equipment.barbell, Equipment.rack]
    },
    Exercise.pushUps: {
      'index': 9,
      'name': 'Push Ups',
      'units': repUnit.count,
      'key': 'push_ups',
      'male_levels': [1.0, 8.0, 18.0, 30.0, 41.0, 54.0, 68.0, 72.0, 99.0],
      'female_levels': [1.0, 2.0, 5.0, 11.0, 19.0, 26.0, 35.0, 42.0, 56.0],
      'equipment': []
    },
    Exercise.dumbbellShoulderPress: {
      'index': 10,
      'name': 'Dumbbell Shoulder Press',
      'units': repUnit.bodyWeightRatio,
      'key': 'dumbbell_shoulder_press',
      'male_levels': [0.15, 0.20, 0.25, 0.325, 0.40, 0.475, 0.55, 1.30, 0.75],
      'female_levels': [0.10, 0.125, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45],
      'equipment': [Equipment.dumbbell, Equipment.bench]
    },
    Exercise.frontSquat: {
      'index': 11,
      'name': 'Front Squat',
      'units': repUnit.bodyWeightRatio,
      'key': 'front_squat',
      'male_levels': [0.75, 0.875, 1.00, 1.125, 1.25, 1.50, 1.75, 1.875, 2.00],
      'female_levels': [0.50, 0.625, 0.75, 0.875, 1.0, 1.125, 1.25, 1.375, 1.5],
      'equipment': [Equipment.barbell, Equipment.rack]
    }
  };

  static const setStyleInfo = {
    setStyle.standard: [
      {
        'weight': 0.70,
        'reps': 10,
      },
      {
        'weight': 0.70,
        'reps': 10,
      },
      {
        'weight': 0.70,
        'reps': 10,
      },
    ],
  };
  static const equipmentInfo = {
    EquipmentLevel.none: [],
    EquipmentLevel.basic: [
      Equipment.dumbbell,
      Equipment.workoutPad,
    ],
    EquipmentLevel.full: [
      Equipment.barbell,
      Equipment.bench,
      Equipment.rack,
      Equipment.bar,
      Equipment.dumbbell,
      Equipment.workoutPad,
    ],
  };
}
