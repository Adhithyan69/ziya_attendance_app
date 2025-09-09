import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/widgets/dottedDivider.dart';
import 'package:ziya_attendence_app/widgets/leaves_screen_appBar.dart';
import '../../providers/dashboard_controllers/payslip_controller.dart';

class PayslipScreen extends StatelessWidget {
  const PayslipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PayslipController>(context);
    final model = controller.payslip;
    final earningsRows = controller.earningsAndDeductionsRows;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: LeavesScreenAppBar(),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.08,
            child: Center(
              child: Image.asset(
                'lib/assets/Vector.png',
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 18),
                        SizedBox(width: 5),
                        Text(TextConstants.payslip, style: TextStyle(color: AppColors.black, fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Image.asset('lib/assets/Vector.png', height: 30),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TextConstants.ziyaAcademy, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                        Text(TextConstants.keyToSuccess, style: TextStyle(color: Colors.green, fontSize: 10)),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(TextConstants.payslipForTheMonth),
                        Text(model.payPeriod, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const Divider(color: AppColors.grey200),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(TextConstants.employeeSummary, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.black)),
                          const SizedBox(height: 5),
                          _entry(TextConstants.employeeName, model.employeeName),
                          const SizedBox(height: 5),
                          _entry(TextConstants.designation, model.designation),
                          const SizedBox(height: 5),
                          _entry(TextConstants.employeeId, model.employeeId),
                          const SizedBox(height: 5),
                          _entry(TextConstants.dateOfJoining, model.doj),
                          const SizedBox(height: 5),
                          _entry(TextConstants.payPeriod, model.payPeriod),
                          const SizedBox(height: 5),
                          _entry(TextConstants.payDate, model.payDate),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.grey100),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                                color: AppColors.greenLight,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    height: 35,
                                    width: 3,
                                    color: AppColors.presenceClr,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("₹${model.netPay}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                      const Text(TextConstants.employeeNetPay, style: TextStyle(color: AppColors.grey, fontSize: 8)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          dottedDivider(25),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              child: Column(
                                children: [
                                  _entry(TextConstants.paidDays, model.paidDays.toString()),
                                  _entry(TextConstants.lopDays, model.lopDays.toString()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(color: AppColors.grey200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(TextConstants.pfAccountNumber, style: TextStyle(color: AppColors.grey, fontSize: 10)),
                        Text(model.pfAccountNumber, style: const TextStyle(color: AppColors.black, fontSize: 10)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(TextConstants.uan, style: TextStyle(color: AppColors.grey, fontSize: 10)),
                        Text(model.uan, style: const TextStyle(color: AppColors.black, fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _tableRow(headings: const [TextConstants.earnings, TextConstants.amount, TextConstants.ytd, TextConstants.deductions, TextConstants.amount, TextConstants.ytd], isHeader: true),
                      ...earningsRows.map((row) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: row.map((cell) {
                              return Expanded(
                                flex: 1,
                                child: Text(cell, style: const TextStyle(fontSize: 9)),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.blue50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(TextConstants.grossEarnings, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            Text(TextConstants.totalDeductions, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TextConstants.totalNetPayable, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.black)),
                            Text(TextConstants.netPayFormula, style: TextStyle(fontSize: 10, color: AppColors.grey)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColors.greenLight,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Text("₹ ${model.netPay}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(TextConstants.amountInWords, style: TextStyle(fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(),
                const Center(child: Text(TextConstants.autoGeneratedNote, style: TextStyle(fontSize: 10, color: AppColors.grey), textAlign: TextAlign.center)),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final controller = Provider.of<PayslipController>(context, listen: false);
                      final month = controller.payslip.payPeriod;
                      await controller.generateAndSavePDF(month);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
                    child: const Text(TextConstants.downloadPdf, style: TextStyle(color: AppColors.white)),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(TextConstants.payslipHistory, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: controller.historyRows,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _entry(String title, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Text("$title :  ", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10, color: AppColors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
      ],
    ),
  );

  Widget _tableRow({List<String>? headings, List<String>? cells, bool isHeader = false}) {
    final content = headings ?? cells ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: content.map((cell) {
          return Expanded(
            flex: 1,
            child: Text(
              cell,
              style: TextStyle(fontWeight: isHeader ? FontWeight.w800 : FontWeight.normal, fontSize: 9),
            ),
          );
        }).toList(),
      ),
    );
  }
}
