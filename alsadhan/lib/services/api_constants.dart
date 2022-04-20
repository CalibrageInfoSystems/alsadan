library APIContants;

// var BASEURL ='http://183.82.111.111/SPAR/API/api/';  
var BASEURL ='http://183.82.111.111/ALSADHAN/API/api/';
//var BASEURL ='http://183.82.111.111/ECOM/API/api/';
var GETALLCATEGORIES ='Category/GetAllCategories/null/true';
var LOGINURL = 'User/CustomerLogin';
var SIGNUPURL = 'User/Register';
var PRODUCTSURL = "Product/GetProductsByCategoryId";
var PRODUCT_SEARCHURL = "Product/GetProductsByName";
var STORES_URL= "Store/GetAllStores/null/1";
var PLACEORDER_URL='/Order/PlaceOrder';
var COUNTRY_URL ="GeoLocation/GetAllCountries/null/true";
var CITYBYCOUNTRY_URL="GeoLocation/GetAllCities/1/null/true";
var AREAS_BYCITYNAMEURL="GeoLocation/GetAllAreas/Riyadh";
var LOCATIONS_BYCITYIDURL="GeoLocation/GetAllLocations/1/null/true";
var MYORDERS ='Order/GetUserOrders';
var DELIVERSLOTSURL = "Order/GetDeliverySlot";
var DELIVERYORDERDETAIL = 'Product/GetProductsByOrder/';
var UPDATEPROFILE = 'User/AddUpdateUserInfo';
var CANCELORDERURL = "Order/UpdateOrderStatus";
var ADDRESS_URL = "User/Register";
var USERINFOURL = "User/GetUserInfoById/";
var AREANAMESURL = "GeoLocation/GetAllAreas/";     // Sting - cityname
var GET_CARTDETAILS ='Cart/GetCartByUserId/';
var POST_CART ='Cart/AddUpdateCart';
var CLEAR_CART ='Cart/DeleteCartByUserId/';
var CHANGE_PASSWORD = 'User/ChangePassword/';






