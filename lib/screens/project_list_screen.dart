import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/screens/project_detail_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = context.read<ApiClient>().getProjects();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getProjects();
    setState(() {
      _projectsFuture = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Project>>(
        future: _projectsFuture,
        builder: _screenBuilder,
      ),
    );
  }

  Widget _screenBuilder(
    BuildContext context,
    AsyncSnapshot<List<Project>> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return _buildErrorScreen(snapshot);
    }
    final projects = snapshot.data ?? const <Project>[];

    if (projects.isEmpty) {
      return _buildEmptyScreen();
    }

    return _buildListScreen(projects);
  }

  Widget _buildErrorScreen(AsyncSnapshot<List<Project>> snapshot) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Failed to load projects: ${snapshot.error}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _reload,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyScreen() {
    return RefreshIndicator(
      onRefresh: _reload,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Center(child: Text('No projects found.')),
      ),
    );
  }

  Widget _buildListScreen(List<Project> projects) {
    return RefreshIndicator(
      onRefresh: _reload,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: projects.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return _buildHeader();

          return buildColorfulCard(projects[index - 1], index - 1);
        },
      ),
    );
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PORTFOLIO',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              letterSpacing: 3,
            ),
          ),
          Text(
            'My Projects',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'A collection of ideas brought to life through code.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Color getCardColor(int index) {
    const colors = [
      Colors.red,
      Colors.orange,
      Colors.amber,
      Colors.teal,
      Colors.indigo,
      Colors.deepPurple,
    ];

    return colors[index % colors.length];
  }

  Widget buildColorfulCard(Project project, int index) {
    final theme = Theme.of(context);
    final color = getCardColor(index);

    final icon = CircleAvatar(
      radius: 24,
      backgroundColor: color,
      foregroundColor: Colors.white,
      child: const Icon(Icons.code),
    );

    final title = Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(project.title, style: theme.textTheme.titleLarge),
    );

    final subtitle = Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Chip(
          label: Text(
            project.techStack,
            style: TextStyle(color: Color.lerp(color, Colors.black, 0.2)),
          ),
          backgroundColor: color.withValues(alpha: 0.2),
          shape: const StadiumBorder(),
          side: BorderSide.none,
        ),
        Text(
          project.description,
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
      ],
    );

    return Card(
      color: Color.lerp(theme.colorScheme.surface, color, 0.08),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.all(24),
        horizontalTitleGap: 20,
        leading: icon,
        title: title,
        subtitle: subtitle,
        trailing: Icon(Icons.chevron_right_rounded, color: color),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProjectDetailScreen(project: project, color: color),
          ),
        ),
      ),
    );
  }
}
