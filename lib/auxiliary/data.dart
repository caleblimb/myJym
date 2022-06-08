import 'package:flutter/material.dart';

enum MuscleGroup {
  legs,
  core,
  upper,
}

enum Units {
  lbs,
  kg
}

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

  static const workouts = {
    'bench_press': {
      'index': 0,
      'name': 'Bench Press',
      'units': 'Bodyweight Ratio',
      'key': 'bench_press',
      'preference_key': 'bench_press',
      'male_levels': [0.50, 0.625, 0.75, 1.00, 1.25, 1.5, 1.75, 1.875, 2.00],
      'female_levels': [0.25, 0.375, 0.50, 0.625, 0.75, 0.875, 1.0, 1.25, 1.50],
      'focus': MuscleGroup.upper
    },
    'squat': {
      'index': 1,
      'name': 'Squat',
      'units': 'Bodyweight Ratio',
      'key': 'squat',
      'male_levels': [0.75, 1.00, 1.25, 1.375, 1.50, 1.875, 2.25, 2.5, 2.75],
      'female_levels': [0.50, 0.625, 0.75, 1, 1.25, 1.375, 1.50, 1.75, 2.0],
      'focus': MuscleGroup.legs
    },
    'dead_lift': {
      'index': 2,
      'name': 'Deadlift',
      'units': 'Bodyweight Ratio',
      'key': 'dead_lift',
      'male_levels': [1.00, 1.125, 1.25, 1.625, 2.00, 2.25, 2.50, 2.75, 3.00],
      'female_levels': [0.50, 0.75, 1.00, 1.125, 1.25, 1.50, 1.75, 2.125, 2.50],
      'focus': MuscleGroup.upper
    },
    'shoulder_press': {
      'index': 3,
      'name': 'Shoulder Press',
      'units': 'Bodyweight Ratio',
      'key': 'shoulder_press',
      'male_levels': [0.35, 0.45, 0.55, 0.675, 0.80, 0.925, 1.05, 1.20, 1.35],
      'female_levels': [0.20, 0.55, 0.35, 0.425, 0.50, 0.625, 0.75, 0.85, 0.95],
      'focus': MuscleGroup.upper
    },
    'pull_ups': {
      'index': 4,
      'name': 'Pull Ups',
      'units': 'Reps',
      'key': 'pull_ups',
      'male_levels': [0.0, 1.0, 4.0, 8.0, 13.0, 18.0, 24.0, 30.0, 36.0],
      'female_levels': [0.0, 0.0, 0.0, 1.0, 6.0, 10.0, 14.0, 19.0, 24.0],
      'focus': MuscleGroup.upper
    },
    'dumbbell_bench_press': {
      'index': 5,
      'name': 'Dumbbell Bench Press',
      'units': 'Bodyweight Ratio',
      'key': 'dumbbell_bench_press',
      'male_levels': [0.20, 0.275, 0.35, 0.425, 0.50, 0.60, 0.70, 0.85, 0.95],
      'female_levels': [0.10, 0.15, 0.20, 0.25, 0.30, 0.40, 0.50, 0.60, 0.70],
      'focus': MuscleGroup.upper
    },
    'dumbbell_curl': {
      'index': 6,
      'name': 'Dumbbell Curl',
      'units': 'Bodyweight Ratio',
      'key': 'dumbbell_curl',
      'male_levels': [0.10, 0.125, 0.15, 0.225, 0.30, 0.375, 0.45, 0.55, 0.65],
      'female_levels': [0.05, 0.075, 0.10, 0.15, 0.20, 0.25, 0.30, 0.375, 0.45],
      'focus': MuscleGroup.upper
    },
    'barbell_curl': {
      'index': 7,
      'name': 'Barbell Curl',
      'units': 'Bodyweight Ratio',
      'key': 'barbell_curl',
      'male_levels': [0.20, 0.30, 0.40, 0.50, 0.60, 0.725, 0.85, 1.00, 1.15],
      'female_levels': [0.10, 0.15, 0.20, 0.30, 0.40, 0.50, 0.60, 0.725, 0.85],
      'focus': MuscleGroup.upper
    },
    'bent_over_row': {
      'index': 8,
      'name': 'Bent Over Row',
      'units': 'Bodyweight Ratio',
      'key': 'bent_over_row',
      'male_levels': [0.50, 0.625, 0.75, 0.875, 1.00, 1.25, 1.50, 1.625, 1.75],
      'female_levels': [0.25, 0.325, 0.40, 0.525, 0.65, 0.775, 0.90, 1.05, 1.20],
      'focus': MuscleGroup.upper
    },
    'push_ups': {
      'index': 9,
      'name': 'Push Ups',
      'units': 'Reps',
      'key': 'push_ups',
      'male_levels': [0.0, 5.0, 16.0, 26.0, 40.0, 52.0, 68.0, 82.0, 100.0],
      'female_levels': [0.0, 1.0, .0, 10.0, 18.0, 25.0, 35.0, 44.0, 54.0],
      'focus': MuscleGroup.upper
    },
    'dumbbell_shoulder_press': {
      'index': 10,
      'name': 'Dumbbell Shoulder Press',
      'units': 'Bodyweight Ratio',
      'key': 'dumbbell_shoulder_press',
      'male_levels': [0.15, 0.20, 0.25, 0.325, 0.40, 0.475, 0.55, 1.30, 0.75],
      'female_levels': [0.10, 0.125, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45],
      'focus': MuscleGroup.upper
    },
    'front_squat': {
      'index': 11,
      'name': 'Front Squat',
      'units': 'Bodyweight Ratio',
      'key': 'front_squat',
      'male_levels': [0.75, 0.875, 1.00, 1.125, 1.25, 1.50, 1.75, 1.875, 2.00],
      'female_levels': [0.50, 0.625, 0.75, 0.875, 1.0, 1.125, 1.25, 1.375, 1.50],
      'focus': MuscleGroup.legs
    }
  };

}
