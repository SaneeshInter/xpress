import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ExpandableGroup extends StatefulWidget {

  final bool isExpanded;
  final Widget header;
  final Widget items;
  final Widget? expandedIcon;
  final Widget? collapsedIcon;
  final EdgeInsets? headerEdgeInsets;
  final Color? headerBackgroundColor;

  const ExpandableGroup({Key? key,
    this.isExpanded = false,
    required this.header,
    required this.items,
    this.expandedIcon,
    this.collapsedIcon,
    this.headerEdgeInsets,
    this.headerBackgroundColor})
      : super(key: key);

  @override
  _ExpandableGroupState createState() => _ExpandableGroupState();
}

class _ExpandableGroupState extends State<ExpandableGroup> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _updateExpandState(widget.isExpanded);
  }

  void _updateExpandState(bool isExpanded) =>
      setState(() => _isExpanded = isExpanded);

  @override
  Widget build(BuildContext context) {
    return _isExpanded ? _buildListItems(context) : _wrapHeader();
  }

  Widget _wrapHeader() {
    List<Widget> children = [];
    children.add(ListTile(
      contentPadding: widget.headerEdgeInsets ?? const EdgeInsets.only(left: 0.0, right: 16.0),
      title: widget.header,
      trailing: _isExpanded
          ? widget.expandedIcon ??  Icon(Icons.remove, color: Constants.colors[12])
          : widget.collapsedIcon ??  Icon(Icons.add,color: Constants.colors[12]),
      onTap: () => _updateExpandState(!_isExpanded),
    ));
    return Column(
      children: children,
    );
  }

  Widget _buildListItems(BuildContext context) {
    List<Widget> titles = [];
    titles.add(_wrapHeader());
    titles.add(widget.items);
    return Column(
      children: ListTile.divideTiles(tiles: titles, context: context).toList(),
    );
  }
}