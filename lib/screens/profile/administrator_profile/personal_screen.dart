import 'dart:async';
import 'dart:developer';

import 'package:academ_gora_release/components/search_widget.dart';
import 'package:academ_gora_release/data_keepers/admin_keeper.dart';
import 'package:academ_gora_release/data_keepers/instructors_keeper.dart';
import 'package:academ_gora_release/data_keepers/user_keepaers.dart';
import 'package:academ_gora_release/model/administrator.dart';
import 'package:academ_gora_release/model/instructor.dart';
import 'package:academ_gora_release/model/personal.dart';
import 'package:academ_gora_release/screens/extension.dart';
import 'package:flutter/material.dart';

class PersonalScreeen extends StatefulWidget {
  const PersonalScreeen({Key? key}) : super(key: key);

  @override
  _PersonalScreeenState createState() => _PersonalScreeenState();
}

final UsersKeeper _userKeeper = UsersKeeper();
final InstructorsKeeper _instructorKeeper = InstructorsKeeper();
final AdminKeeper _adminKeeper = AdminKeeper();

class _PersonalScreeenState extends State<PersonalScreeen> {
  String query = '';
  Timer? debouncer;
  List<User> personalList = [];
  List<User> filteredPersonList = [];
  List<Instructor> instructorlist = [];
  List<Instructor> filteredInstructorList = [];
  List<Adminstrator> adminlist = [];
  List<Adminstrator> filteredAdminList = [];
  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _getUsers();
    filteredPersonList = personalList;

    _getAdmins();
    filteredAdminList = adminlist;

    _getInstructors();
    filteredInstructorList = instructorlist;

    super.initState();
  }

  void _getUsers() {
    personalList = _userKeeper.getAllPersons();
  }

  void _getAdmins() {
    adminlist = _adminKeeper.getAllPersons();
  }

  void _getInstructors() {
    instructorlist = _instructorKeeper.instructorsList;
  }

  void search(String query) {
    filteredPersonList = [];
    filteredInstructorList = [];
    filteredAdminList = [];

    final person = personalList.where((user) {
      final titleLower = user.phone ?? user.phone!.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    final instructor = instructorlist.where((user) {
      final titleLower = user.phone ?? user.phone!.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    final admin = adminlist.where((user) {
      final titleLower = user.phone ?? user.phone!.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      query = query;
      filteredPersonList = person;
      filteredInstructorList = instructor;
      filteredAdminList = admin;
    });
  }

  void searchInAdmins() {
    filteredAdminList = [];
    final user = adminlist.where((user) {
      final titleLower = user.phone ?? user.phone!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      query = query;
      filteredAdminList = user;
    });
  }

  void makeInstructorToAdmin() {}
  void makeInstructorToUser() {}
  void makeAdminToUser() {}
  void makeAdminToInstructor() {}
  void makeUserToInstructor() {}
  void makeUserToAdmin() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: screenDecoration("assets/all_instructors/bg.png"),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 32, bottom: 20, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSearch(),
                const SizedBox(
                  height: 8,
                ),
                buildInstructionText(),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildRoleText("Инструкторы:"),
                  ],
                ),
                Column(
                  children: List.generate(
                    filteredInstructorList.length,
                    (int index) {
                      return buildInstructor(filteredInstructorList[index]);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildRoleText("Администраторы:"),
                  ],
                ),
                Column(
                  children: List.generate(
                    filteredAdminList.length,
                    (int index) {
                      return buildAdministrator(filteredAdminList[index]);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildRoleText("Персонали:"),
                  ],
                ),
                Column(
                  children: List.generate(
                    filteredPersonList.length,
                    (int index) {
                      return buildUser(filteredPersonList[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRoleText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget buildInstructionText() {
    return const Text(
      "Чтобы изменить ролы, свайпайте влево или вправо, нужного элемента",
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget buildUser(User user) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.phone.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          buildLine()
        ],
      ),
    );
  }

  Widget buildInstructor(Instructor user) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user.phone.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                user.name.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            user.kindOfSport.toString(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
          buildLine()
        ],
      ),
    );
  }

  Widget buildAdministrator(Adminstrator user) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.phone.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          buildLine()
        ],
      ),
    );
  }

  Widget buildLine() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
          height: 1,
          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5))),
    );
  }

  Widget buildSearch() => SearchWidget(
      text: query, hintText: 'Введите номер юзера', onChanged: search);
}