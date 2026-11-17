import 'package:flutter/material.dart';

import 'core/net_image.dart';

/// Sample data for the UI demo. The full app connects to hospital / clinic backends.
class Doctor {
  const Doctor({required this.name, required this.speciality, required this.hospital, required this.exp, required this.rating, required this.reviews, required this.fee, required this.photo, required this.about});
  final String name, speciality, hospital, photo, about;
  final int exp, reviews, fee;
  final double rating;
}

const specialities = <(String, IconData, Color)>[
  ('General', Icons.medical_services_rounded, Color(0xFF2563EB)),
  ('Cardiology', Icons.favorite_rounded, Color(0xFFE11D48)),
  ('Dental', Icons.emoji_emotions_rounded, Color(0xFF0EA5E9)),
  ('Paediatrics', Icons.child_care_rounded, Color(0xFFF59E0B)),
  ('Dermatology', Icons.face_retouching_natural, Color(0xFFA855F7)),
  ('Orthopaedics', Icons.accessibility_new_rounded, Color(0xFF14B8A6)),
  ('Neurology', Icons.psychology_rounded, Color(0xFF6366F1)),
  ('Eye care', Icons.visibility_rounded, Color(0xFF10B981)),
];

final doctors = <Doctor>[
  Doctor(name: 'Dr. Ananya Rao', speciality: 'Cardiologist', hospital: 'Apollo Heart Centre', exp: 14, rating: 4.9, reviews: 1240, fee: 800, photo: unsplash('1559839734-2b71ea197ec2'), about: 'Interventional cardiologist specialising in preventive heart care, hypertension and post-operative rehabilitation.'),
  Doctor(name: 'Dr. Vikram Sethi', speciality: 'Orthopaedic Surgeon', hospital: 'Fortis Bone & Joint', exp: 18, rating: 4.8, reviews: 980, fee: 900, photo: unsplash('1612349317150-e413f6a5b16d'), about: 'Joint replacement and sports injury expert with over 3,000 successful surgeries.'),
  Doctor(name: 'Dr. Kavya Menon', speciality: 'Dermatologist', hospital: 'SkinFirst Clinic', exp: 9, rating: 4.8, reviews: 760, fee: 600, photo: unsplash('1594824476967-48c8b964273f'), about: 'Clinical and cosmetic dermatology: acne, pigmentation, hair loss and laser treatments.'),
  Doctor(name: 'Dr. Arjun Iyer', speciality: 'Paediatrician', hospital: 'Rainbow Children\'s Hospital', exp: 11, rating: 4.9, reviews: 1532, fee: 700, photo: unsplash('1537368910025-700350fe46c7'), about: 'Newborn care, vaccinations and child development, with a gentle approach kids love.'),
  Doctor(name: 'Dr. Rahul Verma', speciality: 'General Physician', hospital: 'CareConnect Clinic', exp: 7, rating: 4.7, reviews: 640, fee: 400, photo: unsplash('1622253692010-333f2da6031d'), about: 'Primary care for fever, infections, diabetes and lifestyle conditions. Online consults available.'),
];

class Appointment {
  const Appointment(this.doctor, this.date, this.time, this.mode, {this.past = false});
  final Doctor doctor;
  final String date, time, mode;
  final bool past;
}

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

/// Dates are relative to today so the demo always looks current.
String dayLabel(int offset) {
  final d = DateTime.now().add(Duration(days: offset));
  return '${_weekdays[d.weekday - 1]}, ${d.day} ${_months[d.month - 1]}';
}

/// Next six bookable days (clinics are closed on Sunday): (weekday, day, month).
List<(String, String, String)> bookableDays() {
  final out = <(String, String, String)>[];
  for (var i = 1; out.length < 6; i++) {
    final d = DateTime.now().add(Duration(days: i));
    if (d.weekday == DateTime.sunday) continue;
    out.add((_weekdays[d.weekday - 1], '${d.day}', _months[d.month - 1]));
  }
  return out;
}

final appointments = <Appointment>[
  Appointment(doctors[0], dayLabel(2), '10:30 AM', 'In-clinic'),
  Appointment(doctors[4], dayLabel(4), '6:00 PM', 'Video call'),
  Appointment(doctors[2], dayLabel(-14), '11:00 AM', 'In-clinic', past: true),
  Appointment(doctors[3], dayLabel(-30), '9:30 AM', 'In-clinic', past: true),
];
