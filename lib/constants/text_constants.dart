class TextConstants {
  // my

  static const String appName = "Ziya Attend";
  static const String appTagline = "Smart Attendance Maintainer";

  //Login / Auth Texts
  static const String forgotPassword = "Forgot Password?";
  // static const String login = "Login";
  static const String loginFailed = "Login failed";

  //Validation Messages
  static const String enterEmail = "Please enter you email";
  // static const String enterValidEmail = "please ente a valid email";
  static const String enterPassword = "Enter Password";
  static const String emailError = "Enter your email";

  //Input Field Labels
  static const String password = "Password";
  // static const String passwordHint = "Password";
  static const String email = " Email";
  static const String emailAddres = "Email Address";

  //UI Buttons / Links
  static const String rememberMe = "Remember Me";
  static const String backtologin = "Back to Login";
  static const String sandCode = "Sand Code";

  //Errors
  static const String logoError = 'Logo not found\n(add assets/logoimages.png)';

  //API Response Keys
  static const String success = "success";
  static const String message = "message";

  //Forgot Password Screen
  static const String forgotSubText =
      "Enter your registered email address to reset your password.";

  //login screen
  static const appTitle = 'Ziya Attend';
  static const ziyaLogo = 'assets/_ZIYA_ACADEMY_LOGO.png';
  static const baseUrl = 'http://192.168.1.27:8000/api/';
  static const welcomeBack = 'Welcome Back!';
  static const loginToYOurAccount = 'Login to Your Account';
  static const emailHint = 'Email';
  static const passwordHint = 'Password';
  static const fotgotPassword = 'Forgot Password?';
  static const login = 'Log In';
  static const signUp = 'Sign Up';
  static const passwordIsRequired = 'password is required';
  static const passwordMustBe6Char = 'Password must be at least 6 characters';
  //otpscreen
  static const verifyCode = "Verify Code";
  static const resendCode = "Resend code?";
  static const continueText = "Continue";
  static const otpVerified = "OTP Verified Successfully!";
  static const emailInstruction = "Please enter the code we just sent to";
  // Reset Password
  static const createNewPassword = "Create new password";
  static const enterEmailToReset =
      "Enter your registered email address to reset your password.";
  static const newPassword = "New password";
  static const confirmPassword = "Confirm Password";
  static const resetSuccess = "Password reset successful";
  static const newPasswordHint = "New password";
  static const confirmPasswordHint = "Confirm Password";
  static const cancel = "Cancel";
  static const resetPassword = "Reset Password";
  //forgot password screen
  static const enterYourEmail = 'Enter Your Email';
  //  static const resetPassword = 'Reset Password';
  static const backToLogin = 'Back to Login';
  static const emailIsRequired = 'Email is required';
  static const enterValidEmail = 'Enter a valid email address';
  //  static const regExp = 'r^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$';
  //Account Verified screen
  static const accountVerified = "Account Verified";
  static const accountVerifiedMsg =
      "Your account has been verified successfully";
  // Home constants
  static const wishes = "Good Morning ,\n";
  static const userName = "Hemant Rangarajan";
  static const overView = "Overview";
  static const dashboard = "Dashboard";
  static const userField = "Full-stack Developer";
  static const centerYourFace = "Center your face";
  static const checkVerifcnText =
      "point your face right at the box,\nthen take a photo";
  static const haventCheckedText = "You haven't Checked-in yet";
  static const punchInSuccessFull = "Punch in successfully ";
  static const punchOutSuccessFull = "Punch out successfully ";
  static const checkedInText = "You are checked in at";
  static const checkedOutText = "You are checked out at ";
  static const profileImageUrl = "assets/userProfile_image.jpg";
  static const ziyalogoImageUrl = 'assets/logo_image.jpg';
  static const presence = "Presence";
  static const absence = "Absence";
  static const leaves = "Leave";
  static const late = "Late";
  static const presenceLength = "20";
  static const absenceLength = "03";
  static const leavesLength = "02";
  static const lateLength = "06";
  static const qrVerification = 'Qr Verification';
  static const pleaseScanYourQRCode = 'Please Scan your QR Code';
  static const scanQR = 'Scan QR';
  static const takePhoto = 'Take Photo';
  static const qRAnimation = "assets/animations/qr-code.gif";
  static const faceScanAnimation = 'assets/animations/face-scan.gif';
  static const faceVerification = 'Face Verification';
  static const pleaseCaptureYourFace = 'Please capture your face';
  static const punchIn = "Punch In";
  static const punchOut = "Punch Out";
  static const updateTask = "Update Task";
  static const checkedInAt = "You are Punch-in ";
  static const wfh = "Work From Home";
  static const onSite = "On Site";
  static const remote = "Remote";
  static const doYouReallyWantToCheckout = "Do you really want\nto checkout!";
  static const punchInDialog = "Are you working from home or on site today?";
  static const selectPunchInType = "Select Punch-In Type";

  // Leave Dashboard
  static const String totalLeaveTaken = "Total Leave Taken";
  static const String approvalRate = "Approval Rate";
  static const String pendingRequest = "Pending Request";
  static const String teamOnLeave = "Team Member \non Leave";
  static const String remainingDays = "days remaining this year";
  static const String loading = "Loading...";

  // Leave Request
  static const employeeNameAutoFilled = "Employee Name - auto-filled";
  static const employeeIdAutoFilled = "Employee ID - auto-filled";
  static const applyForLeave = "Apply for Leave";
  static const employeeName = "Employee Name";
  static const employeeId = "Employee ID";
  static const from = "From";
  static const to = "To";
  static const fromDate = "From Date";
  static const toDate = "To Date";
  static const leaveType = "Leave Type";
  static const chooseType = "Choose Type";
  static const reason = "Reason";
  static const attachment = "Attachment";
  static const attachmentOptional = "Attachment(Optional)";
  static const submit = "Submit";
  static const textArea = "Text area";
  static const fillAllFields = "Please fill all required fields";
  static const leaveSubmitted = "Leave Submitted";
  static const List<String> leaveTypes = [
    "Casual Leave",
    "Sick Leave",
    "Work From Home",
    "Earned Leave",
  ];

  //ProductivityDashboard
  static const totalWorkingDays = 'Total Working \nDays';
  static const totalHoursWorked = 'Total Hours \nworked';
  static const averageDailyHours = 'Average Daily \nHours';
  static const productivityIndicator = 'Productivity \nIndicator';
  static const projectsInvolved = 'Projects Involved';
  static const leaveTaken = 'Leave Taken';
  static const totalWorkingDaysValue = '20';
  static const totalHoursWorkedValue = '160 hours';
  static const averageDailyHoursValue = '8.0 hours';
  static const productivityIndicatorValue = '80%';
  static const projectsInvolvedValue = 'Revenue\nDashboard';
  static const leaveTakenValue = '2 days';

  //UpcomingLeaveCard
  static const upcomingLeave = "Upcoming Leave";
  static const scheduledTimeOff = "Your scheduled time off";
  static const pendingApprovalTitle = "Pending Approval";
  static const pendingApprovalSubtitle =
      "Your leave request is awaiting manager";

  //TaskCard
  static const dueDate = "Due Date:";
  static const status = "Status:";
  static const progress = "Progress:";
  static const daysRemaining = "2 days\nremaining";
  static const assignedBy = "Assigned By\n(optional)";
  static const priority = "Priority:";
  static const actionStart = "Start";
  static const actionUpdate = "Update";
  static const actionComplete = "Complete";
  static const notStarted = "Not Started";
  static const inProgress = "In Progress";
  static const completed = "Completed";
  static const overdue = "Overdue";
  static const lowPriority = "Low";
  static const mediumPriority = "Medium";
  static const highPriority = "High";

  //TabBarSection
  static const tabMyTasks = "My Tasks";
  static const tabTaskTracker = "Task Tracker";
  static const tabOngoing = "Ongoing & Pending Tasks";
  static const tabWorkSummary = "Work Summary";
  static const sortBy = "Sort by:";
  static const deadline = "Deadline";
  static const project = "Project";

  //SimpleTaskCard
  static const start = "Start";

  //OngoingPendingTaskCard
  static const donePercentage = "% Done";
  static const ongoingStatus = "Status: ";
  static const startDate = "Start date: ";
  static const assignedDate = "Assigned date: ";
  static const expectedCompletion = "Expected completion: ";
  static const ongoingDueDate = "Due date: ";
  static const ongoingPriority = "Priority ";

  // LeaveScreenAppBar
  static const search = "Search";
  static const searchHistory = "Search History";
  static const sickLeave = "Sick Leave...";
  static const casualLeave = "Casual Leaves..";
  static const mayDate = "05 May 2025";
  static const sampleSearchDate = "23 May 2025...";

  //LeaveOverviewChart
  static const leaveOverview = "Leave Overview";
  static const leaveDistribution =
      "Your leave distribution for the current year";
  static const leaveDaysTaken = "Leave days taken";
  static const totalDays = "Total days";
  static const remaining = "Remaining";
  static const qLabelPrefix = "Q";

  //AttendanceScreen
  static const String workMode = "Work Mode";
  static const String verification = "Verification";
  static const String selfie = "Selfie";
  static const String location = "Location";
  static const String locationValue = "Lat:13.05,Long:80.24";
  static const String notes = "Notes";
  static const String checkIn = "Check-in";
  static const String checkInTime = "09:30 AM";
  static const String checkOut = "Check-out";
  static const String checkOutTime = "06:00 PM";
  static const String present = "Present";
  static const String office = "Office";
  static const String workedNote = "Worked On UI Bug Fixing";
  static const String june18 = "June 18, 2025";
  static const String monthYearFormat = "MMMM yyyy";
  static const String attendanceCalendar = "Attendance Calendar";

  //HolidayScreen
  static const String totalHolidays = "Total \nHolidays";
  static const String inAYear = "In a year";
  static const String upcomingHolidays = "Upcoming\nHolidays";
  static const String bakridNote = "(Bakrid-17 jun)";
  static const String remainingThisMonth = "29 days remaining this month";

  static const String public = "Public";
  static const String optional = "Optional";
  static const String company = "Company";

  static const String dateHeader = "Date";
  static const String dayHeader = "Day";
  static const String holidayName = "Holiday Name";
  static const String type = "Type";
  static const String note = "Note";

  static const String date1 = "17 June";
  static const String date2 = "15 August";
  static const String date3 = "23 October";

  static const String day1 = "Tuesday";
  static const String day2 = "Thursday";
  static const String day3 = "Wednesday";

  static const String holiday1 = "Bakrid";
  static const String holiday2 = "Independence Day";
  static const String holiday3 = "Diwali";

  static const String type1 = "Public Holiday";
  static const String type2 = "National Holiday";
  static const String type3 = "Optional";

  static const String note1 = "Company-wide holiday";
  static const String note2 = "Paid Leave";
  static const String note3 = "Can be applied";

  //LeaveStatusScreen
  static const String leaveBalance = "Leave Balance";
  static const String approvedLeaves = "Approved Leaves";
  static const String rejectedLeaves = "Rejected Leaves";
  static const String upcomingLeaves = "Upcoming\n Leaves";
  static const String scheduled = "Scheduled(25 June)";
  static const String leaveStatusDaysRemaining =
      "29 days remaining this month ";
  static const String valueLeaveTaken = "16 days";
  static const String valueLeaveBalance = "8 days";
  static const String valuePendingRequest = "1 request";
  static const String valueApproved = "5 leaves";
  static const String valueRejected = "2 leaves";
  static const String valueUpcoming = "11 leaves";
  static const String subtitleLeaveTaken = "10 days remaining this month";
  static const String approved = "Approved";
  static const String pending = "Pending";
  static const String rejected = "Rejected";

  // PayslipScreen
  static const payslip = 'Payslip';
  static const ziyaAcademy = 'ZiyaAcademy';
  static const keyToSuccess = 'KEY-TO SUCCESS';
  static const payslipForTheMonth = 'Payslip for the Month';
  static const payslipMonth = 'June 2025';
  static const employeeSummary = 'EMPLOYEE SUMMARY';
  static const designation = 'Designation';
  static const dateOfJoining = 'Date of Joining';
  static const payPeriod = 'Pay Period';
  static const payDate = 'Pay Date';
  static const employeeNetPay = 'Employee Net Pay';
  static const paidDays = 'Paid Days';
  static const lopDays = 'LOP Days';
  static const pfAccountNumber = 'PF A/C Number:';
  static const uan = 'UAN:';
  static const earnings = 'EARNINGS';
  static const deductions = 'DEDUCTIONS';
  static const amount = 'AMOUNT';
  static const ytd = 'YTD';
  static const grossEarnings = 'Gross Earnings ₹55,000';
  static const totalDeductions = 'Total Deductions ₹10,000';
  static const totalNetPayable = 'Total Net Payable';
  static const netPayFormula = 'Gross Earnings - Total Deductions';
  static const amountInWords =
      'Amount in Words:     Indian Rupee Forty-Five Thousand Only';
  static const autoGeneratedNote =
      '-This document has been automatically generated by Ziya Academy';
  static const downloadPdf = 'Download the sample salary slip format for PDF';
  static const payslipHistory = 'Monthly Payslip History';
  static const payslipGenerated = "✅Generated";
  static const payslipDownload = "📥 Download";
  static const payslipForMonth = "Payslip for the Month";
  static const earningsAndDeductions = "Earnings & Deductions";
  static const netFormula = "Gross Earnings - Total Deductions";
  static const autoGenerated = "This is a computer-generated payslip.";
  static const storageDenied = "Storage permission denied.";
  static const errorMonthData = "Error: Payslip data not found for ";

  //Reports screen
  static const reportsTitle = "Reports";
  static const workingDaysValue = "22 days";
  static const totalHoursValue = "145 hrs";
  static const tasksCompleted = "Task\n Completed";
  static const completedValue = "35";
  static const avgDailyHours = "Average\n Daily Hours";
  static const avgHoursValue = "6.6";
  static const thisMonth = "(This Month)";
  static const thisMonthSmall = "this month";
  static const hoursPerDay = "hrs/day";
  static const String attendance = "Attendance";
  static const String avgHours = "Avg hrs";
  static const List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  static const String dailyClockLog = "Daily Clock-In/Out Log";
  static const String date = "Date";
  static const String totalHrs = "Total Hrs";
  static const String hrsSuffix = "hrs";
  static const String absent = "Absent";
  static const String halfDay = "Half Day";

  //profile
  static const String startWork = 'Start work';
  static const String name = 'Name';
  static const String empIdNO = 'EMP00123';
  static const String department = 'Department';
  static const userDesignation = 'Full-Stack Developer';
  static const departmentName = 'Software Development Team';
  //notification screen
  static const String notificationTitle = "Notifications";
  static const missedPunch = 'Missed Punch';
  static const missedPunchMessage =
      'Missed Clock-in Detected. Please update your attendance or contact HR.';
  static const missed = "missed";

  static const lateAttendance = 'Late Attendance';
  static const lateAttendanceMessage =
      'You’re running late! Your clock-in time is beyond the scheduled shift start.';

  static const dailySummary = 'Daily Summary';
  static const summary = 'summary';
  static const dailySummaryMessage =
      'Your attendance today: Clock-in at 9:12 AM, Clock-out at 6:05 PM. Total hours: 8.53';

  static const leaveApproval = 'Leave Approval';
  static const approval = 'approval';
  static const leaveApprovalMessage =
      'Your leave request for June 15 has been approved. Enjoy your day off!';

  static const leaveRejection = 'Leave Rejection';
  static const rejection = 'rejection';
  static const leaveRejectionMessage =
      'Leave request declined. Please check with your manager for details.';

  static const shiftUpdate = 'Shift Update';
  static const shift = 'shift';
  static const shiftUpdateMessage =
      'Shift updated: New shift time is 10:00 AM – 7:00 PM, effective from June 14.';
  //search
  static const String noRecentSearches = "No recent searches.";
  static const String searchHintDateFormat = "dd MMMM yyyy";
  static const String checkInDateFormat = "dd-MMMM-yyyy";
}
