
import 'package:daily_planner/class/const_variable.dart';
import 'package:daily_planner/widgets/custom_toast.dart';
import 'package:flutter/material.dart';

class TimePickerButton extends StatefulWidget {
  TimePickerButton(
      {super.key,
      required this.context,
      required this.onTap,
      this.isDisable = false,
      required this.title,
      this.time});

  final Function(TimeOfDay?) onTap; // Callback khi chọn ngày
  final bool isDisable;
  final String title;
  final TimeOfDay? time;
  final BuildContext context;

  @override
  State<TimePickerButton> createState() => _TimePickerButtonState();
}

class _TimePickerButtonState extends State<TimePickerButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isDisable) {
          NotifyToast(
            context: context,
            message: "Không được chỉnh sửa giờ",
          ).ShowToast();
          return;
        } else {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((value) {
            if (value != null) {
              return widget.onTap(value);
            } else {
              return widget.onTap(null);
            }
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.access_time_rounded,
              color: Theme.of(context).colorScheme.onSurface,
              size: 30,
            ),
            SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: PrimaryTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                (widget.time != null)
                    ? Text(
                        widget.time!.format(context).toString(),
                        style: PrimaryTextStyle(fontSize: 16),
                      )
                    : Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}
