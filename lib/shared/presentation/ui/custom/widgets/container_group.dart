import 'package:flutter/material.dart';

import 'container_card.dart';

class ContainerGroup extends StatefulWidget {
  const ContainerGroup({
    super.key,
    this.selectedIndexes,
    this.containerColor,
    this.containerPadding = const EdgeInsets.all(12),
    this.groupPadding,
    this.enableShadows = true,
    this.itemSpacing = 14,
    this.enableSplash = false,
    this.onItemSelected,
    this.selectionEnabled = true,
    required this.children,
  });

  final List<int>? selectedIndexes;
  final Color? containerColor;
  final EdgeInsets containerPadding;
  final EdgeInsets? groupPadding;
  final bool enableShadows;
  final double itemSpacing;
  final bool enableSplash;
  final bool selectionEnabled;
  final void Function(int index)? onItemSelected;
  final List<Widget> children;

  @override
  State<ContainerGroup> createState() => _ContainerGroupState();
}

class _ContainerGroupState extends State<ContainerGroup> {
  List<int> _selectedIndexes = [];

  @override
  void initState() {
    super.initState();
    _selectedIndexes = widget.selectedIndexes ?? [];
  }

  @override
  void didUpdateWidget(covariant ContainerGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedIndexes = widget.selectedIndexes ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.groupPadding,
      itemCount: widget.children.length,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < widget.children.length - 1 ? widget.itemSpacing : 0,
          ),
          child: ContainerCard(
            backgroundColor: widget.containerColor,
            padding: widget.containerPadding,
            enableShadows: widget.enableShadows,
            hideArrowIcon: true,
            enableBorder: widget.selectionEnabled
                ? (_selectedIndexes.contains(index))
                : false,
            enableSplash: widget.enableSplash,
            onDoubleTap: () {
              if (_selectedIndexes.contains(index) && widget.selectionEnabled) {
                return;
              }
              setState(() {
                _selectedIndexes.add(index);
                widget.onItemSelected?.call(index);
              });
            },
            onLongPress: () {
              if (!_selectedIndexes.contains(index) &&
                  widget.selectionEnabled) {
                return;
              }
              setState(() {
                _selectedIndexes.remove(index);
                widget.onItemSelected?.call(index);
              });
            },
            child: widget.children[index],
          ),
        );
      },
    );
  }
}
