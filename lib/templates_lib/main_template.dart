import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_client/pages/course_page.dart';
import 'package:placed_client/pages/homepage.dart'; // Update with the actual location of your HomePage
import 'package:placed_client/pages/resume_ques.dart';
import 'package:placed_client/pages/saved_courses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:placed_client/models/user_model.dart';
import 'package:provider/provider.dart';



class MainTemplate extends StatelessWidget {
  final String title;
  final Widget child;
  final int currentIndex;

  MainTemplate({
    required this.title,
    required this.child,
    this.currentIndex = 0,
  });

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SavedCourses()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResumeQuesPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      appBar: mainAppBar(context, title),
      body: SingleChildScrollView(child: child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _navigateToPage(context, index), // Navigation logic
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Resume'),
        ],
      ),
    );
  }

  AppBar mainAppBar(BuildContext context, String title) {
    User? user = FirebaseAuth.instance.currentUser;  // Get the current user
    return AppBar(
      backgroundColor: const Color(0xFF479539),
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: title.substring(0, title.length - 1),
                ),
                TextSpan(
                  text: title.substring(title.length - 1),
                  style: const TextStyle(
                    color: Color(0xFF515151),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      leadingWidth: 300, // Adjust the width to accommodate the title
      title: const SizedBox.shrink(), // Hide the default title
      actions: [
        user == null || user.photoURL == null
            ? IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              )
            : Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile'); // Navigate to Profile
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(user.photoURL!),
                  ),
                ),
              ),
      ],
      toolbarHeight: 36, // Add the toolbarHeight property
    );
  }
}
