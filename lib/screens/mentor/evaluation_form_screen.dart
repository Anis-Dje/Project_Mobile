import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/user.dart';

/// Mentor evaluation entry form.
///
/// Spiral 1: pure UI. Spiral 2/3 wire it to `submit_evaluation.php`.
class EvaluationFormScreen extends StatefulWidget {
  final User intern;

  const EvaluationFormScreen({super.key, required this.intern});

  @override
  State<EvaluationFormScreen> createState() => _EvaluationFormScreenState();
}

class _EvaluationFormScreenState extends State<EvaluationFormScreen> {
  final TextEditingController _scoreController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _scoreController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Evaluation saved for ${widget.intern.name} (mock — Spiral 3 wires the API)',
        ),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final User intern = widget.intern;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluate intern'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        intern.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${intern.department} • ${intern.email}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _scoreController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Score (0–20)',
                  prefixIcon: Icon(Icons.star_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a score';
                  }
                  final int? parsed = int.tryParse(value);
                  if (parsed == null || parsed < 0 || parsed > 20) {
                    return 'Score must be between 0 and 20';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Feedback',
                  alignLabelWithHint: true,
                ),
                validator: (value) =>
                    (value == null || value.trim().isEmpty)
                        ? 'Please write feedback'
                        : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.send_outlined),
                label: const Text('Submit evaluation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
