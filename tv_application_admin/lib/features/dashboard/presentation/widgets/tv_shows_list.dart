import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_applications_client/tv_applications_client.dart';
import 'package:tv_application_admin/core/ui/components/button.dart';
import 'package:tv_application_admin/core/ui/components/input.dart';
import 'package:tv_application_admin/features/dashboard/presentation/providers/tv_shows_provider.dart';

class TVShowsList extends StatelessWidget {
  const TVShowsList({super.key});

  void _showTVShowDetails(BuildContext context, Media tvShow) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tvShow.title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('URL: ${tvShow.url}'),
              Text('Type: ${tvShow.type.name}'),
              if (tvShow.channelsUrl != null)
                Text('Channels URL: ${tvShow.channelsUrl}'),
              Text('Thumbnail URL: ${tvShow.thumbnailUrl}'),
              if (tvShow.type == Type.shows) ...[
                const SizedBox(height: 16),
                const Text(
                  'Movies',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (tvShow.shows == null || tvShow.shows!.isEmpty)
                  const Text('No media added yet')
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tvShow.shows!.length,
                    itemBuilder: (context, index) {
                      final movie = tvShow.shows![index];
                      return ListTile(
                        title: Text(movie.title ?? 'Untitled'),
                        subtitle: Text(movie.url ?? 'No URL'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showEditMovieDialog(
                                context,
                                tvShow.id!,
                                movie,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                if (tvShow.id != null && movie.id != null) {
                                  context
                                      .read<TVShowsProvider>()
                                      .removeMovieFromShow(tvShow.id!, movie.id!);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 16),
                _AddMovieForm(tvShowId: tvShow.id),
              ],
            ],
          ),
        ),
        actions: [
          ShadcnButton(
            variant: ButtonVariant.ghost,
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ShadcnButton(
            onPressed: () => _showEditTVShowDialog(context, tvShow),
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  void _showEditTVShowDialog(BuildContext context, Media tvShow) {
    final titleController = TextEditingController(text: tvShow.title);
    final urlController = TextEditingController(text: tvShow.url);
    final thumbnailUrlController = TextEditingController(text: tvShow.thumbnailUrl);
    final channelsUrlController = TextEditingController(text: tvShow.channelsUrl);
    var selectedType = tvShow.type;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Media'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShadcnInput(
                controller: titleController,
                label: 'Title',
                hintText: 'Enter Media title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              ShadcnInput(
                controller: urlController,
                label: 'URL',
                hintText: 'Enter Media URL',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              ShadcnInput(
                controller: thumbnailUrlController,
                label: 'Thumbnail URL',
                hintText: 'Enter thumbnail URL',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a thumbnail URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              ShadcnInput(
                controller: channelsUrlController,
                label: 'Channels URL (Optional)',
                hintText: 'Enter channels URL',
              ),
              const SizedBox(height: 8),
              // DropdownButtonFormField<Type>(
              //   value: selectedType,
              //   decoration: const InputDecoration(
              //     labelText: 'Type',
              //   ),
              //   items: Type.values.map((type) {
              //     return DropdownMenuItem(
              //       value: type,
              //       child: Text(type.name),
              //     );
              //   }).toList(),
              //   onChanged: (value) {
              //     if (value != null) {
              //       selectedType = value;
              //     }
              //   },
              // ),
              DropdownButtonFormField<Type>(
                value: selectedType,
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
                    selectedType = value;
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          ShadcnButton(
            variant: ButtonVariant.ghost,
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ShadcnButton(
            onPressed: () {
              if (tvShow.id != null) {
                final updatedTVShow = tvShow.copyWith(
                  title: titleController.text,
                  url: urlController.text,
                  thumbnailUrl: thumbnailUrlController.text,
                  channelsUrl: channelsUrlController.text.isEmpty
                      ? null
                      : channelsUrlController.text,
                  type: selectedType,
                );
                context.read<TVShowsProvider>().updateTVShow(updatedTVShow);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEditMovieDialog(BuildContext context, int tvShowId, Movie movie) {
    final titleController = TextEditingController(text: movie.title);
    final urlController = TextEditingController(text: movie.url);
    final thumbnailUrlController = TextEditingController(text: movie.thumbnailUrl);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Movie'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShadcnInput(
                controller: titleController,
                label: 'Title',
                hintText: 'Enter movie title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              ShadcnInput(
                controller: urlController,
                label: 'URL',
                hintText: 'Enter movie URL',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              ShadcnInput(
                controller: thumbnailUrlController,
                label: 'Thumbnail URL',
                hintText: 'Enter thumbnail URL',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a thumbnail URL';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          ShadcnButton(
            variant: ButtonVariant.ghost,
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ShadcnButton(
            onPressed: () {
              if (movie.id != null) {
                final updatedMovie = movie.copyWith(
                  title: titleController.text,
                  url: urlController.text,
                  thumbnailUrl: thumbnailUrlController.text,
                );
                context
                    .read<TVShowsProvider>()
                    .updateMovieInShow(tvShowId, updatedMovie);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TVShowsProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Media List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (provider.tvShows.isEmpty)
              const Center(
                child: Text('No TV shows found'),
              )
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Title')),
                    DataColumn(label: Text('Type')),
                    DataColumn(label: Text('URL')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: provider.tvShows.map((tvShow) {
                    return DataRow(
                      cells: [
                        DataCell(
                          InkWell(
                            onTap: () => _showTVShowDetails(context, tvShow),
                            child: Text(tvShow.title),
                          ),
                        ),
                        DataCell(Text(tvShow.type.name)),
                        DataCell(Text(tvShow.url)),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _showEditTVShowDialog(context, tvShow),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  if (tvShow.id != null) {
                                    provider.deleteTVShow(tvShow);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AddMovieForm extends StatefulWidget {
  final int? tvShowId;

  const _AddMovieForm({required this.tvShowId});

  @override
  State<_AddMovieForm> createState() => _AddMovieFormState();
}

class _AddMovieFormState extends State<_AddMovieForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
  final _thumbnailUrlController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    _thumbnailUrlController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate() || widget.tvShowId == null) return;

    final movie = Movie(
      title: _titleController.text,
      url: _urlController.text,
      thumbnailUrl: _thumbnailUrlController.text,
    );

    context.read<TVShowsProvider>().addMovieToShow(widget.tvShowId!, movie);

    _titleController.clear();
    _urlController.clear();
    _thumbnailUrlController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TVShowsProvider>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Movie',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ShadcnInput(
            controller: _titleController,
            label: 'Title',
            hintText: 'Enter movie title',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          ShadcnInput(
            controller: _urlController,
            label: 'URL',
            hintText: 'Enter movie URL',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a URL';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
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
          const SizedBox(height: 8),
          ShadcnButton(
            onPressed: provider.isLoading ? null : _submitForm,
            isLoading: provider.isLoading,
            isFullWidth: true,
            child: const Text('Add Movie'),
          ),
        ],
      ),
    );
  }
} 