import 'package:flutter/foundation.dart';
import 'package:fragvest_mobile/model/dashboard_model.dart' as dashboard;
import 'package:fragvest_mobile/model/all_properties_model.dart' as property;
import 'package:fragvest_mobile/model/watch_list_model.dart' as watch;
import 'package:fragvest_mobile/model/portfolio_model.dart' as portfoliomod;
import 'package:fragvest_mobile/model/portfolio_model.dart';
import 'package:fragvest_mobile/model/property_by_type_model.dart' as rsi;

import '../model/fee_model.dart';

class ServiceProvider extends ChangeNotifier {
  dashboard.Data _dataDashboardModel;
  List<dashboard.Properties> _trending;
  dashboard.Properties _selectedTrending;
  List<dashboard.Portfolio> _portfolio;
  dashboard.Portfolio _selectedPortfolio;
  List<dashboard.Properties1> _latest;
  // List<dashboard.Posts> _posts;
  dashboard.Portfolio _selectedPost;
  dashboard.Properties1 _selectedLatest;
  property.Data _propertyData;
  watch.Data _watchlistData;
  rsi.Data _rsiData;
  portfoliomod.Properties _portfolioData;
  PortfolioModel _portfolioModel;
  AssetAllocation _assetAllocation;
  FeeModel _feeModel;
  String _passwordVerifyEmail;
  String _passwordResetToken;
  String _signupEmail;
  String _ticketId;
  int _portFolorInWatchlistNewValue = 0;
  int _propertInWatchlistNewValue = 0;
  String _chatStatus;

  String _authorizationUrl;
  String _accessCode;
  String _reference;

  //Define User Details
  String _firstName;
  String _lastName;
  String _walletBalance;
  String _imageUrl;
  String _email;
  String _phoneNumber;

  //Sorted Values
  String _rsiType;
  String _priceRange;
  String _propertyType;
  String _rooms;
  String _bedroom;
  bool _allProperty;
  Future<Object> _getPropety;

  //get values
  dashboard.Data get dataDashboardModel => _dataDashboardModel;
  List<dashboard.Properties> get trending => _trending;
  dashboard.Properties get selectedTrending => _selectedTrending;
  List<dashboard.Portfolio> get portfolio => _portfolio;
  dashboard.Portfolio get selectedPosr => _selectedPost;
  dashboard.Portfolio get selectedPortfolio => _selectedPortfolio;
  List<dashboard.Properties1> get latest => _latest;
  // List<dashboard.Posts> get posts => _posts;
  dashboard.Portfolio get selectedPost => _selectedPost;
  dashboard.Properties1 get selectedLatest => _selectedLatest;
  property.Data get propertyData => _propertyData;
  watch.Data get watchlistData => _watchlistData;
  rsi.Data get rsiData => _rsiData;
  portfoliomod.Properties get portfolioData => _portfolioData;
  PortfolioModel get portfolioModel => _portfolioModel;
  AssetAllocation get assetAllocation => _assetAllocation;
  FeeModel get feeModel => _feeModel;
  String get passwordVerifyEmail => _passwordVerifyEmail;
  String get passwordResetToken => _passwordResetToken;
  String get signupEmail => _signupEmail;
  String get ticketId => _ticketId;
  int get portFolorInWatchlistNewValue => _portFolorInWatchlistNewValue;
  int get propertInWatchlistNewValue => _propertInWatchlistNewValue;
  String get chatStatus => _chatStatus;
  String get authorizationUrl => _authorizationUrl;
  String get accessCode => _accessCode;
  String get reference => _reference;

  //Get user details
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get walletBalance => _walletBalance;
  String get imageUrl => _imageUrl;
  String get email => _email;
  String get phoneNumber => _phoneNumber;

  String get rsiType => _rsiType;
  String get priceRange => _priceRange;
  String get propertyType => _propertyType;
  String get rooms => _rooms;
  String get bedroom => _bedroom;
  bool get allProperty => _allProperty;
  Future<Object> get getPropety => _getPropety;

  //Set values
  setDataDashboard(dashboard.Data data) {
    _dataDashboardModel = data;
  }

  setTrending(List<dashboard.Properties> trend) {
    _trending = trend;
  }

  setSelectedTrending(dashboard.Properties seletectedTrend) {
    _selectedTrending = seletectedTrend;
  }

  setPortfolio(List<dashboard.Portfolio> portfo) {
    _portfolio = portfo;
  }

  setSelectedPortfolio(dashboard.Portfolio selectedPort) {
    _selectedPost = selectedPort;
  }

  setSelectedPost(dashboard.Portfolio post) {
    _selectedPortfolio = post;
  }

  setLatest(List<dashboard.Properties1> latesT) {
    _latest = latesT;
  }

  // setPosts(List<dashboard.Posts> post) {
  //   _posts = post;
  // }

  setSelectedLatest(dashboard.Properties1 selectedLet) {
    _selectedLatest = selectedLet;
  }

  setPropertyData(property.Data properties) {
    _propertyData = properties;
  }

  setWatchlistData(watch.Data watchlist) {
    _watchlistData = watchlist;
  }

  setRsiData(rsi.Data rsiD) {
    _rsiData = rsiD;
  }

  setPortfolioData(portfoliomod.Properties port) {
    _portfolioData = port;
  }

  setPortfolioModel(PortfolioModel portfolioM) {
    _portfolioModel = portfolioM;
  }

  setAssetAllocation(AssetAllocation asset) {
    _assetAllocation = asset;
  }

  setFeeModel(FeeModel fee) {
    _feeModel = fee;
  }

  setPasswordVerifyEmail(String passwordVerify) async {
    _passwordVerifyEmail = passwordVerify;
  }

  setPasswordResetToken(String emailToken) {
    _passwordResetToken = emailToken;
  }

  setSignupEmail(String email) {
    _signupEmail = email;
  }

  setTicket(String ticket) {
    _ticketId = ticket;
  }

  setportFolorWatchlistNewValue(int newValue) {
    _portFolorInWatchlistNewValue = newValue;
  }

  setpropertWatchlistNewValue(int newValue) {
    _propertInWatchlistNewValue = newValue;
  }

  setChatStatus(String chat) {
    _chatStatus = chat;
  }

  setAuthorizationUrl(String auth) {
    _authorizationUrl = auth;
  }

  setAccessCode(String code) {
    _accessCode = code;
  }

  setReference(String ref) {
    _reference = ref;
  }

  //Set User Detail
  setUserDetail(
      {String first,
      String last,
      String balance,
      // String image,
      String mail,
      String phone}) {
    _firstName = first;
    _lastName = last;
    _walletBalance = balance;
    _email = mail;
    _phoneNumber = phone;
    notifyListeners();
  }

  setuserImage({String image}) {
    _imageUrl = image;
    notifyListeners();
  }

  setRSIType(String type) {
    _rsiType = type;
  }

  setPriceRange(String price) {
    _priceRange = price;
  }

  setPropertyType(String protype) {
    _propertyType = protype;
    // notifyListeners();
  }

  setRooms(String room) {
    _rooms = room;
  }

  setBedRoom(String bed) {
    _bedroom = bed;
  }

  setAllProerty(bool all) {
    _allProperty = all;
  }

  setGetProperty(Future<Object> properti) {
    _getPropety = properti;
    // notifyListeners();
  }

  int _count = 0;
  int get count => _count;
  increaseCount() {
    _count++;
    notifyListeners();
  }
}
