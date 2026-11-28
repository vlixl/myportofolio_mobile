import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";
  String _techStack = "";
  String _projectUrl = "";
  String _projectImageUrl = "";

  @override
  Widget build(BuildContext context) {
    Widget form = Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleField(),
            _buildDescriptionField(),
            _buildTechStackField(),
            _buildProjectUrlField(),
            _buildProjectImageUrlField(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Project Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 600),
            child: form,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Nama Proyek",
          labelText: "Nama Proyek",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
          setState(() {
            _title = value!;
          });
        },
        validator: (String? value) {
          if (value == null || value.trim().isEmpty) {
            return "Nama proyek tidak boleh kosong!";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: 5,
        decoration: InputDecoration(
          hintText: "Deskripsi Proyek",
          labelText: "Deskripsi Proyek",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
          setState(() {
            _description = value!;
          });
        },
        validator: (String? value) {
          if (value == null || value.trim().isEmpty) {
            return "Deskripsi proyek tidak boleh kosong!";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTechStackField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Contoh: Flutter, Django, Figma",
          labelText: "Teknologi yang Digunakan",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
          setState(() {
            _techStack = value!;
          });
        },
      ),
    );
  }

  Widget _buildProjectUrlField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "URL Proyek (opsional)",
          labelText: "Tautan Proyek",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
          setState(() {
            _projectUrl = value!;
          });
        },
      ),
    );
  }

  Widget _buildProjectImageUrlField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "URL Gambar Proyek (opsional)",
          labelText: "Gambar Proyek",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
          setState(() {
            _projectImageUrl = value!;
          });
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.indigo),
          ),
          onPressed: _submit,
          child: const Text("Save", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;
    if (!_formKey.currentState!.validate()) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;

    try {
      await context.read<ApiClient>().createProject(
        _buildProject(),
        token: token,
      );
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return _buildFormReport();
        },
      );
    } on ApiException catch (e) {
      await _handleApiError(e);
    }
  }

  Project _buildProject() {
    return Project(
      title: _title,
      description: _description,
      techStack: _techStack,
      projectUrl: _projectUrl,
      projectImageUrl: _projectImageUrl,
    );
  }

  Future<void> _handleApiError(ApiException e) async {
    if (!mounted) return;

    // An expired or invalid token: log out and ask the user to log in again
    if (e.statusCode == 401) {
      await context.read<AuthState>().logout();
      if (!mounted) return;
      await ensureLoggedIn(context);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to create project: ${e.statusCode}')),
    );
  }

  Widget _buildFormReport() {
    Widget report = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nama Proyek: $_title'),
        Text('Deskripsi: $_description'),
        Text('Teknologi: $_techStack'),
        Text('Tautan: $_projectUrl'),
        Text('Gambar: $_projectImageUrl'),
      ],
    );

    return AlertDialog(
      title: const Text('Proyek berhasil ditambahkan!'),
      content: SingleChildScrollView(child: report),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
            _formKey.currentState!.reset();
          },
        ),
      ],
    );
  }
}
