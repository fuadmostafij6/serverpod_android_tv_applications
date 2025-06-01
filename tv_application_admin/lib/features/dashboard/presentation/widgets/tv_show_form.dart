import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_applications_client/tv_applications_client.dart';
import 'package:tv_application_admin/core/ui/components/button.dart';
import 'package:tv_application_admin/core/ui/components/input.dart';
import 'package:tv_application_admin/features/dashboard/presentation/providers/tv_shows_provider.dart';

class TVShowForm extends StatefulWidget {
  const TVShowForm({super.key});

  @override
  State<TVShowForm> createState() => _TVShowFormState();
}

class _TVShowFormState extends State<TVShowForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
  final _thumbnailUrlController = TextEditingController();
  final _channelsUrlController = TextEditingController();
  Type _selectedType = Type.shows;
  final List<TextEditingController> _mediaControllers = [];
  final List<TextEditingController> _mediaTitleControllers = [];
  final List<TextEditingController> _mediaThumbnail = [];

  @override
  void initState() {
    super.initState();
    _addMediaField();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    _thumbnailUrlController.dispose();
    _channelsUrlController.dispose();
    for (var controller in _mediaControllers) {
      controller.dispose();
    }
    for (var controller in _mediaTitleControllers) {
      controller.dispose();
    }
    for (var controller in _mediaThumbnail) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addMediaField() {
    setState(() {
      _mediaControllers.add(TextEditingController());
      _mediaTitleControllers.add(TextEditingController());
      _mediaThumbnail.add(TextEditingController());
    });
  }

  void _removeMediaField(int index) {
    setState(() {
      _mediaControllers[index].dispose();
      _mediaTitleControllers[index].dispose();
      _mediaControllers.removeAt(index);
      _mediaTitleControllers.removeAt(index);
    });
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<TVShowsProvider>();
    final List<Movie> shows = _selectedType == Type.shows
        ? List.generate(
            _mediaControllers.length,
            (index) => Movie(
              title: _mediaTitleControllers[index].text,
              url: _mediaControllers[index].text,
              thumbnailUrl: _mediaThumbnail[index].text.isEmpty
                  ? null
                  : _mediaThumbnail[index].text,
            ),
          )
        : [];

    provider.addTVShow(
      title: _titleController.text,
      url: _urlController.text,
      type: _selectedType,
      thumbnailUrl: _thumbnailUrlController.text,
      channelsUrl: _channelsUrlController.text.isEmpty
          ? null
          : _channelsUrlController.text,
      shows: shows,
    );

    _titleController.clear();
    _urlController.clear();
    _thumbnailUrlController.clear();
    _channelsUrlController.clear();
    for (var controller in _mediaControllers) {
      controller.clear();
    }
    for (var controller in _mediaTitleControllers) {
      controller.clear();
    }
    setState(() {
      _selectedType = Type.shows;
      _mediaControllers.clear();
      _mediaTitleControllers.clear();
      _addMediaField();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TVShowsProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Media',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ShadcnInput(
                controller: _titleController,
                label: 'Title',
                hintText: 'Enter Media title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ShadcnInput(
                controller: _urlController,
                label: 'URL',
                hintText: 'Enter Media URL',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ShadcnInput(
                controller: _thumbnailUrlController,
                label: 'Thumbnail URL',
                hintText: 'Enter thumbnail URL',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a thumbnail URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_selectedType != Type.shows) ...[
                ShadcnInput(
                  controller: _channelsUrlController,
                  label: 'Channels URL (Optional)',
                  hintText: 'Enter channels URL',
                ),
                const SizedBox(height: 16),
              ],
              DropdownButtonFormField<Type>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                ),
                items: Type.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
              ),
              if (_selectedType == Type.shows) ...[
                const SizedBox(height: 24),
                const Text(
                  'Media',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...List.generate(_mediaControllers.length, (index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ShadcnInput(
                              controller: _mediaTitleControllers[index],
                              label: 'Movie Title',
                              hintText: 'Enter movie title',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a movie title';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ShadcnInput(
                              controller: _mediaControllers[index],
                              label: 'Movie URL',
                              hintText: 'Enter movie URL',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a movie URL';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: _mediaControllers.length > 1
                                ? () => _removeMediaField(index)
                                : null,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }),
                ShadcnButton(
                  onPressed: _addMediaField,
                  isFullWidth: true,
                  child: const Text('Add Movie'),
                ),
              ],
              const SizedBox(height: 24),
              ShadcnButton(
                onPressed: provider.isLoading ? null : _submitForm,
                isLoading: provider.isLoading,
                isFullWidth: true,
                child: const Text('Add TV Show'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 