class PayslipModel {
  final String employeeName;
  final String designation;
  final String employeeId;
  final String doj;
  final String payPeriod;
  final String payDate;
  final String pfAccountNumber;
  final String uan;
  final int paidDays;
  final int lopDays;
  final int netPay;

  const PayslipModel({
    required this.employeeName,
    required this.designation,
    required this.employeeId,
    required this.doj,
    required this.payPeriod,
    required this.payDate,
    required this.pfAccountNumber,
    required this.uan,
    required this.paidDays,
    required this.lopDays,
    required this.netPay,
  });
}

class Earning {
  final String title;
  final String amount;
  final String ytd;
  const Earning({required this.title, required this.amount, required this.ytd});
}

class Deduction {
  final String title;
  final String amount;
  final String ytd;
  const Deduction({required this.title, required this.amount, required this.ytd});
}

class PayslipHistory {
  final String month;
  final String netPay;
  final String status;
  final String action;
  const PayslipHistory({required this.month, required this.netPay, required this.status, required this.action});
}