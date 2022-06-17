//baseUrl
// String baseUrl = 'http://10.0.2.2:8000/';
String baseUrl = 'http://192.168.1.6:8000/';
// String baseUrl = 'http://172.20.2.162:8000/';

//parse uri
Uri uri(String url) => Uri.parse(url);

//format
Uri formaterApi(String url) => uri('${baseUrl}api/$url');

String formaterImg(String url) => (baseUrl + url);

//url api
Uri uriProductNew(int page) => formaterApi('product-new-view?page=$page');

Uri uriProductPopular(int page) => formaterApi('product-popular-view?page=$page');

Uri uriProductById(int id) => formaterApi('product-byid/$id');

Uri uriProductTypeById(int id, int page) => formaterApi('product-type-byid/$id?page=$page');

Uri uriProductCategoryById(int id, int page) => formaterApi('product-category-byid/$id?page=$page');

Uri uriProductSearch(String value, int page) => formaterApi('product-search/$value?page=$page');

Uri uriCategory() => formaterApi('category');

Uri uriSlideShow() => formaterApi('slide-show');

Uri uriSlideShowDetail(int id) => formaterApi('slide-show-detail/$id');

Uri uriLogIn() => formaterApi('login');

Uri uriRegister() => formaterApi('register');

Uri uriLogOut() => formaterApi('logout');

Uri uriChangePass() => formaterApi('change_pass');

Uri uriUserInfo() => formaterApi('user-info');

Uri uriChangeAvatar() => formaterApi('change-avatar');

Uri uriChangeInfo() => formaterApi('change-info');

Uri uriFavorite() => formaterApi('like');

Uri uriProductFavorite() => formaterApi('product-like');

Uri uriRateOfProduct() => formaterApi('rate-of-product');

Uri uriAddCart() => formaterApi('add-cart');

Uri uriUpdateCart() => formaterApi('update-cart');

Uri uriProductCart() => formaterApi('product-cart');

Uri uriDeleteCart() => formaterApi('delete-cart');