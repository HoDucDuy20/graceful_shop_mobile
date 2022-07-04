//baseUrl
// String baseUrl = 'http://10.0.2.2:8000/';
String baseUrl = 'http://192.168.1.5:8000/';
// String baseUrl = 'http://172.20.2.162:8000/';

//parse uri
Uri uri(String url) => Uri.parse(url);

//format
Uri formaterApi(String url) => uri('${baseUrl}api/$url');

String formaterImg(String url){
  if(url.substring(0,8)=='https://') {
    return url;
  }
  return baseUrl + url;
}

//url api
Uri uriProductNew(int page) => formaterApi('product-new-view?page=$page');

Uri uriProductPopular(int page) => formaterApi('product-popular-view?page=$page');
 
Uri uriProductById(int id) => formaterApi('product-byid/$id');

Uri uriProductTypeById(int id, int page) => formaterApi('product-type-byid/$id?page=$page');

Uri uriProductCategoryById(int id, int page) => formaterApi('product-category-byid/$id?page=$page');

Uri uriProductSearch(String value, int page) => formaterApi('product-search/$value?page=$page');

Uri uriProductTypeSearch(String value) => formaterApi('product-type-search/$value');

Uri uriCategory() => formaterApi('category');

Uri uriSlideShow() => formaterApi('slide-show');

Uri uriSlideShowDetail(int id) => formaterApi('slide-show-detail/$id');

Uri uriRegister() => formaterApi('register');

Uri uriLogIn() => formaterApi('login');

Uri uriLogOut() => formaterApi('logout');

Uri uriChangePass() => formaterApi('change_pass');

Uri uriUserInfo() => formaterApi('user-info');

Uri uriChangeAvatar() => formaterApi('change-avatar');

Uri uriChangeInfo() => formaterApi('change-info');

Uri uriProductFavorite() => formaterApi('product-like');

Uri uriFavorite() => formaterApi('like');

Uri uriRateOfProduct() => formaterApi('rate-of-product');

Uri uriRateProduct() => formaterApi('rate-product'); 

Uri uriEditRateProduct() => formaterApi('edit-rate-product'); 

Uri uriProductCart() => formaterApi('product-cart');

Uri uriAddCart() => formaterApi('add-cart');

Uri uriUpdateCart() => formaterApi('update-cart');

Uri uriDeleteCart() => formaterApi('delete-cart');

Uri uriAddInvoice() => formaterApi('add-invoice');

Uri uriInvoiceList() => formaterApi('invoice-list');

Uri uriInvoiceDetail(int id) => formaterApi('invoice-detail/$id');

Uri uriCancelInvoice() => formaterApi('cancel-invoice');

Uri uriVoucherList() => formaterApi('voucher-list');

Uri uriAddressList() => formaterApi('address-list');

Uri uriAddAddress() => formaterApi('add-address');

Uri uriEditAddress() => formaterApi('edit-address');

Uri uriDeleteAddress() => formaterApi('delete-address');

Uri uriSendFeedback() => formaterApi('send-feedback');

Uri uriProductNotYedRated() => formaterApi('product-not-yed-rated');

Uri uriProductRated() => formaterApi('product-rated');

Uri uriRatedDetail(int id) => formaterApi('rated-detail/$id');

Uri uriRequestOtp() => formaterApi('request-otp');

// Uri uriVerifyOtp() => formaterApi('verify-otp');

Uri uriForgotPass() => formaterApi('forgot-pass');

Uri uriInfoShop() => formaterApi('info-shop');

Uri uriLoginWithGoogle() => formaterApi('login-with-google');

Uri uriCreateOrder() => uri('https://sb-openapi.zalopay.vn/v2/create');