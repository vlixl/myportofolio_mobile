import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/achievement/achievement_form.dart';
import 'package:myportofolio_mobile/screens/project/project_form.dart';
import 'package:myportofolio_mobile/screens/project/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:myportofolio_mobile/widgets/menu_cards.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  final void Function(BuildContext context) onTap;

  ItemHomepage(this.name, this.icon, this.color, this.onTap);
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506611856";
  final String nama = "Leow Vincent Vintizel";
  final String kelas = "PBP F";

  late final List<ItemHomepage> items = [
    ItemHomepage(
      "View Projects",
      Icons.folder,
      Colors.purple,
      (BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProjectListScreen()),
      ),
    ),

    ItemHomepage("Add Project", Icons.add_circle, Colors.blue, (
      BuildContext context,
    ) async {
      if (!await ensureLoggedIn(context)) return;
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProjectFormPage()),
      );
    }),

    ItemHomepage(
      "Add Achievement",
      Icons.add_circle,
      Colors.lightBlue,
      (BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AchievementFormPage()),
      ),
    ),

    ItemHomepage("Logout", Icons.logout, Colors.red, (BuildContext context) {
      context.read<AuthState>().logout();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Logout successful')));
    }),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            const SizedBox(height: 16.0),

            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Welcome to MyPortfolio Mobile!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
