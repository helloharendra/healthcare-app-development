import 'package:flutter/material.dart';

import '../core/contact.dart';
import '../core/net_image.dart';
import '../data.dart';
import '../main.dart';
import 'doctor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final next = appointments.first;
    return SafeArea(
      child: ListView(padding: const EdgeInsets.fromLTRB(20, 12, 20, 100), children: [
        Row(children: [
          const Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Good morning 👋', style: TextStyle(color: Colors.black54)),
              Text('Neha Sharma', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            ]),
          ),
          IconButton.filledTonal(onPressed: () => Contact.show(context, appName, 'Medicine & Appointment Reminders'), icon: const Badge(smallSize: 8, child: Icon(Icons.notifications_none_rounded))),
        ]),
        const SizedBox(height: 18),
        TextField(
          readOnly: true,
          onTap: () => Contact.show(context, appName, 'Search Doctors, Clinics & Symptoms'),
          decoration: InputDecoration(
            hintText: 'Search doctors, symptoms, clinics…',
            prefixIcon: const Icon(Icons.search_rounded),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 20),
        // Upcoming appointment card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF4F46E5)]),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: brand.withValues(alpha: .35), blurRadius: 24, offset: const Offset(0, 10))],
          ),
          child: Column(children: [
            Row(children: [
              CircleAvatar(radius: 26, backgroundColor: Colors.white24, child: ClipOval(child: NetImage(next.doctor.photo, width: 48, height: 48))),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(next.doctor.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  Text(next.doctor.speciality, style: const TextStyle(color: Colors.white70)),
                ]),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.white),
            ]),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: .15), borderRadius: BorderRadius.circular(14)),
              child: Row(children: [
                const Icon(Icons.calendar_today_rounded, color: Colors.white, size: 16),
                const SizedBox(width: 6),
                Text(next.date, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                const Spacer(),
                const Icon(Icons.access_time_rounded, color: Colors.white, size: 16),
                const SizedBox(width: 6),
                Text(next.time, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ]),
            ),
          ]),
        ),
        const SizedBox(height: 24),
        const Text('Find by speciality', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: .85,
          children: specialities
              .map((s) => InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => Contact.show(context, appName, '${s.$1} doctors & clinics'),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        CircleAvatar(backgroundColor: s.$3.withValues(alpha: .12), child: Icon(s.$2, color: s.$3)),
                        const SizedBox(height: 6),
                        Text(s.$1, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                      ]),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 24),
        Row(children: [
          const Expanded(child: Text('Top doctors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))),
          TextButton(onPressed: () => Contact.show(context, appName, 'Doctor Directory & Filters'), child: const Text('See all')),
        ]),
        ...doctors.map((d) => _DoctorTile(d)),
      ]),
    );
  }
}

class _DoctorTile extends StatelessWidget {
  const _DoctorTile(this.d);
  final Doctor d;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorScreen(d))),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Row(children: [
            Hero(tag: d.name, child: NetImage(d.photo, width: 76, height: 76, radius: 16)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(d.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                Text('${d.speciality} · ${d.exp} yrs', style: const TextStyle(color: Colors.black54, fontSize: 13)),
                const SizedBox(height: 6),
                Row(children: [
                  const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 18),
                  Text(' ${d.rating}', style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text(' (${d.reviews})', style: const TextStyle(color: Colors.black45, fontSize: 12)),
                  const Spacer(),
                  Text('₹${d.fee}', style: const TextStyle(fontWeight: FontWeight.w800, color: brand)),
                ]),
              ]),
            ),
          ]),
        ),
      );
}
