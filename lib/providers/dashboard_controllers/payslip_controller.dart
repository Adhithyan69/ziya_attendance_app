// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:open_file/open_file.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../models/dashboard_models/payslip_models.dart';
//
// class PayslipController with ChangeNotifier {
//   PayslipModel payslip = PayslipModel(
//     employeeName: 'Hemant Rangarajan',
//     designation: 'Full-stack Developer',
//     employeeId: 'EMP1234',
//     doj: '30/05/2025',
//     payPeriod: 'June 2025',
//     payDate: '15/07/2025',
//     pfAccountNumber: 'AA/AAA/999999/99G/9899',
//     uan: '111111111111111',
//     paidDays: 30,
//     lopDays: 0,
//     netPay: 48000,
//   );
//
//   Map<String, PayslipModel> monthlyPayslips = {
//     "March 2025": PayslipModel(
//       employeeName: 'Hemant Rangarajan',
//       designation: 'Full-stack Developer',
//       employeeId: 'EMP1234',
//       doj: '01/03/2024',
//       payPeriod: 'March 2025',
//       payDate: '05/04/2025',
//       pfAccountNumber: 'AA/999999/93G/9090',
//       uan: '123456789012',
//       paidDays: 31,
//       lopDays: 0,
//       netPay: 41000,
//     ),
//     "April 2025": PayslipModel(
//       employeeName: 'Hemant Rangarajan',
//       designation: 'Full-stack Developer',
//       employeeId: 'EMP1234',
//       doj: '01/03/2024',
//       payPeriod: 'April 2025',
//       payDate: '05/05/2025',
//       pfAccountNumber: 'AA/999999/93G/9090',
//       uan: '123456789012',
//       paidDays: 30,
//       lopDays: 0,
//       netPay: 43500,
//     ),
//     "May 2025": PayslipModel(
//       employeeName: 'Hemant Rangarajan',
//       designation: 'Full-stack Developer',
//       employeeId: 'EMP1234',
//       doj: '01/03/2024',
//       payPeriod: 'May 2025',
//       payDate: '05/06/2025',
//       pfAccountNumber: 'AA/999999/93G/9090',
//       uan: '123456789012',
//       paidDays: 31,
//       lopDays: 0,
//       netPay: 45000,
//     ),
//     "June 2025": PayslipModel(
//       employeeName: 'Hemant Rangarajan',
//       designation: 'Full-stack Developer',
//       employeeId: 'EMP1234',
//       doj: '01/03/2024',
//       payPeriod: 'June 2025',
//       payDate: '05/07/2025',
//       pfAccountNumber: 'AA/999999/93G/9090',
//       uan: '123456789012',
//       paidDays: 30,
//       lopDays: 0,
//       netPay: 48000,
//     ),
//   };
//
//   final List<List<String>> payslipHistoryData = [
//     ["Month", "Net Pay", "Status", "Action"],
//     ["June 2025", "₹48,000", "✅Generated", "[📥 Download]"],
//     ["May 2025", "₹45,000", "✅Generated", "[📥 Download]"],
//     ["April 2025", "₹43,500", "✅Generated", "[📥 Download]"],
//     ["March 2025", "₹41,000", "✅Generated", "[📥 Download]"],
//   ];
//
//   final Map<String, List<List<String>>> monthlyEarnings = {
//     "March 2025": [
//       ["Basic", "₹22,000", "₹2,64,000", "PF Deduction", "₹2,000", "₹24,000"],
//       ["HRA", "₹9,000", "₹1,08,000", "Tax Deduction", "₹6,000", "₹72,000"],
//       ["Allowances", "₹3,000", "₹36,000", "", "", ""],
//       ["Travel Allowance", "₹ 3,000", "₹36,000", "", "", ""],
//       ["Meal / Other Allowance", "₹ 2,000", "₹24,000", "", "", ""],
//     ],
//     "April 2025": [
//       ["Basic", "₹23,000", "₹2,76,000", "PF Deduction", "₹2,200", "₹26,400"],
//       ["HRA", "₹9,500", "₹1,14,000", "Tax Deduction", "₹6,300", "₹75,600"],
//       ["Allowances", "₹3,000", "₹36,000", "", "", ""],
//       ["Travel Allowance", "₹ 3,000", "₹36,000", "", "", ""],
//       ["Meal / Other Allowance", "₹ 2,000", "₹24,000", "", "", ""],
//     ],
//     "May 2025": [
//       ["Basic", "₹25,000", "₹3,00,000", "PF Deduction", "₹2,500", "₹30,000"],
//       ["HRA", "₹10,000", "₹1,20,000", "Tax Deduction", "₹7,500", "₹90,000"],
//       ["Allowances", "₹3,000", "₹36,000", "", "", ""],
//       ["Travel Allowance", "₹ 3,000", "₹36,000", "", "", ""],
//       ["Meal / Other Allowance", "₹ 2,000", "₹24,000", "", "", ""],
//     ],
//     "June 2025": [
//       ["Basic", "₹27,000", "₹3,24,000", "PF Deduction", "₹2,700", "₹32,400"],
//       ["HRA", "₹10,500", "₹1,26,000", "Tax Deduction", "₹8,000", "₹96,000"],
//       ["Allowances", "₹3,000", "₹36,000", "", "", ""],
//       ["Travel Allowance", "₹ 3,000", "₹36,000", "", "", ""],
//       ["Meal / Other Allowance", "₹ 2,000", "₹24,000", "", "", ""],
//     ],
//   };
//
//   List<Widget> get historyRows =>
//       payslipHistoryData.map((row) {
//         final String month = row[0];
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 6),
//           child: Row(
//             children: row.map((cell) {
//               if (cell.contains("✅Generated")) {
//                 return Expanded(
//                   flex: 1,
//                   child: GestureDetector(
//                     onTap: () => loadPayslip(month),
//                     child: Text(
//                       "✅Generated",
//                       style: TextStyle(fontSize: 12,
//                           color: Colors.green.shade800),
//                     ),
//                   ),
//                 );
//               } else if (cell.contains("Download")) {
//                 return Expanded(
//                   flex: 1,
//                   child: GestureDetector(
//                     onTap: () => generateAndSavePDF(month),
//                     child: const Text(
//                       "📥 Download",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.blue,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Expanded(
//                   flex: 1,
//                   child: Text(cell, style: const TextStyle(fontSize: 12)),
//                 );
//               }
//             }).toList(),
//           ),
//         );
//       }).toList();
//
//   List<List<String>> get earningsAndDeductionsRows =>
//       monthlyEarnings[payslip.payPeriod] ?? [];
//
//   void loadPayslip(String month) {
//     final selected = monthlyPayslips[month];
//     if (selected != null) {
//       payslip = selected;
//       notifyListeners();
//     } else {
//       debugPrint("Error: Payslip data not found for \$month");
//     }
//   }
//
//   Future<void> generateAndSavePDF(String month) async {
//     final androidInfo = await DeviceInfoPlugin().androidInfo;
//     final isAndroid11OrAbove = androidInfo.version.sdkInt >= 30;
//
//     PermissionStatus status;
//     if (isAndroid11OrAbove) {
//       status = await Permission.manageExternalStorage.request();
//     } else {
//       status = await Permission.storage.request();
//     }
//
//     if (!status.isGranted) {
//       debugPrint("Storage permission denied.");
//       return;
//     }
//
//     final pdf = pw.Document();
//     final data = monthlyPayslips[month]!;
//     final rows = monthlyEarnings[month] ?? [];
//
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         margin: const pw.EdgeInsets.all(24),
//         build: (context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text("ZiyaAcademy", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, color: PdfColors.blue)),
//                     pw.Text("KEY-TO SUCCESS", style: pw.TextStyle(fontSize: 10, color: PdfColors.green)),
//                   ],
//                 ),
//                 pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.end,
//                   children: [
//                     pw.Text("Payslip for the Month", style: pw.TextStyle(fontSize: 12)),
//                     pw.Text(month, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
//                   ],
//                 ),
//               ],
//             ),
//             pw.SizedBox(height: 16),
//             pw.Text("EMPLOYEE SUMMARY", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 8),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Expanded(
//                   child: pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       _pdfEntry("Employee Name", data.employeeName),
//                       _pdfEntry("Designation", data.designation),
//                       _pdfEntry("Employee ID", data.employeeId),
//                       _pdfEntry("Date of Joining", data.doj),
//                       _pdfEntry("Pay Period", data.payPeriod),
//                       _pdfEntry("Pay Date", data.payDate),
//                     ],
//                   ),
//                 ),
//                 pw.Container(
//                   width: 140,
//                   decoration: pw.BoxDecoration(
//                     border: pw.Border.all(color: PdfColors.grey300),
//                     borderRadius: pw.BorderRadius.circular(8),
//                   ),
//                   padding: const pw.EdgeInsets.all(8),
//                   child: pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Container(
//                         width: double.infinity,
//                         padding: const pw.EdgeInsets.all(8),
//                         decoration: pw.BoxDecoration(
//                           color: PdfColors.lightGreen100,
//                           borderRadius: const pw.BorderRadius.vertical(top: pw.Radius.circular(6)),
//                         ),
//                         child: pw.Column(
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           children: [
//                             pw.Text("₹${data.netPay}", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                             pw.Text("Employee Net Pay", style: pw.TextStyle(fontSize: 8)),
//                           ],
//                         ),
//                       ),
//                       pw.SizedBox(height: 6),
//                       _pdfEntry("Paid Days", data.paidDays.toString()),
//                       _pdfEntry("LOP Days", data.lopDays.toString()),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             pw.SizedBox(height: 8),
//             pw.Divider(),
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Text("PF A/C Number: ${data.pfAccountNumber}", style: pw.TextStyle(fontSize: 10)),
//                 pw.Text("UAN: ${data.uan}", style: pw.TextStyle(fontSize: 10)),
//               ],
//             ),
//             pw.SizedBox(height: 12),
//             pw.Text("Earnings & Deductions", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 6),
//             pw.Table(
//               border: pw.TableBorder.all(color: PdfColors.grey300),
//               columnWidths: {
//                 0: const pw.FlexColumnWidth(1.5),
//                 1: const pw.FlexColumnWidth(1),
//                 2: const pw.FlexColumnWidth(1),
//                 3: const pw.FlexColumnWidth(1.5),
//                 4: const pw.FlexColumnWidth(1),
//                 5: const pw.FlexColumnWidth(1),
//               },
//               children: [
//                 pw.TableRow(
//                   decoration: const pw.BoxDecoration(color: PdfColors.grey200),
//                   children: [
//                     _pdfCell("EARNINGS", bold: true),
//                     _pdfCell("AMOUNT", bold: true),
//                     _pdfCell("YTD", bold: true),
//                     _pdfCell("DEDUCTIONS", bold: true),
//                     _pdfCell("AMOUNT", bold: true),
//                     _pdfCell("YTD", bold: true),
//                   ],
//                 ),
//                 ...rows.map((row) => pw.TableRow(
//                   children: row.map((cell) => _pdfCell(cell)).toList(),
//                 )),
//               ],
//             ),
//             pw.SizedBox(height: 10),
//             pw.Container(
//               color: PdfColors.lightBlue100,
//               padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//               child: pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Text("Gross Earnings ₹55,000", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                   pw.Text("Total Deductions ₹10,000", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 16),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 border: pw.Border.all(color: PdfColors.grey),
//                 borderRadius: pw.BorderRadius.circular(8),
//               ),
//               child: pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text("Total Net Payable", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
//                       pw.Text("Gross Earnings - Total Deductions", style: pw.TextStyle(fontSize: 9)),
//                     ],
//                   ),
//                   pw.Container(
//                     padding: const pw.EdgeInsets.all(8),
//                     decoration: pw.BoxDecoration(
//                       color: PdfColors.green100,
//                       borderRadius: pw.BorderRadius.circular(6),
//                     ),
//                     child: pw.Text("₹ ${data.netPay}", style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
//                   ),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 12),
//             pw.Text("Amount in Words:  Indian Rupee Forty-Five Thousand Only", style: pw.TextStyle(fontSize: 10)),
//             pw.SizedBox(height: 12),
//             pw.Center(child: pw.Text("This is a computer-generated payslip.", style: pw.TextStyle(fontSize: 8))),
//           ],
//         ),
//       ),
//     );
//
//     Directory? directory;
//     if (Platform.isAndroid) {
//       directory = Directory('/storage/emulated/0/Download');
//       if (!await directory.exists()) {
//         directory = await getExternalStorageDirectory();
//       }
//     } else {
//       directory = await getApplicationDocumentsDirectory();
//     }
//
//     final filePath = '${directory!.path}/Payslip_${month.replaceAll(
//         " ", "_")}.pdf';
//     final file = File(filePath);
//     await file.writeAsBytes(await pdf.save());
//     OpenFile.open(filePath);
//   }
// }
//
// pw.Widget _pdfEntry(String label, String value) {
//   return pw.Padding(
//     padding: const pw.EdgeInsets.symmetric(vertical: 2),
//     child: pw.Text("$label : $value", style: pw.TextStyle(fontSize: 9)),
//   );
// }
//
// pw.Widget _pdfCell(String text, {bool bold = false}) {
//   return pw.Padding(
//     padding: const pw.EdgeInsets.all(4),
//     child: pw.Text(
//       text,
//       style: pw.TextStyle(fontSize: 8, fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal),
//     ),
//   );
// }
//
//
//
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../models/dashboard_models/payslip_models.dart';
import '../../constants/text_constants.dart';
import '../../constants/color_constants.dart';

class PayslipController with ChangeNotifier {
  PayslipModel payslip = PayslipModel(
    employeeName: 'Hemant Rangarajan',
    designation: 'Full-stack Developer',
    employeeId: 'EMP1234',
    doj: '30/05/2025',
    payPeriod: 'June 2025',
    payDate: '15/07/2025',
    pfAccountNumber: 'AA/AAA/999999/99G/9899',
    uan: '111111111111111',
    paidDays: 30,
    lopDays: 0,
    netPay: 48000,
  );

  Map<String, PayslipModel> monthlyPayslips = {
    "March 2025": PayslipModel(
      employeeName: 'Hemant Rangarajan',
      designation: 'Full-stack Developer',
      employeeId: 'EMP1234',
      doj: '01/03/2024',
      payPeriod: 'March 2025',
      payDate: '05/04/2025',
      pfAccountNumber: 'AA/999999/93G/9090',
      uan: '123456789012',
      paidDays: 31,
      lopDays: 0,
      netPay: 41000,
    ),
    "April 2025": PayslipModel(
      employeeName: 'Hemant Rangarajan',
      designation: 'Full-stack Developer',
      employeeId: 'EMP1234',
      doj: '01/03/2024',
      payPeriod: 'April 2025',
      payDate: '05/05/2025',
      pfAccountNumber: 'AA/999999/93G/9090',
      uan: '123456789012',
      paidDays: 30,
      lopDays: 0,
      netPay: 43500,
    ),
    "May 2025": PayslipModel(
      employeeName: 'Hemant Rangarajan',
      designation: 'Full-stack Developer',
      employeeId: 'EMP1234',
      doj: '01/03/2024',
      payPeriod: 'May 2025',
      payDate: '05/06/2025',
      pfAccountNumber: 'AA/999999/93G/9090',
      uan: '123456789012',
      paidDays: 31,
      lopDays: 0,
      netPay: 45000,
    ),
    "June 2025": PayslipModel(
      employeeName: 'Hemant Rangarajan',
      designation: 'Full-stack Developer',
      employeeId: 'EMP1234',
      doj: '01/03/2024',
      payPeriod: 'June 2025',
      payDate: '05/07/2025',
      pfAccountNumber: 'AA/999999/93G/9090',
      uan: '123456789012',
      paidDays: 30,
      lopDays: 0,
      netPay: 48000,
    ),
  };

  final List<List<String>> payslipHistoryData = [
    ["Month", "Net Pay", "Status", "Action"],
    ["June 2025", "₹48,000", TextConstants.payslipGenerated, TextConstants.payslipDownload],
    ["May 2025", "₹45,000", TextConstants.payslipGenerated, TextConstants.payslipDownload],
    ["April 2025", "₹43,500", TextConstants.payslipGenerated, TextConstants.payslipDownload],
    ["March 2025", "₹41,000", TextConstants.payslipGenerated, TextConstants.payslipDownload],
  ];

  final Map<String, List<List<String>>> monthlyEarnings = {
    "March 2025": [
      ["Basic", "₹22,000", "₹2,64,000", "PF Deduction", "₹2,000", "₹24,000"],
      ["HRA", "₹9,000", "₹1,08,000", "Tax Deduction", "₹6,000", "₹72,000"],
      ["Allowances", "₹3,000", "₹36,000", "", "", ""],
      ["Travel Allowance", "₹ 3,000", "₹36,000", "", "", ""],
      ["Meal / Other Allowance", "₹ 2,000", "₹24,000", "", "", ""],
    ],
    "April 2025": [
      ["Basic", "₹23,000", "₹2,76,000", "PF Deduction", "₹2,200", "₹26,400"],
      ["HRA", "₹9,500", "₹1,14,000", "Tax Deduction", "₹6,300", "₹75,600"],
      ["Allowances", "₹3,000", "₹36,000", "", "", ""],
      ["Travel Allowance", "₹ 3,000", "₹36,000", "", "", ""],
      ["Meal / Other Allowance", "₹ 2,000", "₹24,000", "", "", ""],
    ],
    "May 2025": [
      ["Basic", "₹25,000", "₹3,00,000", "PF Deduction", "₹2,500", "₹30,000"],
      ["HRA", "₹10,000", "₹1,20,000", "Tax Deduction", "₹7,500", "₹90,000"],
      ["Allowances", "₹3,000", "₹36,000", "", "", ""],
      ["Travel Allowance", "₹ 3,000", "₹36,000", "", "", ""],
      ["Meal / Other Allowance", "₹ 2,000", "₹24,000", "", "", ""],
    ],
    "June 2025": [
      ["Basic", "₹27,000", "₹3,24,000", "PF Deduction", "₹2,700", "₹32,400"],
      ["HRA", "₹10,500", "₹1,26,000", "Tax Deduction", "₹8,000", "₹96,000"],
      ["Allowances", "₹3,000", "₹36,000", "", "", ""],
      ["Travel Allowance", "₹ 3,000", "₹36,000", "", "", ""],
      ["Meal / Other Allowance", "₹ 2,000", "₹24,000", "", "", ""],
    ],
  };

  List<Widget> get historyRows =>
      payslipHistoryData.map((row) {
        final String month = row[0];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: row.map((cell) {
              if (cell == TextConstants.payslipGenerated) {
                return Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => loadPayslip(month),
                    child: Text(
                      TextConstants.payslipGenerated,
                      style: TextStyle(fontSize: 12, color: AppColors.generatedTextColor),
                    ),
                  ),
                );
              } else if (cell == TextConstants.payslipDownload) {
                return Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => generateAndSavePDF(month),
                    child: Text(
                      TextConstants.payslipDownload,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.downloadTextColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  flex: 1,
                  child: Text(cell, style: const TextStyle(fontSize: 12)),
                );
              }
            }).toList(),
          ),
        );
      }).toList();

  List<List<String>> get earningsAndDeductionsRows =>
      monthlyEarnings[payslip.payPeriod] ?? [];

  void loadPayslip(String month) {
    final selected = monthlyPayslips[month];
    if (selected != null) {
      payslip = selected;
      notifyListeners();
    } else {
      debugPrint("${TextConstants.errorMonthData}$month");
    }
  }

  Future<void> generateAndSavePDF(String month) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final isAndroid11OrAbove = androidInfo.version.sdkInt >= 30;

    PermissionStatus status;
    if (isAndroid11OrAbove) {
      status = await Permission.manageExternalStorage.request();
    } else {
      status = await Permission.storage.request();
    }

    if (!status.isGranted) {
      debugPrint(TextConstants.storageDenied);
      return;
    }

    final pdf = pw.Document();
    final data = monthlyPayslips[month]!;
    final rows = monthlyEarnings[month] ?? [];

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(TextConstants.ziyaAcademy,
                        style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, color: AppColors.payslipTitle)),
                    pw.Text(TextConstants.keyToSuccess,
                        style: pw.TextStyle(fontSize: 10, color: AppColors.payslipSubtitle)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(TextConstants.payslipForMonth, style: pw.TextStyle(fontSize: 12)),
                    pw.Text(month, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Text(TextConstants.employeeSummary, style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _pdfEntry(TextConstants.employeeName, data.employeeName),
                      _pdfEntry(TextConstants.designation, data.designation),
                      _pdfEntry(TextConstants.employeeId, data.employeeId),
                      _pdfEntry(TextConstants.dateOfJoining, data.doj),
                      _pdfEntry(TextConstants.payPeriod, data.payPeriod),
                      _pdfEntry(TextConstants.payDate, data.payDate),
                    ],
                  ),
                ),
                pw.Container(
                  width: 140,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: AppColors.payslipDivider),
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                        width: double.infinity,
                        padding: const pw.EdgeInsets.all(8),
                        decoration: pw.BoxDecoration(
                          color: AppColors.payslipLightGreen,
                          borderRadius: const pw.BorderRadius.vertical(top: pw.Radius.circular(6)),
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("₹${data.netPay}", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                            pw.Text(TextConstants.employeeNetPay, style: pw.TextStyle(fontSize: 8)),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      _pdfEntry(TextConstants.paidDays, data.paidDays.toString()),
                      _pdfEntry(TextConstants.lopDays, data.lopDays.toString()),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 8),
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("${TextConstants.pfAccountNumber}: ${data.pfAccountNumber}", style: pw.TextStyle(fontSize: 10)),
                pw.Text("${TextConstants.uan}: ${data.uan}", style: pw.TextStyle(fontSize: 10)),
              ],
            ),
            pw.SizedBox(height: 12),
            pw.Text(TextConstants.earningsAndDeductions, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 6),
            pw.Table(
              border: pw.TableBorder.all(color: AppColors.payslipDivider),
              columnWidths: {
                0: const pw.FlexColumnWidth(1.5),
                1: const pw.FlexColumnWidth(1),
                2: const pw.FlexColumnWidth(1),
                3: const pw.FlexColumnWidth(1.5),
                4: const pw.FlexColumnWidth(1),
                5: const pw.FlexColumnWidth(1),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: AppColors.payslipSectionBg),
                  children: [
                    _pdfCell(TextConstants.earnings, bold: true),
                    _pdfCell(TextConstants.amount, bold: true),
                    _pdfCell(TextConstants.ytd, bold: true),
                    _pdfCell(TextConstants.deductions, bold: true),
                    _pdfCell(TextConstants.amount, bold: true),
                    _pdfCell(TextConstants.ytd, bold: true),
                  ],
                ),
                ...rows.map((row) => pw.TableRow(
                  children: row.map((cell) => _pdfCell(cell)).toList(),
                )),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Container(
              color: AppColors.payslipHighlight,
              padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("${TextConstants.grossEarnings} ₹55,000", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text("${TextConstants.totalDeductions} ₹10,000", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ),
            pw.SizedBox(height: 16),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(TextConstants.totalNetPayable, style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                      pw.Text(TextConstants.netFormula, style: pw.TextStyle(fontSize: 9)),
                    ],
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      color: AppColors.payslipNetPayBg,
                      borderRadius: pw.BorderRadius.circular(6),
                    ),
                    child: pw.Text("₹ ${data.netPay}", style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 12),
            pw.Text(TextConstants.amountInWords, style: pw.TextStyle(fontSize: 10)),
            pw.SizedBox(height: 12),
            pw.Center(child: pw.Text(TextConstants.autoGenerated, style: pw.TextStyle(fontSize: 8))),
          ],
        ),
      ),
    );

    Directory? directory;
    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final filePath = '${directory!.path}/Payslip_${month.replaceAll(" ", "_")}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(filePath);
  }
}


pw.Widget _pdfEntry(String label, String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 2),
    child: pw.Text("$label : $value", style: pw.TextStyle(fontSize: 9)),
  );
}

pw.Widget _pdfCell(String text, {bool bold = false}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(4),
    child: pw.Text(
      text,
      style: pw.TextStyle(fontSize: 8, fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal),
    ),
  );
}
