import 'package:flutter/material.dart';

void main() {
  runApp(const ChaitanyaMathCenterApp());
}

class ChaitanyaMathCenterApp extends StatelessWidget {
  const ChaitanyaMathCenterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chaitanya Math Center',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // Deep Blue (Institute Color)
          primary: const Color(0xFF1E3A8A),
          secondary: const Color(0xFFF59E0B), // Math Accent Gold
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// ------------------- BOTTOM NAVIGATION -------------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),          // Notice Board + Roj ka Timetable
    AttendanceScreen(),    // Haziri + Parents Numbers
    StudyMaterialScreen(), // Separate Folders for Videos & Notes
    SocialFeedScreen(),    // Instagram jaisa Community Feed
    ProfileScreen(),       // Student Profile + PTM & Call Teacher
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.how_to_reg_outlined), selectedIcon: Icon(Icons.how_to_reg), label: 'Haziri'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Study'),
          NavigationDestination(icon: Icon(Icons.amp_stories_outlined), selectedIcon: Icon(Icons.amp_stories), label: 'Feed'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ------------------- SCREEN 1: HOME & TIMETABLE -------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dailyNotice = "Kal subah Class 8:00 AM baje hogi. Integration ka Mega Test hai!";

  void _updateNoticeDialog() {
    TextEditingController controller = TextEditingController(text: dailyNotice);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nayi News / Notice Dalein'),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Notice likhein...'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() => dailyNotice = controller.text);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notice Update Ho Gaya! Sabhi students ko dikhega.')));
            },
            child: const Text('Save & Publish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chaitanya Math Center', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_notifications),
            tooltip: 'Update Notice',
            onPressed: _updateNoticeDialog,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Roj ka Announcement Banner
          Card(
            color: Colors.amber.shade100,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.campaign, color: Colors.orange, size: 38),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Roj ki News / Notice', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(dailyNotice, style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text("Kab, Kahan, Kaunsa Lecture Hai (Timetable)", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          _buildLectureCard("Class 10th (Batch A)", "Maths: Trigonometry", "04:00 PM - 05:30 PM", "Room No. 1", "Sir Chaitanya"),
          _buildLectureCard("Class 12th (Batch B)", "Maths: Calculus & Limits", "05:45 PM - 07:15 PM", "Room No. 2", "Sir Chaitanya"),
          _buildLectureCard("Doubt Session (All)", "Vedic Shortcuts & Problems", "07:30 PM - 08:15 PM", "Main Hall", "Sir Chaitanya"),
        ],
      ),
    );
  }

  Widget _buildLectureCard(String batch, String subject, String time, String room, String teacher) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: const Icon(Icons.access_time, color: Color(0xFF1E3A8A)),
        ),
        title: Text("$batch - $subject", style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Timing: $time\nKahan: $room | Teacher: $teacher"),
      ),
    );
  }
}

// ------------------- SCREEN 2: HAZIRI (ATTENDANCE TRACKER) -------------------
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<Map<String, dynamic>> students = [
    {"name": "Aarav Sharma", "roll": "101", "parentPhone": "+91 98765 43210", "present": true},
    {"name": "Rohan Patil", "roll": "102", "parentPhone": "+91 91234 56789", "present": false},
    {"name": "Sneha Kadam", "roll": "103", "parentPhone": "+91 98220 11223", "present": true},
    {"name": "Aditya Verma", "roll": "104", "parentPhone": "+91 94225 99887", "present": true},
  ];

  void _addNewStudentDialog() {
    final nameCtrl = TextEditingController();
    final rollCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Naya Student & Parent Add Karein'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Student Name')),
            TextField(controller: rollCtrl, decoration: const InputDecoration(labelText: 'Roll Number')),
            TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Parent Mobile Number'), keyboardType: TextInputType.phone),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                setState(() {
                  students.add({
                    "name": nameCtrl.text,
                    "roll": rollCtrl.text,
                    "parentPhone": phoneCtrl.text,
                    "present": true,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add Student'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roj ki Haziri (Attendance)'),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.person_add), tooltip: 'Add Student', onPressed: _addNewStudentDialog)
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.blue.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}", 
                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Attendance Saved! Absent students ke parents ko alert chala gaya.')),
                    );
                  },
                  icon: const Icon(Icons.send, size: 16),
                  label: const Text('Save & Notify Parents'),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E3A8A), foregroundColor: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: student["present"] ? Colors.green.shade100 : Colors.red.shade100,
                      child: Text(student["roll"], style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    title: Text(student["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Parent No: ${student["parentPhone"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ChoiceChip(
                          label: const Text('P', style: TextStyle(fontWeight: FontWeight.bold)),
                          selected: student["present"] == true,
                          selectedColor: Colors.green,
                          onSelected: (val) => setState(() => student["present"] = true),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('A', style: TextStyle(fontWeight: FontWeight.bold)),
                          selected: student["present"] == false,
                          selectedColor: Colors.red,
                          onSelected: (val) => setState(() => student["present"] = false),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------- SCREEN 3: STUDY MATERIAL & VIDEO FOLDERS -------------------
class StudyMaterialScreen extends StatelessWidget {
  const StudyMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Study Material & Lectures'),
          backgroundColor: const Color(0xFF1E3A8A),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.amber,
            indicatorWeight: 3,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.video_library), text: "Video Lectures"),
              Tab(icon: Icon(Icons.picture_as_pdf), text: "Notes & Exams"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Video Folder List
            ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _folderCard(context, "Folder: 10th Math - Trigonometry Videos", "8 Videos Uploaded", Icons.play_circle_fill, Colors.red, [
                  "Lecture 1: Basics & Formulas (42 mins)",
                  "Lecture 2: Height and Distances (38 mins)",
                  "Lecture 3: Board Exam Questions (50 mins)"
                ]),
                _folderCard(context, "Folder: 12th Math - Integration Videos", "14 Videos Uploaded", Icons.play_circle_fill, Colors.red, [
                  "Lecture 1: Definite Integrals (45 mins)",
                  "Lecture 2: Substitution Method (40 mins)",
                  "Lecture 3: Shortcuts & Tricks (35 mins)"
                ]),
                _folderCard(context, "Folder: Vedic Math Short Tricks", "5 Videos Uploaded", Icons.flash_on, Colors.orange, [
                  "Multiply any 2-digit number in 3 seconds",
                  "Square root shortcut trick"
                ]),
              ],
            ),
            // Notes & Exam Materials Folder
            ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _folderCard(context, "Folder: Formula Cheat-Sheets (PDF)", "12 Files", Icons.description, Colors.blue, [
                  "Class 10th Complete Formula Sheet.pdf",
                  "Class 12th Differentiation Formula Book.pdf"
                ]),
                _folderCard(context, "Folder: Upcoming Exam Model Papers", "6 Exam Papers", Icons.assignment, Colors.green, [
                  "Sunday Mock Test Paper 1.pdf",
                  "Previous 5 Years Board Papers.pdf"
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _folderCard(BuildContext context, String title, String sub, IconData icon, Color color, List<String> files) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color, size: 36),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(sub),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Divider(),
                  ...files.map((file) => ListTile(
                    leading: const Icon(Icons.file_present),
                    title: Text(file),
                    trailing: const Icon(Icons.download),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opening $file')));
                    },
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ------------------- SCREEN 4: INSTAGRAM STYLE COMMUNITY FEED -------------------
class SocialFeedScreen extends StatefulWidget {
  const SocialFeedScreen({super.key});

  @override
  State<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends State<SocialFeedScreen> {
  final List<Map<String, dynamic>> posts = [
    {
      "author": "Sir Chaitanya (Teacher)",
      "time": "2 hours ago",
      "text": "Daily Math Challenge: Kya aap bata sakte hain bina pen use kiye?\n\nIf x + 1/x = 5, then what is x² + 1/x² = ?",
      "likes": 28,
      "isLiked": false,
      "comments": ["Sir answer 23 hai!", "23 confirm sir 👍"]
    },
    {
      "author": "Aarav Sharma (Student)",
      "time": "5 hours ago",
      "text": "Sir is problem me step 3 me doubt aa raha hai, please comment me hint de dijiye!",
      "likes": 12,
      "isLiked": false,
      "comments": ["Rationalize karke try karo Aarav."]
    }
  ];

  void _addPostDialog() {
    final textCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Naya Doubt / Post Dalein'),
        content: TextField(
          controller: textCtrl,
          maxLines: 4,
          decoration: const InputDecoration(hintText: 'Apna sawaal ya trick yahan likhein...'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (textCtrl.text.isNotEmpty) {
                setState(() {
                  posts.insert(0, {
                    "author": "Student (You)",
                    "time": "Just now",
                    "text": textCtrl.text,
                    "likes": 0,
                    "isLiked": false,
                    "comments": []
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chaitanya Feed', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(icon: const Icon(Icons.add_box_outlined, size: 28), onPressed: _addPostDialog)
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFF1E3A8A),
                        child: Text(post["author"][0], style: const TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post["author"], style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(post["time"], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                    child: Text(post["text"], style: const TextStyle(fontSize: 15)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(post["isLiked"] ? Icons.favorite : Icons.favorite_border,
                            color: post["isLiked"] ? Colors.red : Colors.black),
                        onPressed: () {
                          setState(() {
                            post["isLiked"] = !post["isLiked"];
                            post["isLiked"] ? post["likes"]++ : post["likes"]--;
                          });
                        },
                      ),
                      Text("${post["likes"]} Likes", style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.chat_bubble_outline),
                        onPressed: () => _openCommentBox(post),
                      ),
                      Text("${post["comments"].length} Comments"),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _openCommentBox(Map<String, dynamic> post) {
    final commentCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Comments / Solutions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(),
            ...List<Widget>.from(post["comments"].map((c) => ListTile(
              leading: const Icon(Icons.person_pin),
              title: Text(c),
            ))),
            TextField(
              controller: commentCtrl,
              decoration: InputDecoration(
                hintText: 'Apna solution ya comment likhein...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (commentCtrl.text.isNotEmpty) {
                      setState(() => post["comments"].add(commentCtrl.text));
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ------------------- SCREEN 5: STUDENT PROFILE & PARENT DESK -------------------
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile & Parent Desk'),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF1E3A8A),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          const Center(child: Text("Aarav Sharma", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          const Center(child: Text("Roll No: 101 | Batch: Class 10th Math", style: TextStyle(color: Colors.grey))),
          const Center(child: Text("Parent: Rajesh Sharma (9876543210)", style: TextStyle(color: Colors.grey))),
          const Divider(height: 32),

          // Direct Teacher Connect & PTM
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Calling Sir Chaitanya (+91 9876543210)...')),
                    );
                  },
                  icon: const Icon(Icons.call),
                  label: const Text('Call Teacher'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Parent Teacher Meeting (PTM)'),
                        content: const Text('Aap Sir Chaitanya se personal meeting request bhejna chahte hain?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PTM Request Sent! Teacher will confirm time.')));
                            },
                            child: const Text('Confirm Request'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.handshake),
                  label: const Text('Request PTM'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Attendance Summary
          Card(
            color: Colors.blue.shade50,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [Text('Total Classes', style: TextStyle(color: Colors.grey)), Text('45', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]),
                  Column(children: [Text('Present', style: TextStyle(color: Colors.green)), Text('42', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green))]),
                  Column(children: [Text('Absent', style: TextStyle(color: Colors.red)), Text('3', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red))]),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Upcoming Exam
          const Text("Upcoming Exams", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Card(
            child: ListTile(
              leading: Icon(Icons.alarm, color: Colors.red),
              title: Text('Trigonometry Mega Test (50 Marks)'),
              subtitle: Text('Date: Next Sunday | Time: 09:00 AM'),
            ),
          ),
          const SizedBox(height: 16),

          // Report Card / Marks
          const Text("Past Exam Marks", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Card(
            child: ListTile(
              leading: Icon(Icons.grade, color: Colors.amber),
              title: Text('Algebra Unit Test'),
              subtitle: Text('Score: 47 / 50 (Rank: 2nd)'),
              trailing: Chip(label: Text('Grade A+', style: TextStyle(color: Colors.green))),
            ),
          ),
        ],
      ),
    );
  }
}