import 'package:books_app/shared/presentation/ui/custom/widgets/container_group.dart';
import 'package:flutter/material.dart';

import '../../../extensions/build_context_ext.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({
    super.key,
    required this.items,
    this.selectedItems,
    this.selectionEnabled,
    this.padding,
    this.itemPadding,
    this.itemSpacing = 14,
    this.onItemSelected,
  });

  final List<CustomListItem> items;
  final List<CustomListItem>? selectedItems;
  final bool? selectionEnabled;
  final EdgeInsets? padding;
  final EdgeInsets? itemPadding;
  final double itemSpacing;
  final void Function(int)? onItemSelected;

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: widget.padding,
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          _buildContainerGroup(),
        ],
      ),
    );
  }

  // Helpers
  Widget _buildContainerGroup() {
    return ContainerGroup(
      selectionEnabled: widget.selectionEnabled ?? true,
      containerColor: context.colorScheme.primaryContainer,
      containerPadding: widget.itemPadding ??
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
      itemSpacing: widget.itemSpacing,
      selectedIndexes: widget.selectedItems != null
          ? widget.items
              .asMap()
              .entries
              .where((e) => widget.selectedItems!.contains(e.value))
              .map((e) => e.key)
              .toList()
          : null,
      onItemSelected: widget.onItemSelected,
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    return widget.items.where((e) => e.isVisible).map((e) => e.widget).toList();
  }

  // - Helpers
}

class CustomListItem {
  CustomListItem({
    required this.widget,
    bool? isVisible,
  }) : isVisible = isVisible ?? true;

  final Widget widget;
  bool isVisible;
}
