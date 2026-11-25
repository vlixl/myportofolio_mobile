import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (project.projectImageUrl.isNotEmpty)
                Image.network(project.projectImageUrl),
              Text(project.title),
              Text(project.techStack),
              Text(project.description),
              if (project.projectUrl.isNotEmpty) Text(project.projectUrl),
            ],
          ),
        ),
      ),
    );
  }
}
