class ApiUrls{
  static String baseUrl = "https://oms.siddharthinfosys.com/api";
  static String requestOtp = "${baseUrl}/requestotp";
  static String ValidateOtp = "${baseUrl}/validateotp";
  static String allCategoryList = "${baseUrl}/getcategoryList";
  static String allSubCategoryList = "${baseUrl}/getcategoryList/";
  static String addCustomer = "${baseUrl}/addcustomer";
  static String editCustomer = "${baseUrl}/editcustomer";
  static String updateProfile = "${baseUrl}/editprofile";
  static String customerList = "${baseUrl}/customers";
  static String aboutUs = "${baseUrl}/aboutus";
  static String dashBoardUrl = "${baseUrl}/dashquery";
  static String customerDetails = "${baseUrl}/customerdetail";
  static String orderPlaceUrl = "${baseUrl}/createOrder";
  static String otpVerifyForOrderConfirmation = "${baseUrl}/verifyOrderOtp";
  static String resendOtpVerifyForOrderConfirmation = "${baseUrl}/resendOrderOtp";
  static String allOrderList = "${baseUrl}/orderList";
  static String orderDetails = "${baseUrl}/orderDetail";
}