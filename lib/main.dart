import 'package:flutter/material.dart';

void main() {
  runApp(const MobileCourseApp());
}

class MobileCourseApp extends StatelessWidget {
  const MobileCourseApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Mes devoirs',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const AssignmentsPage(),
      );
}

class Assignment {
  Assignment({required this.title, required this.course});
  final String title;
  final String course;
  bool isDone = false;
}

class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({super.key});

  @override
  State<AssignmentsPage> createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  final List<Assignment> _assignments = [
    Assignment(title: 'Préparer le premier exercice', course: 'Programmation mobile'),
    Assignment(title: 'Lire le chapitre sur les widgets', course: 'Flutter'),
  ];

  void _addAssignment(String title, String course) {
    setState(() => _assignments.insert(0, Assignment(title: title, course: course)));
  }

  Future<void> _showAddDialog() async {
    final titleController = TextEditingController();
    final courseController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ajouter un devoir'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Nom du devoir'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Saisissez un nom'
                    : null,
              ),
              TextFormField(
                controller: courseController,
                decoration: const InputDecoration(labelText: 'Cours'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Saisissez le nom du cours'
                    : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(dialogContext, true);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
    if (result == true) {
      _addAssignment(titleController.text.trim(), courseController.text.trim());
    }
    titleController.dispose();
    courseController.dispose();
  }

  void _toggleAssignment(Assignment assignment, bool? value) {
    setState(() => assignment.isDone = value ?? false);
  }

  void _deleteAssignment(Assignment assignment) {
    setState(() => _assignments.remove(assignment));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Devoir supprimé')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final remaining = _assignments.where((item) => !item.isDone).length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes devoirs'),
        actions: [
          IconButton(
            tooltip: 'Ajouter un devoir',
            onPressed: _showAddDialog,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          _SummaryCard(remaining: remaining, total: _assignments.length),
          Expanded(
            child: _assignments.isEmpty
                ? const _EmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: _assignments.length,
                    itemBuilder: (context, index) {
                      final assignment = _assignments[index];
                      return Card(
                        child: CheckboxListTile(
                          value: assignment.isDone,
                          onChanged: (value) => _toggleAssignment(assignment, value),
                          title: Text(
                            assignment.title,
                            style: TextStyle(
                              decoration: assignment.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          subtitle: Text(assignment.course),
                          secondary: IconButton(
                            tooltip: 'Supprimer ' + assignment.title,
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _deleteAssignment(assignment),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        icon: const Icon(Icons.add),
        label: const Text('Nouveau devoir'),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.remaining, required this.total});
  final int remaining;
  final int total;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.all(16),
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.school)),
          title: Text(remaining.toString() + ' devoir(s) à faire'),
          subtitle: Text(total.toString() + ' devoir(s) au total'),
        ),
      );
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) => const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.task_alt, size: 56),
              SizedBox(height: 12),
              Text('Aucun devoir pour le moment'),
              Text('Appuyez sur « Nouveau devoir » pour commencer.'),
            ],
          ),
        ),
      );
}
