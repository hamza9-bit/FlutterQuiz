import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzapp2/Models/UserEnAttente.dart';

class DatabaseService {
  final CollectionReference UserEnAttenteCollection =
      FirebaseFirestore.instance.collection('usersEnAttente');

  String generateRandomUserId(int length) {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  Future<bool> addUsersEnAttenteToDb(UserEnAttente userEnAttente) async {
    try {
      await UserEnAttenteCollection.doc(userEnAttente.id)
          .set(userEnAttente.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<bool> checkAcceptance(String id) {
    return UserEnAttenteCollection.doc(id)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      var res = documentSnapshot.data() as Map<String, dynamic>;

      return res['accepted'] as bool;
    });
  }

  Stream<bool> checkRefused(String id) {
    return UserEnAttenteCollection.doc(id)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      var res = documentSnapshot.data() as Map<String, dynamic>;

      return res['refused'] as bool;
    });
  }

  Future<bool> acceptUserToQuiz(UserEnAttente userEnAttente) async {
    try {
      await UserEnAttenteCollection.doc().set(userEnAttente.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
