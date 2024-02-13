import 'dart:async';

import 'package:books_app/shared/presentation/extensions/build_context_ext.dart';
import 'package:books_app/shared/presentation/extensions/widget_ext.dart';
import 'package:books_app/shared/presentation/ui/custom/widgets/custom_list_view.dart';
import 'package:books_app/shared/presentation/ui/custom/widgets/custom_search_bar.dart';
import 'package:books_app/shared/presentation/ui/custom/widgets/progress_spinner.dart';
import 'package:flutter/material.dart';
import 'custom_text.dart';
import 'empty_view.dart';

class SearchView<T extends Object> extends StatefulWidget {
  const SearchView({
    super.key,
    required this.items,
    required this.searchBarHintText,
    this.searchBarColor,
    this.enableSelection = true,
    this.enableShadows = false,
    this.padding,
    this.itemPadding,
    this.showItemsFirst = true,
    this.enableKeyboardFirst = false,
    this.showEmptyPage = false,
    this.onSearchResult,
    this.onSearchOverApi,
    this.searchOverApiMapper,
  }) : assert(
          (onSearchOverApi != null && searchOverApiMapper != null) ||
              (onSearchOverApi == null && searchOverApiMapper == null),
          'You must provide both onSearchOverApi and searchOverApiMapper',
        );

  final List<SearchItem<T>> items;
  final String searchBarHintText;
  final Color? searchBarColor;
  final bool enableSelection;
  final bool enableShadows;
  final EdgeInsets? padding;
  final EdgeInsets? itemPadding;
  final bool showItemsFirst;
  final bool enableKeyboardFirst;
  final bool showEmptyPage;
  final void Function(List<SearchItem<T>>, String)? onSearchResult;
  final Future<List<T>> Function(String)? onSearchOverApi;
  final List<SearchItem<T>> Function(List<T>)? searchOverApiMapper;

  @override
  State<SearchView> createState() => _SearchViewState<T>();
}

class _SearchViewState<T extends Object> extends State<SearchView<T>> {
  late List<SearchItem<T>> _items;
  List<SearchItem<T>> _selectedItems = [];
  String _currentSearchText = '';
  Timer? _searchOnStoppedTyping;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _items = widget.items;
    _checkShowItemsFirst();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSearchResult?.call(
        _items.where((e) => e.isVisible).toList(),
        _currentSearchText,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems = _items.where((e) => e.isVisible);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: widget.padding != null
              ? EdgeInsets.fromLTRB(
                  widget.padding!.left,
                  widget.padding!.top,
                  widget.padding!.right,
                  4,
                )
              : EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              SizedBox(height: _currentSearchText.isEmpty ? 4 : 8),
              if (_currentSearchText.isNotEmpty)
                _ResultsText(
                  itemCount: visibleItems.length,
                ),
            ],
          ),
        ),
        visibleItems.isEmpty &&
                widget.showEmptyPage &&
                _currentSearchText.isNotEmpty &&
                !_isSearching
            ? Expanded(
                child: Center(
                  child: EmptyView.builder(
                    text: 'There are  no results for "$_currentSearchText"',
                  ),
                ),
              )
            : Flexible(
                child: _isSearching
                    ? const ProgressSpinner()
                    : CustomListView(
                        items: _items,
                        selectedItems: _selectedItems,
                        selectionEnabled: widget.enableSelection,
                        onItemSelected: (index) {
                          final item = _items
                              .where(
                                (e) => e.isVisible,
                              )
                              .elementAt(index);
                          _selectedItems.add(item);
                          item.onSelected?.call();
                        },
                        padding: widget.padding != null
                            ? EdgeInsets.fromLTRB(
                                widget.padding!.left,
                                widget.padding!.top,
                                widget.padding!.right,
                                widget.padding!.bottom,
                              )
                            : const EdgeInsets.only(top: 16),
                        itemPadding: widget.itemPadding,
                      ),
              ),
      ],
    );
  }

  // Helpers

  Widget _buildSearchBar() {
    return Expanded(
      child: CustomSearchBar(
        hintText: widget.searchBarHintText,
        onTextChanged: widget.onSearchOverApi == null
            ? _searchAndDispatch
            : _searchOverApiWithDelay,
        onSubmitted: widget.onSearchOverApi == null ? _searchAndDispatch : null,
        color: widget.searchBarColor,
        enableKeyboardFirst: widget.enableKeyboardFirst,
        height: 44,
      ).elevated(
        borderRadius: 100,
        isEnabled: widget.enableShadows,
      ),
    );
  }

  void _checkShowItemsFirst() {
    if (!widget.showItemsFirst) {
      for (final item in _items) {
        item.isVisible = false;
      }
    }
  }

  void _searchAndDispatch(String text) {
    if (mounted) {
      setState(() {
        _searchInAllItems(text);
        widget.onSearchResult?.call(
          _items.where((e) => e.isVisible).toList(),
          _currentSearchText,
        );
      });
    }
  }

  void _searchOverApiWithDelay(String text) {
    const duration = Duration(milliseconds: 500);
    if (_searchOnStoppedTyping != null) {
      _searchOnStoppedTyping!.cancel();
    }
    _searchOnStoppedTyping = Timer(duration, () {
      _searchOverApi(text);
    });
  }

  void _searchOverApi(String text) async {
    setState(() => _isSearching = true);
    _currentSearchText = text;
    final searchItems = <SearchItem<T>>[];
    if (_currentSearchText.isNotEmpty) {
      final result = await widget.onSearchOverApi?.call(_currentSearchText);
      searchItems.addAll(
        widget.searchOverApiMapper?.call(result ?? []) ?? [],
      );
    }
    if (mounted) {
      setState(() {
        _items.clear();
        _items.addAll(searchItems);
        _isSearching = false;
        widget.onSearchResult?.call(_items, _currentSearchText);
      });
    }
  }

  void _searchInAllItems(String text) {
    _currentSearchText = text;
    if (mounted) {
      setState(() {
        for (final item in _items) {
          item.isVisible = widget.showItemsFirst
              ? _searchInItem(item, text)
              : text.isEmpty
                  ? false
                  : _searchInItem(item, text);
        }

        widget.onSearchResult?.call(
          _items.where((e) => e.isVisible).toList(),
          _currentSearchText,
        );
      });
    }
  }

  bool _searchInItem(SearchItem item, String text) {
    return item.searchTexts.any(
      (e) => e.contains(RegExp(text, caseSensitive: false)),
    );
  }
  // - Helpers
}

class _ResultsText extends StatelessWidget {
  const _ResultsText({
    required this.itemCount,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          '<b>$itemCount</b> <c>${'results'}</c>',
          style: context.textTheme.bodyMedium,
          tagColor: context.colorScheme.secondary,
        ),
        const Spacer(),
      ],
    );
  }
}

class SearchItem<T extends Object> extends CustomListItem {
  SearchItem({
    required super.widget,
    super.isVisible,
    this.searchObject,
    required this.searchTexts,
    this.onSelected,
  });

  final T? searchObject;
  final List<String> searchTexts;
  final void Function()? onSelected;

  SearchItem<T> copyWith({
    Widget? widget,
    bool? isVisible,
    T? searchObject,
    List<String>? searchTexts,
    void Function()? onSelected,
  }) {
    return SearchItem(
      widget: widget ?? this.widget,
      isVisible: isVisible ?? this.isVisible,
      searchObject: searchObject ?? this.searchObject,
      searchTexts: searchTexts ?? this.searchTexts,
      onSelected: onSelected ?? this.onSelected,
    );
  }
}
