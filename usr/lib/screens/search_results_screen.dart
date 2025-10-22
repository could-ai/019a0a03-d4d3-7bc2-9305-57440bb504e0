import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/seat_selection_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  final String from;
  final String to;
  final DateTime date;

  const SearchResultsScreen({
    super.key,
    required this.from,
    required this.to,
    required this.date,
  });

  // Dummy data for bus list
  final List<Map<String, dynamic>> busList = const [
    {
      "name": "Greenline Express",
      "type": "AC Sleeper",
      "departure": "10:00 PM",
      "arrival": "06:00 AM",
      "duration": "8h",
      "price": 1200,
      "rating": 4.5,
    },
    {
      "name": "Red Dragon",
      "type": "Non-AC Seater",
      "departure": "09:00 PM",
      "arrival": "07:00 AM",
      "duration": "10h",
      "price": 800,
      "rating": 4.2,
    },
    {
      "name": "Blue Bird",
      "type": "AC Seater",
      "departure": "11:00 PM",
      "arrival": "07:30 AM",
      "duration": "8h 30m",
      "price": 1000,
      "rating": 4.8,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$from to $to"),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: busList.length,
        itemBuilder: (context, index) {
          final bus = busList[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(bus["name"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bus["type"]),
                  Text("Dep: ${bus["departure"]} - Arr: ${bus["arrival"]}"),
                  Text("Duration: ${bus["duration"]}"),
                  Text(
                    "Price: ₹${bus["price"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeatSelectionScreen(busDetails: bus),
                      ),
                    );
                },
                child: const Text("Select Seats"),
              ),
            ),
          );
        },
      ),
    );
  }
}
