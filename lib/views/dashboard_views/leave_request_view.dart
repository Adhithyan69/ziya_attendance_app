import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import '../../providers/dashboard_controllers/leaves_Request_controller.dart';
import '../../models/dashboard_models/leave_application_model.dart';

class LeavesRequestScreen extends StatefulWidget {
  const LeavesRequestScreen({super.key});

  @override
  State<LeavesRequestScreen> createState() => _LeavesRequestScreenState();
}

class _LeavesRequestScreenState extends State<LeavesRequestScreen> {
  final TextEditingController _reasonController = TextEditingController();
  final String _employeeName = TextConstants.employeeNameAutoFilled;
  final String _employeeId = TextConstants.employeeIdAutoFilled;
  DateTime? _fromDate;
  DateTime? _toDate;
  String _leaveType = '';
  String? _attachedFileName;
  PlatformFile? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                TextConstants.applyForLeave,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 25,
                ),
              ),
            ),
            _buildLabel(TextConstants.employeeName),
            _buildReadOnlyField(_employeeName, Icons.perm_identity),
            _buildLabel(TextConstants.employeeId),
            _buildReadOnlyField(_employeeId, Icons.badge_outlined),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildLabel(TextConstants.from),
                    SizedBox(width: MediaQuery.of(context).size.width * 1 / 2),
                    _buildLabel(TextConstants.to),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildDatePickerField(TextConstants.fromDate, _fromDate,
                              (date) => setState(() => _fromDate = date)),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_right_alt_outlined),
                    const SizedBox(width: 4),
                    Expanded(
                      child: _buildDatePickerField(TextConstants.toDate, _toDate,
                              (date) => setState(() => _toDate = date)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.logout_rounded,
                            size: 15,
                            color: AppColors.leaveScreenTextColor,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            TextConstants.leaveType,
                            style: TextStyle(
                                color: AppColors.leaveScreenTextColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(child: _buildCustomLeaveTypePicker()),
              ],
            ),
            _buildLabel(TextConstants.reason),
            _buildTextArea(_reasonController),
            _buildLabel(TextConstants.attachment),
            _buildAttachmentField(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor),
                child: const Text(
                  TextConstants.submit,
                  style: TextStyle(color: AppColors.selectedTextColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 2),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    ),
  );

  Widget _buildReadOnlyField(String value, IconData icon) => Card(
    color: Colors.white,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    child: TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, size: 18),
        hintText: value,
        hintStyle: const TextStyle(
          color: AppColors.leaveScreenTextColor,
        ),
        border: InputBorder.none,
      ),
    ),
  );

  Widget _buildDatePickerField(
      String hint, DateTime? selectedDate, Function(DateTime) onDatePicked) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: GestureDetector(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );
          if (picked != null) onDatePicked(picked);
        },
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.calendar_month,
                  color: AppColors.leaveScreenTextColor),
              hintText: selectedDate == null
                  ? hint
                  : selectedDate.toLocal().toString().split(' ')[0],
              border: InputBorder.none,
              hintStyle: const TextStyle(
                color: AppColors.leaveScreenTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomLeaveTypePicker() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: () => _showLeaveTypePopup(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _leaveType.isEmpty ? TextConstants.chooseType : _leaveType,
                style: const TextStyle(
                  color: AppColors.leaveScreenTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_drop_up,
                      color: AppColors.leaveScreenTextColor),
                  const Icon(Icons.arrow_drop_down,
                      color: AppColors.leaveScreenTextColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLeaveTypePopup() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: TextConstants.leaveTypes.map(
                  (type) => ListTile(
                title: Text(type),
                onTap: () {
                  setState(() => _leaveType = type);
                  Navigator.pop(context);
                },
              ),
            ).toList(),
          ),
        );
      },
    );
  }

  Widget _buildTextArea(TextEditingController controller) => Card(
    color: Colors.white,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    child: TextField(
      controller: controller,
      maxLines: 4,
      decoration: const InputDecoration(
        hintText: TextConstants.textArea,
        hintStyle: TextStyle(
          color: AppColors.leaveScreenTextColor,
        ),
        border: InputBorder.none,
      ),
    ),
  );

  Widget _buildAttachmentField() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: _pickAttachment,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              const Icon(Icons.attach_file, color: AppColors.leaveScreenTextColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _attachedFileName ?? TextConstants.attachmentOptional,
                  style: const TextStyle(color: AppColors.leaveScreenTextColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAttachment() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedFile = result.files.first;
        _attachedFileName = _pickedFile!.name;
      });
    }
  }

  void _submit() {
    if (_fromDate == null ||
        _toDate == null ||
        _leaveType.isEmpty ||
        _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(TextConstants.fillAllFields)),
      );
      return;
    }

    final application = LeaveApplication(
      employeeName: _employeeName,
      employeeId: _employeeId,
      fromDate: _fromDate!,
      toDate: _toDate!,
      leaveType: _leaveType,
      reason: _reasonController.text,
      attachment: _pickedFile,
    );

    Provider.of<LeaveRequestController>(context, listen: false)
        .submitLeave(application);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text(TextConstants.leaveSubmitted)));
  }
}
