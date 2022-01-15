import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/util/note_order.dart';
import 'package:flutter_note_app/domain/util/order_type.dart';

class OrderSection extends StatelessWidget {
  final NoteOrder noteOrder;
  final Function(NoteOrder) onOrderChanged;

  const OrderSection(
      {required this.noteOrder, required this.onOrderChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio<NoteOrder>(
              value: NoteOrder.title(noteOrder.orderType),
              groupValue: noteOrder,
              onChanged: (NoteOrder? value) {
                if (value != null) {
                  onOrderChanged(value);
                }
              },
              activeColor: Colors.white,
            ),
            const Text('제목'),
            Radio<NoteOrder>(
              value: NoteOrder.date(noteOrder.orderType),
              groupValue: noteOrder,
              onChanged: (NoteOrder? value) {
                if (value != null) {
                  onOrderChanged(value);
                }
              },
              activeColor: Colors.white,
            ),
            const Text('날짜'),
            Radio<NoteOrder>(
              value: NoteOrder.color(noteOrder.orderType),
              groupValue: noteOrder,
              onChanged: (NoteOrder? value) {
                if (value != null) {
                  onOrderChanged(value);
                }
              },
              activeColor: Colors.white,
            ),
            const Text('색상'),
          ],
        ),
        Row(
          children: [
            Radio<OrderType>(
              value: const OrderType.ascending(),
              groupValue: noteOrder.orderType,
              onChanged: (OrderType? value) {
                if (value != null) {
                  onOrderChanged(noteOrder.copyWith(orderType: value));
                }
              },
              activeColor: Colors.white,
            ),
            const Text('오름차순'),
            Radio<OrderType>(
              value: const OrderType.descending(),
              groupValue: noteOrder.orderType,
              onChanged: (OrderType? value) {
                if (value != null) {
                  onOrderChanged(noteOrder.copyWith(orderType: value));
                }
              },
              activeColor: Colors.white,
            ),
            const Text('내림차순'),
          ],
        ),
      ],
    );
  }
}
