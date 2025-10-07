import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/database_service.dart';
import '../utils/responsive_utils.dart';
import 'detail_screen.dart';
import 'create_edit_screen.dart';
import 'settings_screen.dart';

/// Home screen displaying a responsive grid/list of items
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Item> _items = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  /// Load items from database
  Future<void> _loadItems() async {
    setState(() => _isLoading = true);
    try {
      final items = _searchQuery.isEmpty
          ? await _dbService.getAllItems()
          : await _dbService.searchItems(_searchQuery);
      setState(() {
        _items = items;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading items: $e')),
        );
      }
    }
  }

  /// Navigate to create screen
  void _navigateToCreate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateEditScreen(),
      ),
    );
    if (result == true) {
      _loadItems();
    }
  }

  /// Navigate to detail screen
  void _navigateToDetail(Item item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(item: item),
      ),
    );
    if (result == true) {
      _loadItems();
    }
  }

  /// Navigate to settings screen
  void _navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveUtils.getGridColumns(context);
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Material Dashboard',
          semanticsLabel: 'Material Dashboard Home',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: _navigateToSettings,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: padding.left, vertical: 8),
            child: SearchBar(
              hintText: 'Search items...',
              leading: const Icon(Icons.search),
              onChanged: (value) {
                setState(() => _searchQuery = value);
                _loadItems();
              },
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _searchQuery.isEmpty
                            ? 'No items yet'
                            : 'No items found',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _searchQuery.isEmpty
                            ? 'Tap the + button to create your first item'
                            : 'Try a different search term',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadItems,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Use master-detail layout on larger screens in landscape
                      if (ResponsiveUtils.shouldUseMasterDetail(context)) {
                        return _buildMasterDetailLayout();
                      }
                      // Use grid layout for smaller screens
                      return _buildGridLayout(columns, spacing, padding);
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToCreate,
        icon: const Icon(Icons.add),
        label: const Text('New Item'),
        tooltip: 'Create new item',
      ),
    );
  }

  /// Build grid layout for items
  Widget _buildGridLayout(int columns, double spacing, EdgeInsets padding) {
    return GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 0.75,
      ),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return _ItemCard(
          item: _items[index],
          onTap: () => _navigateToDetail(_items[index]),
        );
      },
    );
  }

  /// Build master-detail layout for tablets
  Widget _buildMasterDetailLayout() {
    return Row(
      children: [
        // Master panel (list)
        SizedBox(
          width: 400,
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(_items[index].title[0]),
                ),
                title: Text(_items[index].title),
                subtitle: Text(
                  _items[index].description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => _navigateToDetail(_items[index]),
              );
            },
          ),
        ),
        const VerticalDivider(width: 1),
        // Detail panel
        Expanded(
          child: Center(
            child: Text(
              'Select an item to view details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}

/// Card widget for displaying an item
class _ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;

  const _ItemCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: item.imagePath != null
                    ? Image.asset(
                        item.imagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder(context);
                        },
                      )
                    : _buildPlaceholder(context),
              ),
            ),
            // Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Flexible(
                      child: Text(
                        item.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Icon(
      Icons.image_outlined,
      size: 48,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
    );
  }
}
