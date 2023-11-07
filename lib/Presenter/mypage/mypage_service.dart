class MypageService {
  final loginURL = '/users';

  static final MypageService _mypageService = MypageService._();
  MypageService._();
  factory MypageService() {
    return _mypageService;
  }
}
