import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:ginko/utils/custom_row.dart';
import 'package:ginko/utils/icons_texts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ginko/models/models.dart';

// ignore: public_member_api_docs
class CafetoriaRow extends StatefulWidget {
  // ignore: public_member_api_docs
  const CafetoriaRow({
    @required this.day,
    @required this.menu,
    this.showDate = false,
    this.showSplit = true,
  });

  // ignore: public_member_api_docs
  final CafetoriaDay day;

  // ignore: public_member_api_docs
  final CafetoriaMenu menu;

  // ignore: public_member_api_docs
  final bool showDate;

  // ignore: public_member_api_docs
  final bool showSplit;

  @override
  State<StatefulWidget> createState() => _CafetoriaRowState();
}

class _CafetoriaRowState extends State<CafetoriaRow>
    with AfterLayoutMixin<CafetoriaRow> {
  DateFormat _timeFormat;

  @override
  Future afterFirstLayout(BuildContext context) async {
    await initializeDateFormatting('de', null);
    setState(() {
      _timeFormat = DateFormat.Hm('de');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_timeFormat == null) {
      return Container();
    }
    return CustomRow(
      leading: Icon(
        Icons.restaurant,
      ),
      title:
          '${widget.menu.name}${widget.showDate ? "(${weekdays[widget.day.date.weekday - 1]} ${outputDateFormat.format(widget.day.date)})" : ''}',
      subtitle: IconsTexts(
        icons: [
          MdiIcons.currencyEur,
          if (widget.menu.time.isNotEmpty) Icons.timer,
        ],
        texts: [
          widget.menu.price.toString().replaceAll('.', ','),
          if (widget.menu.time.isNotEmpty)
            widget.menu.time,
        ],
      ),
    );
  }
}
