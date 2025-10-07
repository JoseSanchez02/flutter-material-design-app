import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/item.dart';
import '../services/database_service.dart';
import '../utils/responsive_utils.dart';
import 'create_edit_screen.dart';

/// Detail screen showing full item information
class DetailScreen extends StatefulWidget {
  final Item item;

  const DetailScreen({
    super.key,
    required this.item,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final DatabaseService _dbService = DatabaseService();
  late Item _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  /// Navigate to edit screen
  void _navigateToEdit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateEditScreen(item: _item),
      ),
    );

    if (result == true && mounted) {
      // Reload item data
      final updatedItem = await _dbService.getItem(_item.id!);
      if (updatedItem != null) {
        setState(() => _item = updatedItem);
      }
    }
  }

  /// Delete item with confirmation
  void _deleteItem() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text(
            'Are you sure you want to delete this item? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await _dbService.deleteItem(_item.id!);
        if (mounted) {
          Navigator.pop(context, true); // Return to home screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item deleted successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting item: $e')),
          );
        }
      }
    }
  }

  /// Share item (mock implementation)
  void _shareItem() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing: ${_item.title}'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final maxWidth = ResponsiveUtils.getMaxContentWidth(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with hero image
          SliverAppBar(
            expandedHeight: isMobile ? 200 : 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _item.title,
                style: const TextStyle(
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3.0,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              background: Hero(
                tag: 'item_${_item.id}',
                child: _item.imagePath != null
                    ? Image.asset(
                        _item.imagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildImagePlaceholder();
                        },
                      )
                    : _buildImagePlaceholder(),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Action buttons
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.icon(
                            onPressed: _navigateToEdit,
                            icon: const Icon(Icons.edit),
                            label: const Text('Edit'),
                          ),
                          OutlinedButton.icon(
                            onPressed: _shareItem,
                            icon: const Icon(Icons.share),
                            label: const Text('Share'),
                          ),
                          OutlinedButton.icon(
                            onPressed: _deleteItem,
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Description section
                      _SectionCard(
                        title: 'Description',
                        child: Text(
                          _item.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Metadata section
                      _SectionCard(
                        title: 'Information',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _InfoRow(
                              icon: Icons.calendar_today,
                              label: 'Created',
                              value: DateFormat.yMMMd()
                                  .add_jm()
                                  .format(_item.createdAt),
                            ),
                            const SizedBox(height: 12),
                            _InfoRow(
                              icon: Icons.update,
                              label: 'Last Updated',
                              value: DateFormat.yMMMd()
                                  .add_jm()
                                  .format(_item.updatedAt),
                            ),
                            const SizedBox(height: 12),
                            _InfoRow(
                              icon: Icons.tag,
                              label: 'ID',
                              value: '#${_item.id}',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 64,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}

/// Section card for organizing content
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/// Info row for displaying metadata
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
