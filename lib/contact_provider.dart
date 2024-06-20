import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contact_model.dart';

class ContactProvider with ChangeNotifier {
  final String _key = "contacts";
  List<Contact> _contactList = [];

  Future<void> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? contactstring = prefs.getString(_key);

    if (contactstring != null) {
      final List<dynamic> decodedJson = jsonDecode(contactstring) as List;
      var list = decodedJson.map((json) => Contact.fromMap(json)).toList();
      _contactList = list;
      notifyListeners();
    }
  }

  Future<void> saveContacts(List<Contact> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedJson =
        jsonEncode(notes.map((todo) => todo.toMap()).toList());
    await prefs.setString(_key, encodedJson);
    loadContacts();
  }

  Future<void> addContact(Contact note) async {
    _contactList.add(note);
    await saveContacts(_contactList);
  }

  Future<void> deletecontact(Contact contact) async {
    _contactList.remove(contact);
    await saveContacts(_contactList);
  }

  void updatecontact(Contact oldData, Contact newData) {
    var index = _contactList.indexOf(oldData);
    _contactList.removeAt(index);
    _contactList.insert(index, newData);
    saveContacts(_contactList);
  }

  List<Contact> get contactList => _contactList;
}
