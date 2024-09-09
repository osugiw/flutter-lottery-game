import 'package:flutter/material.dart';
import 'text_theme.dart';

// Card Empty Data
class EmptyDataCard extends StatelessWidget {
  const EmptyDataCard({super.key,required this.text,});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5.0, // Shadow
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(text, style: emptyTextStyle, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

// Card for Winner
class WinnerCard extends StatelessWidget {
  const WinnerCard({super.key,required this.text,});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5.0, // Shadow
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(text, ),
        ),
      ),
    );
  }
}

// Card Widget for participant list
class ParticipantCard extends StatelessWidget {
  const ParticipantCard(
      {super.key, required this.participantName, required this.nik});

  final String participantName;
  final String nik;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: const Color.fromARGB(255, 184, 10, 10),
        child: SizedBox(
          width: 500,
          child: IntrinsicHeight(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    child: 
                      Text(nik.toString(), style: participantListStyle, textAlign: TextAlign.left)
                  ),
                ),
                const VerticalDivider(
                  width: 10,
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    child: 
                      Text(participantName, style: participantListStyle, textAlign: TextAlign.left)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
