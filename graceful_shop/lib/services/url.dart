//baseUrl
// String baseUrl = 'http://10.0.2.2:8000/';
String baseUrl = 'http://192.168.1.3:8000/';
// String baseUrl = 'http://172.20.2.162:8000/';
//parse uri
Uri uri(String url) => Uri.parse(url);
//format
Uri formaterApi(String url) => uri(baseUrl + 'api/' + url);
String formaterImg(String url) => (baseUrl + url);
//url api
Uri productNew(int page) => formaterApi('product-new-view?page=$page');
Uri productPopular(int page) => formaterApi('product-popular-view?page=$page');
Uri productById(int id) => formaterApi('product-byid/$id');
Uri productTypeById(int id, int page) => formaterApi('product-type-byid/$id?page=$page');
Uri productSearch(int value) => formaterApi('product-search/$value');
Uri category() => formaterApi('category');
Uri slideShow() => formaterApi('slide-show');
Uri slideShowDetail(int id) => formaterApi('slide-show-detail/$id');
