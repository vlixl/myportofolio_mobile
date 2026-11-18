import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class AchievementFormPage extends StatefulWidget {
  const AchievementFormPage({super.key});

  @override
  State<AchievementFormPage> createState() => _AchievementFormPageState();
}

class _AchievementFormPageState extends State<AchievementFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _award = "";
  String _category = "";
  String _month = "January";
  String _year = "";
  String _event = "";
  String _organizer = "";
  String _description = "";

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {

    Widget form = Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAwardField(),
            _buildCategoryField(),
            _buildMonthField(),
            _buildYearField(),
            _buildEventField(),
            _buildOrganizerField(),
            _buildDescriptionField(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Achievement Form')),
        backgroundColor: Colors.green,
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

  Widget _buildAwardField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "1st Place",
          labelText: "Award",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
          setState(() {
            _award = value!;
          });
        },
        validator: (String? value) {
          if (value == null || value.trim().isEmpty) {
            return "Award must not be empty!";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCategoryField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Example: Mathematics, English, etc. (Optional)",
          labelText: "Category",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
          setState(() {
            _category = value!;
          });
        },
      ),
    );
  }

  Widget _buildMonthField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "Month",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        initialValue: _month,
        items: _months
            .map(
              (category) =>
                  DropdownMenuItem(value: category, child: Text(category)),
            )
            .toList(),
        onChanged: (String? newValue) {
          setState(() {
            _month = newValue!;
          });
        },
      ),
    );
  }

  Widget _buildYearField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "2026",
          labelText: "Year",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
          setState(() {
            _year = value!;
          });
        },
        validator: (String? value) {
          if (value == null || value.trim().isEmpty) {
            return "Year must not be empty!";
          } else {
            final num = int.tryParse(value);

            if (num == null || num < 0) {
              return "Year must be a positive number!";
            }
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEventField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Example: Olimpiade Sains Nasional",
          labelText: "Event",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
          setState(() {
            _event = value!;
          });
        },
        validator: (String? value) {
          if (value == null || value.trim().isEmpty) {
            return "Event must not be empty!";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildOrganizerField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Example: Pusat Prestasi Nasional",
          labelText: "Organizer",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
          setState(() {
            _organizer = value!;
          });
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
          hintText: "Achievement Description",
          labelText: "Description",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
          setState(() {
            _description = value!;
          });
        },
        validator: (String? value) {
          if (value == null || value.trim().isEmpty) {
            return "Description must not be empty!";
          }
          return null;
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              showDialog(
                context: context,
                builder: (context) {
                  return _buildFormReport();
                },
              );
            }
          },
          child: const Text("Save", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildFormReport() {
    Widget report = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Award: $_award'),
        Text('Category: $_category'),
        Text('Month: $_month'),
        Text('Year: $_year'),
        Text('Event: $_event'),
        Text('Organization: $_organizer'),
        Text('Description: $_description'),
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
