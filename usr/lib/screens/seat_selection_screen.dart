import 'package:flutter/material.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> busDetails;

  const SeatSelectionScreen({super.key, required this.busDetails});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final Set<int> _selectedSeats = {};
  final int _totalSeats = 40;
  final List<int> _bookedSeats = [5, 6, 15, 25, 26]; // Dummy booked seats

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Seats for ${widget.busDetails['name']}"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _totalSeats,
              itemBuilder: (context, index) {
                // Add a gap for the aisle
                if (index % 5 == 2) {
                  return Container();
                }

                final seatNumber = index - (index ~/ 5) * 1;
                final isBooked = _bookedSeats.contains(seatNumber + 1);
                final isSelected = _selectedSeats.contains(seatNumber + 1);

                return GestureDetector(
                  onTap: () {
                    if (!isBooked) {
                      setState(() {
                        if (isSelected) {
                          _selectedSeats.remove(seatNumber + 1);
                        } else {
                          _selectedSeats.add(seatNumber + 1);
                        }
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isBooked
                          ? Colors.grey
                          : isSelected
                              ? Colors.red
                              : Colors.green,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text(
                        "${seatNumber + 1}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Selected Seats: ${_selectedSeats.join(', ')}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  "Total Price: ₹${_selectedSeats.length * widget.busDetails['price']}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: _selectedSeats.isNotEmpty
                      ? () {
                          // TODO: Implement booking confirmation
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Booking for seats ${_selectedSeats.join(', ')} confirmed!"),
                            ),
                          );
                        }
                      : null,
                  child: const Text("Proceed to Book"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
