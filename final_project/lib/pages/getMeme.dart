import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final int totalMemes = 17182; // Make sure this matches the total count of documents in Firestore

  Future<String> getRandomMemeText() async {
    int randomIndex = Random().nextInt(totalMemes); // Generate a random index
    var querySnapshot = await _db.collection('Alternate Text') // Ensure this matches your collection name
        .where('index', isEqualTo: randomIndex) // Ensure 'index' field exists in all documents
        .limit(1)
        .get();
    var documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      return documents.first.data()['Alternate Text']; // Replace 'Alternate Text' with the exact field name for the meme text
    } else {
      return 'No meme found for the generated index.';
    }
  }
}
