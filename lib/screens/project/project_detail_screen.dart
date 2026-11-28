import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;
  final Color color;

  const ProjectDetailScreen({
    super.key,
    required this.project,
    this.color = Colors.indigo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pastel = Color.lerp(theme.colorScheme.surface, color, 0.10);
    final accent = Color.lerp(color, theme.colorScheme.onSurface, 0.4);

    final icon = CircleAvatar(
      radius: 32,
      backgroundColor: color,
      foregroundColor: Colors.white,
      child: const Icon(Icons.code, size: 32),
    );

    final title = Text(
      project.title,
      style: theme.textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );

    final techStack = Chip(
      label: Text(project.techStack, style: TextStyle(color: accent)),
      backgroundColor: color.withValues(alpha: 0.12),
      shape: const StadiumBorder(),
      side: BorderSide.none,
    );

    final hero = Card(
      elevation: 0,
      color: pastel,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [icon, title, techStack],
        ),
      ),
    );

    final description = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About this project',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            project.description,
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
        ],
      ),
    );

    final projectLink = Card(
      elevation: 0,
      color: pastel,
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: Icon(Icons.link, color: accent),
        title: const Text('Project URL'),
        subtitle: SelectableText(
          project.projectUrl,
          style: TextStyle(color: accent),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Project Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              spacing: 24,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                hero,
                if (project.projectImageUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(project.projectImageUrl),
                  ),
                description,
                if (project.projectUrl.isNotEmpty) projectLink,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
