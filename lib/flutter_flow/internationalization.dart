import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'fr', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? frText = '',
    String? arText = '',
  }) =>
      [enText, frText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // SearchPage
  {
    'hgan7uhb': {
      'en': 'Search',
      'ar': 'بحث',
      'fr': 'Rechercher',
    },
    'qepaplr0': {
      'en': 'Find, filter and sort movies & TV shows',
      'ar': 'ابحث عن الأفلام والمسلسلات وصفِّها ورتّبها',
      'fr': 'Trouvez, filtrez et triez films et séries',
    },
    'drtoyoxy': {
      'en': 'Search titles (optional)',
      'ar': 'ابحث عن عنوان (اختياري)',
      'fr': 'Rechercher un titre (facultatif)',
    },
    'su8yujy2': {
      'en': 'Movies',
      'ar': 'أفلام',
      'fr': 'Films',
    },
    '1ds2f12t': {
      'en': 'Movies',
      'ar': 'أفلام',
      'fr': 'Films',
    },
    'hk0jfni8': {
      'en': 'TV shows',
      'ar': 'مسلسلات',
      'fr': 'Séries',
    },
    'hl22tx7x': {
      'en': 'TV shows',
      'ar': 'مسلسلات',
      'fr': 'Séries',
    },
    'xft0h431': {
      'en': 'Popular',
      'ar': 'الأكثر شعبية',
      'fr': 'Populaires',
    },
    '1c8jgc05': {
      'en': 'Popular',
      'ar': 'الأكثر شعبية',
      'fr': 'Populaires',
    },
    'lhvii9u0': {
      'en': 'Top rated',
      'ar': 'الأعلى تقييمًا',
      'fr': 'Mieux notés',
    },
    '6ys9xrka': {
      'en': 'Top rated',
      'ar': 'الأعلى تقييمًا',
      'fr': 'Mieux notés',
    },
    's65zt5n6': {
      'en': 'Newest',
      'ar': 'الأحدث',
      'fr': 'Plus récents',
    },
    'ybn3ygj0': {
      'en': 'Newest',
      'ar': 'الأحدث',
      'fr': 'Plus récents',
    },
    'mr6fjqgb': {
      'en': 'Genre',
      'ar': 'النوع',
      'fr': 'Genre',
    },
    'nn86r28f': {
      'en': 'All',
      'ar': 'الكل',
      'fr': 'Tous',
    },
    'lm66vz7h': {
      'en': 'All',
      'ar': 'الكل',
      'fr': 'Tous',
    },
    'w8d7vpqr': {
      'en': 'Action',
      'ar': 'أكشن',
      'fr': 'Action',
    },
    'q626yix5': {
      'en': 'Action',
      'ar': 'أكشن',
      'fr': 'Action',
    },
    'i5scbcyx': {
      'en': 'Comedy',
      'ar': 'كوميديا',
      'fr': 'Comédie',
    },
    'b9yo86na': {
      'en': 'Comedy',
      'ar': 'كوميديا',
      'fr': 'Comédie',
    },
    't0ymxly4': {
      'en': 'Drama',
      'ar': 'دراما',
      'fr': 'Drame',
    },
    'mgky31uk': {
      'en': 'Drama',
      'ar': 'دراما',
      'fr': 'Drame',
    },
    'rn2vjfsy': {
      'en': 'Sci-Fi',
      'ar': 'خيال علمي',
      'fr': 'Science-fiction',
    },
    '8o6lf4uk': {
      'en': 'Sci-Fi',
      'ar': 'خيال علمي',
      'fr': 'Science-fiction',
    },
    'tudxaerj': {
      'en': 'Animation',
      'ar': 'رسوم متحركة',
      'fr': 'Animation',
    },
    '4ulugo8k': {
      'en': 'Animation',
      'ar': 'رسوم متحركة',
      'fr': 'Animation',
    },
    'jfn7s33f': {
      'en': 'Crime',
      'ar': 'جريمة',
      'fr': 'Policier',
    },
    '9n138cmb': {
      'en': 'Crime',
      'ar': 'جريمة',
      'fr': 'Policier',
    },
    'nt8arqp9': {
      'en': 'Mystery',
      'ar': 'غموض',
      'fr': 'Mystère',
    },
    '2j34hjwp': {
      'en': 'Mystery',
      'ar': 'غموض',
      'fr': 'Mystère',
    },
    't470i1g1': {
      'en': 'Documentary',
      'ar': 'وثائقي',
      'fr': 'Documentaire',
    },
    'pb6gyvqp': {
      'en': 'Documentary',
      'ar': 'وثائقي',
      'fr': 'Documentaire',
    },
    '72h1ssof': {
      'en': 'Family',
      'ar': 'عائلي',
      'fr': 'Famille',
    },
    'rues6jqp': {
      'en': 'Family',
      'ar': 'عائلي',
      'fr': 'Famille',
    },
    'qvugxo6p': {
      'en': 'Fantasy',
      'ar': 'فانتازيا',
      'fr': 'Fantastique',
    },
    'adu1yizu': {
      'en': 'Fantasy',
      'ar': 'فانتازيا',
      'fr': 'Fantastique',
    },
    'c9bmpbnx': {
      'en': 'Release year',
      'ar': 'سنة الإصدار',
      'fr': 'Année de sortie',
    },
    'j25ti5fe': {
      'en': 'Any',
      'ar': 'الكل',
      'fr': 'Toutes',
    },
    '6cfll18v': {
      'en': 'Any',
      'ar': 'الكل',
      'fr': 'Toutes',
    },
    'mhl2mvab': {
      'en': '2026',
      'ar': '',
      'fr': '',
    },
    'o89hnax2': {
      'en': '2026',
      'ar': '',
      'fr': '',
    },
    '5du4du6o': {
      'en': '2025',
      'ar': '',
      'fr': '',
    },
    'kpyvp8q4': {
      'en': '2025',
      'ar': '',
      'fr': '',
    },
    '0cc5azjv': {
      'en': '2024',
      'ar': '',
      'fr': '',
    },
    'm785rbdt': {
      'en': '2024',
      'ar': '',
      'fr': '',
    },
    'y61zrqu4': {
      'en': '2023',
      'ar': '',
      'fr': '',
    },
    '2at4791i': {
      'en': '2023',
      'ar': '',
      'fr': '',
    },
    'm4g44dft': {
      'en': '2022',
      'ar': '',
      'fr': '',
    },
    'jldrey1s': {
      'en': '2022',
      'ar': '',
      'fr': '',
    },
    '9ruhyysj': {
      'en': '2021',
      'ar': '',
      'fr': '',
    },
    '26mi7snc': {
      'en': '2021',
      'ar': '',
      'fr': '',
    },
    '5jdpk0cz': {
      'en': '2020',
      'ar': '',
      'fr': '',
    },
    'xrriufjd': {
      'en': '2020',
      'ar': '',
      'fr': '',
    },
    '65ltdwlm': {
      'en': '2018',
      'ar': '',
      'fr': '',
    },
    '9s9q31nb': {
      'en': '2018',
      'ar': '',
      'fr': '',
    },
    'qpgkhpcw': {
      'en': '2015',
      'ar': '',
      'fr': '',
    },
    'dde0qvqz': {
      'en': '2015',
      'ar': '',
      'fr': '',
    },
    '76s4j2q1': {
      'en': '2010',
      'ar': '',
      'fr': '',
    },
    'pkzmldci': {
      'en': '2010',
      'ar': '',
      'fr': '',
    },
    'm62lzn7v': {
      'en': '2005',
      'ar': '',
      'fr': '',
    },
    'pdwbz5tr': {
      'en': '2005',
      'ar': '',
      'fr': '',
    },
    'l6xndg0m': {
      'en': '2000',
      'ar': '',
      'fr': '',
    },
    'md05phkl': {
      'en': '2000',
      'ar': '',
      'fr': '',
    },
    '2qj7wki1': {
      'en': 'Minimum rating',
      'ar': 'أدنى تقييم',
      'fr': 'Note minimale',
    },
    'gdfzs699': {
      'en': 'Any',
      'ar': 'الكل',
      'fr': 'Toutes',
    },
    'ur0fg1mn': {
      'en': 'Any',
      'ar': 'الكل',
      'fr': 'Toutes',
    },
    'vkxj2e4w': {
      'en': '6+ stars',
      'ar': '6+ نجوم',
      'fr': '6+ étoiles',
    },
    'm3lhqazk': {
      'en': '6+ stars',
      'ar': '6+ نجوم',
      'fr': '6+ étoiles',
    },
    '4zszh73c': {
      'en': '7+ stars',
      'ar': '7+ نجوم',
      'fr': '7+ étoiles',
    },
    'jamv4n9z': {
      'en': '7+ stars',
      'ar': '7+ نجوم',
      'fr': '7+ étoiles',
    },
    'ohtcno0t': {
      'en': '8+ stars',
      'ar': '8+ نجوم',
      'fr': '8+ étoiles',
    },
    'cmvdk5eg': {
      'en': '8+ stars',
      'ar': '8+ نجوم',
      'fr': '8+ étoiles',
    },
    'udcqxuzl': {
      'en': 'Clear filters',
      'ar': 'مسح الفلاتر',
      'fr': 'Effacer les filtres',
    },
    'd7fgsb2k': {
      'en': 'Retry',
      'ar': 'إعادة المحاولة',
      'fr': 'Réessayer',
    },
    'wljqjzkq': {
      'en': 'Loading more…',
      'ar': 'جارٍ تحميل المزيد…',
      'fr': 'Chargement…',
    },
    '7egrjh7z': {
      'en': 'Retry',
      'ar': 'إعادة المحاولة',
      'fr': 'Réessayer',
    },
    'navsrch1': {
      'en': 'Search',
      'ar': 'بحث',
      'fr': 'Rechercher',
    },
  },
  // WatchlistPage
  {
    'u9y18bj6': {
      'en': 'Watchlist',
      'ar': 'قائمة المشاهدة',
      'fr': 'À voir',
    },
    'zq0t3zyd': {
      'en': 'Saved for movie night',
      'ar': 'محفوظة لسهرة الأفلام',
      'fr': 'Gardés pour la soirée ciné',
    },
    'ttremov1': {
      'en': 'Remove',
      'ar': 'إزالة',
      'fr': 'Retirer',
    },
    'navwtch1': {
      'en': 'Watchlist',
      'ar': 'قائمة المشاهدة',
      'fr': 'À voir',
    },
  },
  // ProfilePage
  {
    'jp2psxgb': {
      'en': 'Followers',
      'ar': 'المتابِعون',
      'fr': 'Abonnés',
    },
    'mtuy71k2': {
      'en': 'Following',
      'ar': 'المتابَعون',
      'fr': 'Abonnements',
    },
    'hfhg5yrz': {
      'en': 'Edit profile',
      'ar': 'تعديل الملف الشخصي',
      'fr': 'Modifier le profil',
    },
    'gc2ls2sf': {
      'en': 'Invite friends',
      'ar': 'دعوة الأصدقاء',
      'fr': 'Inviter des amis',
    },
    '5drts498': {
      'en': 'Favorites',
      'ar': 'المفضلة',
      'fr': 'Favoris',
    },
    'hrt9xlo0': {
      'en': 'Watchlist',
      'ar': 'قائمة المشاهدة',
      'fr': 'À voir',
    },
    'k5z7e656': {
      'en': 'Reviews',
      'ar': 'المراجعات',
      'fr': 'Avis',
    },
    'cmjn8hwe': {
      'en': 'Favorites',
      'ar': 'المفضلة',
      'fr': 'Favoris',
    },
    'x3ipouzo': {
      'en': 'Recent',
      'ar': 'الأحدث',
      'fr': 'Récents',
    },
    'qh4tpfz5': {
      'en': 'My reviews',
      'ar': 'مراجعاتي',
      'fr': 'Mes avis',
    },
    '38bxcazn': {
      'en': 'Latest',
      'ar': 'الأحدث',
      'fr': 'Derniers',
    },
    'navprof1': {
      'en': 'Profile',
      'ar': 'الملف الشخصي',
      'fr': 'Profil',
    },
  },
  // MovieDetailsPage
  {
    'ttback01': {
      'en': 'Back',
      'ar': 'رجوع',
      'fr': 'Retour',
    },
    '5u3xqgpr': {
      'en': '/10 · TMDB',
      'ar': '/10 · TMDB',
      'fr': '/10 · TMDB',
    },
    'n0z79wu7': {
      'en': 'Favorited',
      'ar': 'في المفضلة',
      'fr': 'En favori',
    },
    'zb6exn2k': {
      'en': 'Favorite',
      'ar': 'أضف للمفضلة',
      'fr': 'Favori',
    },
    'nz4wvw20': {
      'en': 'In watchlist',
      'ar': 'في قائمة المشاهدة',
      'fr': 'Dans « À voir »',
    },
    'ke7b5ylb': {
      'en': 'Watchlist',
      'ar': 'قائمة المشاهدة',
      'fr': 'À voir',
    },
    'h5piwrea': {
      'en': 'Overview',
      'ar': 'نبذة',
      'fr': 'Synopsis',
    },
    'vtzgdtlg': {
      'en': 'Ratings & reviews',
      'ar': 'التقييمات والمراجعات',
      'fr': 'Notes et avis',
    },
    '3ho96sox': {
      'en': 'YELLO RATING',
      'ar': 'تقييم Yello',
      'fr': 'NOTE YELLO',
    },
    '2ee9nuwp': {
      'en': 'TMDB RATING',
      'ar': 'تقييم TMDB',
      'fr': 'NOTE TMDB',
    },
    'gmv175yu': {
      'en': 'Share your thoughts (optional)',
      'ar': 'شارك رأيك (اختياري)',
      'fr': 'Partagez votre avis (facultatif)',
    },
    'mu87t7ad': {
      'en': 'This review contains spoilers',
      'ar': 'تحتوي هذه المراجعة على حرق للأحداث',
      'fr': 'Cet avis contient des spoilers',
    },
    '29k951e1': {
      'en': 'Cancel',
      'ar': 'إلغاء',
      'fr': 'Annuler',
    },
    '3hhqvfe7': {
      'en': 'Saving…',
      'ar': 'جارٍ الحفظ…',
      'fr': 'Enregistrement…',
    },
    'j2osd8ib': {
      'en': 'What Yello users say',
      'ar': 'آراء مستخدمي Yello',
      'fr': 'Ce qu\'en disent les utilisateurs Yello',
    },
    'tt7sou2e': {
      'en': 'Newest first',
      'ar': 'الأحدث أولًا',
      'fr': 'Plus récents d\'abord',
    },
  },
  // LoginPage
  {
    'bwcaicbv': {
      'en': 'Yello',
      'ar': '',
      'fr': '',
    },
    'rxjlvlr8': {
      'en': 'Rate, review and save the movies & shows you love.',
      'ar': 'قيّم وراجع واحفظ الأفلام والمسلسلات التي تحبها.',
      'fr': 'Notez, commentez et gardez les films et séries que vous aimez.',
    },
    '9nfbyors': {
      'en': 'Email',
      'ar': 'البريد الإلكتروني',
      'fr': 'E-mail',
    },
    'ep8drtc5': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'fr': 'Mot de passe',
    },
    'mn63gqki': {
      'en': 'Forgot password?',
      'ar': 'نسيت كلمة المرور؟',
      'fr': 'Mot de passe oublié ?',
    },
    'i0h1hc0f': {
      'en': 'Log in',
      'ar': 'تسجيل الدخول',
      'fr': 'Se connecter',
    },
    'gejkrv69': {
      'en': 'Don\'t have an account?',
      'ar': 'ليس لديك حساب؟',
      'fr': 'Pas encore de compte ?',
    },
    '08y5fgd6': {
      'en': 'Sign up',
      'ar': 'إنشاء حساب',
      'fr': 'S\'inscrire',
    },
  },
  // SignUpPage
  {
    'z0sa2rdc': {
      'en': 'Back',
      'ar': 'رجوع',
      'fr': 'Retour',
    },
    'xfb318m8': {
      'en': 'Create account',
      'ar': 'إنشاء حساب',
      'fr': 'Créer un compte',
    },
    'r6eehze9': {
      'en': 'Join Yello to keep track of everything you watch.',
      'ar': 'انضم إلى Yello لتتابع كل ما تشاهده.',
      'fr': 'Rejoignez Yello pour suivre tout ce que vous regardez.',
    },
    'albijsa4': {
      'en': 'Display name',
      'ar': 'الاسم الظاهر',
      'fr': 'Nom affiché',
    },
    'unmlbl01': {
      'en': 'Username',
      'ar': 'اسم المستخدم',
      'fr': 'Nom d\'utilisateur',
    },
    'bb5sl531': {
      'en': 'Email',
      'ar': 'البريد الإلكتروني',
      'fr': 'E-mail',
    },
    'xi4d3fwn': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'fr': 'Mot de passe',
    },
    'zci5ssc1': {
      'en': 'Confirm password',
      'ar': 'تأكيد كلمة المرور',
      'fr': 'Confirmer le mot de passe',
    },
    'unmv0001': {
      'en': 'Choose a username',
      'ar': 'اختر اسم مستخدم',
      'fr': 'Choisissez un nom d\'utilisateur',
    },
    'unmv0002': {
      'en': 'At least 3 characters',
      'ar': '3 أحرف على الأقل',
      'fr': 'Au moins 3 caractères',
    },
    'unmv0003': {
      'en': 'At most 20 characters',
      'ar': '20 حرفًا كحد أقصى',
      'fr': '20 caractères maximum',
    },
    'unmv0004': {
      'en': 'Use lowercase letters, numbers, _ and . only',
      'ar': 'استخدم الأحرف الصغيرة والأرقام و _ و . فقط',
      'fr': 'Utilisez uniquement des minuscules, chiffres, _ et .',
    },
    'cnmv3nea': {
      'en': 'Create account',
      'ar': 'إنشاء حساب',
      'fr': 'Créer un compte',
    },
    'ikwqq48l': {
      'en': 'Already have an account?',
      'ar': 'لديك حساب بالفعل؟',
      'fr': 'Vous avez déjà un compte ?',
    },
    '7ipy5rbp': {
      'en': 'Log in',
      'ar': 'تسجيل الدخول',
      'fr': 'Se connecter',
    },
  },
  // DiscoverPage
  {
    'rw3cq2sz': {
      'en': 'Yello',
      'ar': '',
      'fr': '',
    },
    '30hiabxd': {
      'en': 'Friends',
      'ar': 'الأصدقاء',
      'fr': 'Amis',
    },
    'vj6imrlf': {
      'en': 'Movie Match',
      'ar': 'Movie Match',
      'fr': 'Movie Match',
    },
    '75sapegj': {
      'en': 'Invite',
      'ar': 'دعوة',
      'fr': 'Inviter',
    },
    'b7jqh3ra': {
      'en': 'Yello Picks',
      'ar': '',
      'fr': '',
    },
    '2umslegf': {
      'en': 'Not sure what to watch? Tell us your mood.',
      'ar': '',
      'fr': '',
    },
    'fmxrdd4u': {
      'en': 'What are we watching?',
      'ar': 'ماذا سنشاهد؟',
      'fr': 'On regarde quoi ?',
    },
    'pjpnnaza': {
      'en': 'Trending now',
      'ar': 'الرائج الآن',
      'fr': 'Tendances',
    },
    'zwwz65xw': {
      'en': 'This week',
      'ar': 'هذا الأسبوع',
      'fr': 'Cette semaine',
    },
    'd27kktxd': {
      'en': 'Popular movies',
      'ar': 'أفلام شائعة',
      'fr': 'Films populaires',
    },
    'omks2ao7': {
      'en': 'Movies',
      'ar': 'أفلام',
      'fr': 'Films',
    },
    'o0eta41b': {
      'en': 'Trending TV shows',
      'ar': 'مسلسلات رائجة',
      'fr': 'Séries tendance',
    },
    'blcbtu36': {
      'en': 'TV',
      'ar': 'مسلسلات',
      'fr': 'Séries',
    },
    '3e6khytv': {
      'en': 'Popular TV shows',
      'ar': 'مسلسلات شائعة',
      'fr': 'Séries populaires',
    },
    'glslgcur': {
      'en': 'TV',
      'ar': 'مسلسلات',
      'fr': 'Séries',
    },
    'navdisc1': {
      'en': 'Discover',
      'ar': 'اكتشف',
      'fr': 'Découvrir',
    },
  },
  // FavoritesPage
  {
    'yugn2oxj': {
      'en': 'Favorites',
      'ar': 'المفضلة',
      'fr': 'Favoris',
    },
    'v6zci9gv': {
      'en': 'The movies & shows you love',
      'ar': 'الأفلام والمسلسلات التي تحبها',
      'fr': 'Les films et séries que vous aimez',
    },
    'navfavs1': {
      'en': 'Favorites',
      'ar': 'المفضلة',
      'fr': 'Favoris',
    },
  },
  // SettingsPage
  {
    'zhc8ka2s': {
      'en': 'Back',
      'ar': 'رجوع',
      'fr': 'Retour',
    },
    'izfz2a56': {
      'en': 'Settings',
      'ar': 'الإعدادات',
      'fr': 'Paramètres',
    },
    '16jlr59f': {
      'en': 'EDIT PROFILE',
      'ar': 'تعديل الملف الشخصي',
      'fr': 'MODIFIER LE PROFIL',
    },
    'anlg2ism': {
      'en': 'Change profile picture',
      'ar': 'تغيير صورة الملف الشخصي',
      'fr': 'Changer la photo de profil',
    },
    '3ovanddf': {
      'en': 'Change username',
      'ar': '',
      'fr': '',
    },
    'o7snwpkm': {
      'en': 'Display name',
      'ar': 'الاسم الظاهر',
      'fr': 'Nom affiché',
    },
    'vp8k2umc': {
      'en': 'Bio',
      'ar': 'نبذة',
      'fr': 'Bio',
    },
    '35ie9jxp': {
      'en': 'Tell people what you love to watch',
      'ar': 'أخبر الناس بما تحب مشاهدته',
      'fr': 'Dites ce que vous aimez regarder',
    },
    'dsk5k3ss': {
      'en': 'Leave a field empty to keep it as it is.',
      'ar': 'اترك الحقل فارغًا للإبقاء عليه كما هو.',
      'fr': 'Laissez un champ vide pour le conserver.',
    },
    'k465v6o2': {
      'en': 'Save changes',
      'ar': 'حفظ التغييرات',
      'fr': 'Enregistrer',
    },
    '2es4r7j7': {
      'en': 'ACCOUNT',
      'ar': 'الحساب',
      'fr': 'COMPTE',
    },
    '8vb5k21m': {
      'en': 'Send password reset email',
      'ar': 'إرسال بريد إعادة تعيين كلمة المرور',
      'fr': 'Recevoir un e-mail de réinitialisation',
    },
    'ecm8nq02': {
      'en': 'Log out',
      'ar': 'تسجيل الخروج',
      'fr': 'Se déconnecter',
    },
    '05wapimp': {
      'en': 'Delete account',
      'ar': 'حذف الحساب',
      'fr': 'Supprimer le compte',
    },
    'fgktu4tk': {
      'en': 'LANGUAGE',
      'ar': 'اللغة',
      'fr': 'LANGUE',
    },
    'zhyldfe8': {
      'en': 'EN',
      'ar': 'EN',
      'fr': 'EN',
    },
    'h0346buo': {
      'en': 'English',
      'ar': '',
      'fr': '',
    },
    'x8ctfdbr': {
      'en': 'FR',
      'ar': 'FR',
      'fr': 'FR',
    },
    'yax44oh0': {
      'en': 'Français',
      'ar': '',
      'fr': '',
    },
    'emdtf38k': {
      'en': 'AR',
      'ar': 'AR',
      'fr': 'AR',
    },
    '5itc2hl0': {
      'en': 'العربية',
      'ar': '',
      'fr': '',
    },
    '544i192a': {
      'en': 'Show the app tour again',
      'ar': 'عرض جولة التطبيق مجددًا',
      'fr': 'Revoir la présentation',
    },
    'lxvh05ma': {
      'en': 'ABOUT',
      'ar': 'حول',
      'fr': 'À PROPOS',
    },
    'fvd6t0kv': {
      'en': 'Yello',
      'ar': '',
      'fr': '',
    },
    'abrqny5e': {
      'en':
          'Movie & TV data provided by TMDB. This product uses the TMDB API but is not endorsed or certified by TMDB.',
      'ar':
          'بيانات الأفلام والمسلسلات مقدّمة من TMDB. يستخدم هذا المنتج واجهة TMDB البرمجية لكنه غير معتمد أو مصادق عليه من TMDB.',
      'fr':
          'Données films et séries fournies par TMDB. Ce produit utilise l\'API TMDB sans être approuvé ni certifié par TMDB.',
    },
  },
  // ForgotPasswordPage
  {
    'dpf1v8ce': {
      'en': 'Back',
      'ar': 'رجوع',
      'fr': 'Retour',
    },
    'aegulzqd': {
      'en': 'Forgot your password?',
      'ar': 'هل نسيت كلمة المرور؟',
      'fr': 'Mot de passe oublié ?',
    },
    'fkollm8d': {
      'en':
          'No worries. Enter the email you signed up with and we\'ll send you a link to reset it.',
      'ar':
          'لا تقلق. أدخل البريد الذي سجّلت به وسنرسل لك رابطًا لإعادة تعيينها.',
      'fr':
          'Pas de souci. Saisissez l\'e-mail de votre compte et nous vous enverrons un lien de réinitialisation.',
    },
    'lkbu54yq': {
      'en': 'Email',
      'ar': 'البريد الإلكتروني',
      'fr': 'E-mail',
    },
    'jy0kw3y3': {
      'en': 'Send reset link',
      'ar': 'إرسال الرابط',
      'fr': 'Envoyer le lien',
    },
    'zk8y81kq': {
      'en':
          'Can\'t find it? Check your spam folder. The link expires after a while.',
      'ar':
          'لم تجده؟ تحقّق من مجلد الرسائل غير المرغوب فيها. تنتهي صلاحية الرابط بعد فترة.',
      'fr': 'Introuvable ? Vérifiez vos spams. Le lien expire après un moment.',
    },
  },
  // PublicProfilePage
  {
    'pj2x8m51': {
      'en': 'Back',
      'ar': 'رجوع',
      'fr': 'Retour',
    },
    't46mlc0g': {
      'en': 'Followers',
      'ar': 'المتابِعون',
      'fr': 'Abonnés',
    },
    'mv4w4kyc': {
      'en': 'Following',
      'ar': 'المتابَعون',
      'fr': 'Abonnements',
    },
    't1exikx0': {
      'en': 'Reviews',
      'ar': 'المراجعات',
      'fr': 'Avis',
    },
    '8vmq7uyf': {
      'en': 'Favorites',
      'ar': 'المفضلة',
      'fr': 'Favoris',
    },
  },
  // NotificationsPage
  {
    '742mpj7y': {
      'en': 'Back',
      'ar': 'رجوع',
      'fr': 'Retour',
    },
    'lqobg50c': {
      'en': 'Notifications',
      'ar': 'الإشعارات',
      'fr': 'Notifications',
    },
  },
  // FriendsFeedPage
  {
    'uezal5vb': {
      'en': 'Friends',
      'ar': 'الأصدقاء',
      'fr': 'Amis',
    },
    'r2ck9pao': {
      'en': 'Add friends with QR',
      'ar': '',
      'fr': '',
    },
    'l4l6ayzz': {
      'en':
          'Show your code to a friend, or scan theirs to open their profile and add them.',
      'ar': '',
      'fr': '',
    },
    '306qbwd4': {
      'en': 'My QR code',
      'ar': '',
      'fr': '',
    },
    'z6v2lqq0': {
      'en': 'Scan QR code',
      'ar': '',
      'fr': '',
    },
    'rmdxuh4q': {
      'en': 'Add friend by username',
      'ar': '',
      'fr': '',
    },
    '58qgc4i9': {
      'en': 'Follow people to see their reviews',
      'ar': 'تابع الأشخاص لترى مراجعاتهم',
      'fr': 'Suivez des personnes pour voir leurs avis',
    },
    'b08w0i7o': {
      'en': 'Invite friends',
      'ar': 'دعوة الأصدقاء',
      'fr': 'Inviter des amis',
    },
    '08bzctx4': {
      'en': 'Latest from your friends',
      'ar': '',
      'fr': '',
    },
  },
  // MatchHomePage
  {
    'pzj8hp15': {
      'en': 'Movie Match',
      'ar': 'Movie Match',
      'fr': 'Movie Match',
    },
    'flxd699c': {
      'en': 'Pick a movie together',
      'ar': 'اختاروا فيلمًا معًا',
      'fr': 'Choisissez un film ensemble',
    },
    'kblxtvcx': {
      'en': 'Create room',
      'ar': 'إنشاء غرفة',
      'fr': 'Créer un salon',
    },
    'qundsc16': {
      'en': 'Build a deck with Yello Picks',
      'ar': 'أنشئ مجموعة مع Yello Picks',
      'fr': 'Créer un jeu avec Yello Picks',
    },
    'dy2an9o7': {
      'en': 'Join with a code',
      'ar': 'الانضمام برمز',
      'fr': 'Rejoindre avec un code',
    },
    'eoqxfj5s': {
      'en': '6-digit code',
      'ar': 'رمز من 6 أرقام',
      'fr': 'Code à 6 chiffres',
    },
    'nji6wyhc': {
      'en': 'Join',
      'ar': 'انضمام',
      'fr': 'Rejoindre',
    },
    '7oo46opc': {
      'en': 'Invitations',
      'ar': 'الدعوات',
      'fr': 'Invitations',
    },
    '8uzbcc1i': {
      'en': 'Accept',
      'ar': 'قبول',
      'fr': 'Accepter',
    },
  },
  // MatchLobbyPage
  {
    'u3t5t6j3': {
      'en': 'Lobby',
      'ar': 'الردهة',
      'fr': 'Salon',
    },
    'c5s41l6w': {
      'en': 'Room code',
      'ar': 'رمز الغرفة',
      'fr': 'Code du salon',
    },
    '4om4axal': {
      'en': 'Share this code with friends',
      'ar': 'شارك هذا الرمز مع أصدقائك',
      'fr': 'Partagez ce code avec vos amis',
    },
    '0v0eaccz': {
      'en': 'Members',
      'ar': 'الأعضاء',
      'fr': 'Membres',
    },
    'leeleul7': {
      'en': 'Start',
      'ar': 'ابدأ',
      'fr': 'Démarrer',
    },
    'mw6xhnun': {
      'en': 'Waiting for the host to start…',
      'ar': 'بانتظار أن يبدأ المضيف…',
      'fr': 'En attente de l\'hôte…',
    },
    'wkibxxd7': {
      'en': 'Start swiping',
      'ar': 'ابدأ السحب',
      'fr': 'Commencer à swiper',
    },
    'prpqeobc': {
      'en': 'Invite friends',
      'ar': 'دعوة الأصدقاء',
      'fr': 'Inviter des amis',
    },
    'mc77e2iw': {
      'en': 'Invite',
      'ar': 'دعوة',
      'fr': 'Inviter',
    },
  },
  // MatchSwipePage
  {
    'te5473ee': {
      'en': 'Movie Match',
      'ar': 'Movie Match',
      'fr': 'Movie Match',
    },
    'b78gmji8': {
      'en': 'New round started. Continue',
      'ar': 'بدأت جولة جديدة. تابع',
      'fr': 'Nouvelle manche. Continuer',
    },
    '2utfxm5s': {
      'en': 'Pass',
      'ar': 'تخطٍّ',
      'fr': 'Passer',
    },
    '3ofx31fl': {
      'en': 'Like',
      'ar': 'إعجاب',
      'fr': 'J\'aime',
    },
    '9avbu6w7': {
      'en': 'No match this time',
      'ar': 'لا يوجد تطابق هذه المرة',
      'fr': 'Pas de match cette fois',
    },
    't90wffx0': {
      'en': 'You went through the whole deck.',
      'ar': 'لقد استعرضت كل الأفلام.',
      'fr': 'Vous avez parcouru toute la sélection.',
    },
    '1sdwu4jf': {
      'en': 'Restart with a new deck',
      'ar': 'ابدأ من جديد بأفلام جديدة',
      'fr': 'Recommencer avec une nouvelle sélection',
    },
    '4985dy0z': {
      'en': 'It\'s a match!',
      'ar': 'تطابق!',
      'fr': 'C\'est un match !',
    },
    'cp2ywg5h': {
      'en': 'Open details',
      'ar': 'عرض التفاصيل',
      'fr': 'Voir les détails',
    },
    'vfnqz4ew': {
      'en': 'Add to my watchlist',
      'ar': 'أضف إلى قائمة مشاهدتي',
      'fr': 'Ajouter à « À voir »',
    },
  },
  // OnboardingPage
  {
    'gbdo9k5y': {
      'en': 'Yello',
      'ar': '',
      'fr': '',
    },
    'c77vunzo': {
      'en': 'Skip',
      'ar': 'تخطٍّ',
      'fr': 'Passer',
    },
    'wurkfgh8': {
      'en': 'Welcome to Yello',
      'ar': 'مرحبًا بك في Yello',
      'fr': 'Bienvenue sur Yello',
    },
    '54ah8pvs': {
      'en':
          'Discover, rate and save movies and TV shows. Pick what to watch with friends.',
      'ar':
          'اكتشف الأفلام والمسلسلات وقيّمها واحفظها. واختر ما تشاهده مع أصدقائك.',
      'fr':
          'Découvrez, notez et gardez films et séries. Choisissez quoi regarder entre amis.',
    },
    'm2fij9uo': {
      'en': 'Next',
      'ar': 'التالي',
      'fr': 'Suivant',
    },
    'havvtwvy': {
      'en': 'Search & filter',
      'ar': 'البحث والتصفية',
      'fr': 'Rechercher et filtrer',
    },
    'qzfhpdxg': {
      'en':
          'Search any title, then filter by genre, year and rating, and sort by popular, top rated or newest.',
      'ar':
          'ابحث عن أي عنوان، ثم صفِّ حسب النوع والسنة والتقييم، ورتّب حسب الشعبية أو التقييم أو الأحدث.',
      'fr':
          'Cherchez un titre, filtrez par genre, année et note, puis triez par popularité, note ou nouveauté.',
    },
    'g79c5uvb': {
      'en': 'Next',
      'ar': 'التالي',
      'fr': 'Suivant',
    },
    'x0xopq12': {
      'en': 'Favorites & Watchlist',
      'ar': 'المفضلة وقائمة المشاهدة',
      'fr': 'Favoris et À voir',
    },
    'bgh7aq5i': {
      'en':
          'Favorite a title to keep it close, or add it to your watchlist to watch later. Both are in the bottom bar.',
      'ar':
          'أضف عنوانًا إلى المفضلة لتبقيه قريبًا، أو إلى قائمة المشاهدة لتشاهده لاحقًا. ستجدهما في الشريط السفلي.',
      'fr':
          'Ajoutez un titre à vos favoris pour le garder près de vous, ou à votre liste À voir pour plus tard. Les deux sont dans la barre du bas.',
    },
    'emv1m1jy': {
      'en': 'Next',
      'ar': 'التالي',
      'fr': 'Suivant',
    },
    '7f39pb2g': {
      'en': 'Movie Match',
      'ar': 'Movie Match',
      'fr': 'Movie Match',
    },
    'r2035cno': {
      'en':
          'Can\'t decide? Create a room, share its 6-digit code with friends, and swipe together until everyone likes the same movie.',
      'ar':
          'محتار؟ أنشئ غرفة وشارك رمزها المكوّن من 6 أرقام مع أصدقائك، واسحبوا معًا حتى يعجب الجميع الفيلم نفسه.',
      'fr':
          'Indécis ? Créez un salon, partagez son code à 6 chiffres et swipez ensemble jusqu\'à ce que tout le monde aime le même film.',
    },
    '0706gddl': {
      'en': 'Next',
      'ar': 'التالي',
      'fr': 'Suivant',
    },
    'dcihrfkx': {
      'en': 'Join a friend\'s room',
      'ar': 'انضم إلى غرفة صديق',
      'fr': 'Rejoindre le salon d\'un ami',
    },
    'j2cc4xf8': {
      'en':
          'Got a code? Open Movie Match, tap Join with a code, enter the 6 digits and you are in.',
      'ar':
          'لديك رمز؟ افتح Movie Match، واضغط «الانضمام برمز»، وأدخل الأرقام الستة وستنضم فورًا.',
      'fr':
          'Vous avez un code ? Ouvrez Movie Match, touchez « Rejoindre avec un code », saisissez les 6 chiffres et c\'est parti.',
    },
    '11cqdmux': {
      'en': 'Get started',
      'ar': 'ابدأ الآن',
      'fr': 'Commencer',
    },
  },
  // YelloPicksPage
  {
    'wmv7s3ta': {
      'en': 'Back',
      'ar': 'رجوع',
      'fr': 'Retour',
    },
    'av5t9qbz': {
      'en': 'Yello Picks',
      'ar': 'Yello Picks',
      'fr': 'Yello Picks',
    },
    'n8i5v60s': {
      'en': 'Tell us your mood. We pick what to watch.',
      'ar': 'أخبرنا بمزاجك ونحن نختار ما تشاهده.',
      'fr': 'Dites-nous votre humeur. Nous choisissons quoi regarder.',
    },
    '5aqnxao6': {
      'en': 'What are you in the mood for?',
      'ar': '',
      'fr': '',
    },
    'lsa71kpe': {
      'en': 'Movie',
      'ar': 'فيلم',
      'fr': 'Film',
    },
    'rw0hbu51': {
      'en': 'Movie',
      'ar': 'فيلم',
      'fr': 'Film',
    },
    'vl13l66y': {
      'en': 'TV show',
      'ar': 'مسلسل',
      'fr': 'Série',
    },
    '9c96kpu0': {
      'en': 'TV show',
      'ar': 'مسلسل',
      'fr': 'Série',
    },
    'zkfgfp5e': {
      'en': 'Mood',
      'ar': '',
      'fr': '',
    },
    's8cakboj': {
      'en': 'Any mood',
      'ar': 'أي مزاج',
      'fr': 'Toutes les humeurs',
    },
    'q28wosmt': {
      'en': 'Any mood',
      'ar': 'أي مزاج',
      'fr': 'Toutes les humeurs',
    },
    'ytsoiqrn': {
      'en': 'Feel-good',
      'ar': 'مبهج',
      'fr': 'Bonne humeur',
    },
    '38lr6chq': {
      'en': 'Feel-good',
      'ar': 'مبهج',
      'fr': 'Bonne humeur',
    },
    '9udzbdtc': {
      'en': 'Thrilling',
      'ar': 'مشوّق',
      'fr': 'Palpitant',
    },
    '1pv6f7bu': {
      'en': 'Thrilling',
      'ar': 'مشوّق',
      'fr': 'Palpitant',
    },
    'u6pl30m4': {
      'en': 'Mind-bending',
      'ar': 'محيّر للعقل',
      'fr': 'Déroutant',
    },
    'lygrucd3': {
      'en': 'Mind-bending',
      'ar': 'محيّر للعقل',
      'fr': 'Déroutant',
    },
    'nhyvkz21': {
      'en': 'Emotional',
      'ar': 'مؤثر',
      'fr': 'Émouvant',
    },
    'e2lfv51a': {
      'en': 'Emotional',
      'ar': 'مؤثر',
      'fr': 'Émouvant',
    },
    'eccnqmlx': {
      'en': 'Scary',
      'ar': 'مخيف',
      'fr': 'Effrayant',
    },
    'npicaygu': {
      'en': 'Scary',
      'ar': 'مخيف',
      'fr': 'Effrayant',
    },
    'mnz6ukwy': {
      'en': 'Epic',
      'ar': 'ملحمي',
      'fr': 'Épique',
    },
    'y2e4vmsj': {
      'en': 'Epic',
      'ar': 'ملحمي',
      'fr': 'Épique',
    },
    '0vb93hjy': {
      'en': 'Chill',
      'ar': 'هادئ',
      'fr': 'Détente',
    },
    'l87ama15': {
      'en': 'Chill',
      'ar': 'هادئ',
      'fr': 'Détente',
    },
    'w7pa8udd': {
      'en': 'Genres (pick any)',
      'ar': '',
      'fr': '',
    },
    '92p8j53h': {
      'en': 'Action',
      'ar': '',
      'fr': '',
    },
    '5mbvlh1p': {
      'en': 'Action',
      'ar': '',
      'fr': '',
    },
    '8tz08y63': {
      'en': 'Comedy',
      'ar': '',
      'fr': '',
    },
    '04xu7ppt': {
      'en': 'Comedy',
      'ar': '',
      'fr': '',
    },
    'nwub2j8z': {
      'en': 'Drama',
      'ar': '',
      'fr': '',
    },
    'vxkt3gyo': {
      'en': 'Drama',
      'ar': '',
      'fr': '',
    },
    'f7d8tfjd': {
      'en': 'Sci-Fi',
      'ar': '',
      'fr': '',
    },
    'jkf6ggh9': {
      'en': 'Sci-Fi',
      'ar': '',
      'fr': '',
    },
    't21afky5': {
      'en': 'Animation',
      'ar': '',
      'fr': '',
    },
    '1jwx4k46': {
      'en': 'Animation',
      'ar': '',
      'fr': '',
    },
    '64k7ed72': {
      'en': 'Crime',
      'ar': '',
      'fr': '',
    },
    'lfobyg9y': {
      'en': 'Crime',
      'ar': '',
      'fr': '',
    },
    'qvh3i2bc': {
      'en': 'Mystery',
      'ar': '',
      'fr': '',
    },
    'uhembofi': {
      'en': 'Mystery',
      'ar': '',
      'fr': '',
    },
    'u9bp2neo': {
      'en': 'Documentary',
      'ar': '',
      'fr': '',
    },
    'xtje3oap': {
      'en': 'Documentary',
      'ar': '',
      'fr': '',
    },
    '4e041ym7': {
      'en': 'Family',
      'ar': '',
      'fr': '',
    },
    'vu436hf7': {
      'en': 'Family',
      'ar': '',
      'fr': '',
    },
    'z9l0tj2h': {
      'en': 'Fantasy',
      'ar': '',
      'fr': '',
    },
    '292k8do3': {
      'en': 'Fantasy',
      'ar': '',
      'fr': '',
    },
    '01183ojt': {
      'en': 'Horror',
      'ar': '',
      'fr': '',
    },
    'uv75pc0n': {
      'en': 'Horror',
      'ar': '',
      'fr': '',
    },
    '43zb6q5g': {
      'en': 'Romance',
      'ar': '',
      'fr': '',
    },
    'lnqjj59a': {
      'en': 'Romance',
      'ar': '',
      'fr': '',
    },
    'moa3mboo': {
      'en': 'How much time do you have?',
      'ar': '',
      'fr': '',
    },
    'pj3wu32s': {
      'en': 'Any length',
      'ar': '',
      'fr': '',
    },
    '3tqnyge6': {
      'en': 'Any length',
      'ar': '',
      'fr': '',
    },
    'arjjedle': {
      'en': '≤ 90 min',
      'ar': '',
      'fr': '',
    },
    'wha6mt4f': {
      'en': '≤ 90 min',
      'ar': '',
      'fr': '',
    },
    'slklfyoy': {
      'en': '≤ 2 h',
      'ar': '',
      'fr': '',
    },
    'i6oj1k3f': {
      'en': '≤ 2 h',
      'ar': '',
      'fr': '',
    },
    'c0dolpcy': {
      'en': '≤ 2.5 h',
      'ar': '',
      'fr': '',
    },
    '4hqz1lo5': {
      'en': '≤ 2.5 h',
      'ar': '',
      'fr': '',
    },
    'jygqyol0': {
      'en': 'For TV shows this is the episode length (≈45 / 60 / 75 min).',
      'ar': '',
      'fr': '',
    },
    'u3e5prh1': {
      'en': 'Minimum rating',
      'ar': '',
      'fr': '',
    },
    'a45gb0q0': {
      'en': 'Any',
      'ar': '',
      'fr': '',
    },
    'o6z6d489': {
      'en': 'Any',
      'ar': '',
      'fr': '',
    },
    '26kig1cp': {
      'en': '6+ stars',
      'ar': '6+ نجوم',
      'fr': '6+ étoiles',
    },
    'xl40jcau': {
      'en': '6+ stars',
      'ar': '6+ نجوم',
      'fr': '6+ étoiles',
    },
    '1wkni690': {
      'en': '7+ stars',
      'ar': '7+ نجوم',
      'fr': '7+ étoiles',
    },
    'e05e0fvg': {
      'en': '7+ stars',
      'ar': '7+ نجوم',
      'fr': '7+ étoiles',
    },
    'fr2vp2oa': {
      'en': '8+ stars',
      'ar': '8+ نجوم',
      'fr': '8+ étoiles',
    },
    '35q438e5': {
      'en': '8+ stars',
      'ar': '8+ نجوم',
      'fr': '8+ étoiles',
    },
    'tucty8nt': {
      'en': 'Include titles I already saved or reviewed',
      'ar': '',
      'fr': '',
    },
    '9hskf8i1': {
      'en': 'Reset skipped',
      'ar': '',
      'fr': '',
    },
    'xdcl1wrt': {
      'en': 'Get my picks',
      'ar': '',
      'fr': '',
    },
    'azmx50fl': {
      'en': 'Surprise me',
      'ar': 'فاجئني',
      'fr': 'Surprends-moi',
    },
    '9pu4tnjx': {
      'en': 'Adjust',
      'ar': '',
      'fr': '',
    },
    'yj9oyuv9': {
      'en': 'Try again',
      'ar': '',
      'fr': '',
    },
    'fz8oki1g': {
      'en': 'Details',
      'ar': '',
      'fr': '',
    },
    'ttskip01': {
      'en': 'Skip',
      'ar': 'تخطي',
      'fr': 'Passer',
    },
    '85ilzkm4': {
      'en': 'Finding more…',
      'ar': '',
      'fr': '',
    },
    'ih4zaggz': {
      'en': 'More picks',
      'ar': '',
      'fr': '',
    },
    'afex8pjq': {
      'en': 'Watching with friends?',
      'ar': '',
      'fr': '',
    },
    'wpgqn8dd': {
      'en':
          'Start a Movie Match with these picks as the deck. Share the code and swipe together.',
      'ar': '',
      'fr': '',
    },
    'nbg9max7': {
      'en': 'Start a Movie Match with these',
      'ar': '',
      'fr': '',
    },
  },
  // UsernamePage
  {
    'ogc689u3': {
      'en': 'Back',
      'ar': 'رجوع',
      'fr': 'Retour',
    },
    'xy58uzl1': {
      'en':
          'People find you by this name. Use 3 to 20 lowercase letters, numbers, _ or .',
      'ar': '',
      'fr': '',
    },
    'baouufpk': {
      'en': 'Username',
      'ar': '',
      'fr': '',
    },
    'd6o4d5jl': {
      'en': 'for example movie_fan',
      'ar': '',
      'fr': '',
    },
    'nxd16jft': {
      'en': 'Choose a username',
      'ar': 'اختر اسم مستخدم',
      'fr': 'Choisissez un nom d\'utilisateur',
    },
    'kahph3cg': {
      'en': 'At least 3 characters',
      'ar': '3 أحرف على الأقل',
      'fr': 'Au moins 3 caractères',
    },
    'puw6zhhs': {
      'en': 'At most 20 characters',
      'ar': '20 حرفًا كحد أقصى',
      'fr': '20 caractères maximum',
    },
    'dcmdofz5': {
      'en': 'Use lowercase letters, numbers, _ and . only',
      'ar': 'استخدم الأحرف الصغيرة والأرقام و _ و . فقط',
      'fr': 'Utilisez uniquement des minuscules, chiffres, _ et .',
    },
    'f0xnozgm': {
      'en': 'Save username',
      'ar': '',
      'fr': '',
    },
  },
  // AddFriendPage
  {
    'f9yglrz5': {
      'en': 'Add friend',
      'ar': '',
      'fr': '',
    },
    '0rtlke5s': {
      'en': 'Username',
      'ar': '',
      'fr': '',
    },
    '23jua5e1': {
      'en': 'Search by username',
      'ar': '',
      'fr': '',
    },
  },
  // ReviewCard
  {
    '5p5rcal0': {
      'en': 'YOU',
      'ar': 'أنت',
      'fr': 'VOUS',
    },
    'ttmore01': {
      'en': 'More',
      'ar': 'المزيد',
      'fr': 'Plus',
    },
    'mk96sd5r': {
      'en': 'Contains spoilers. Tap to reveal',
      'ar': 'يحتوي على حرق للأحداث. اضغط للعرض',
      'fr': 'Contient des spoilers. Touchez pour afficher',
    },
  },
  // AvatarPickerSheet
  {
    'm529imqg': {
      'en': 'Choose your avatar',
      'ar': 'اختر صورتك الرمزية',
      'fr': 'Choisissez votre avatar',
    },
  },
  // MyQrSheet
  {
    'wkjkihrm': {
      'en': 'My Yello code',
      'ar': '',
      'fr': '',
    },
    'unzeoq5n': {
      'en': 'Friends scan this code in Yello. Open Friends, then Scan QR code.',
      'ar': 'يمسح أصدقاؤك هذا الرمز في Yello. افتح الأصدقاء ثم امسح رمز QR.',
      'fr':
          'Vos amis scannent ce code dans Yello. Ouvrez Amis, puis Scanner un code QR.',
    },
    'zzkha6qj': {
      'en': 'Share invite link',
      'ar': '',
      'fr': '',
    },
  },
  // ReviewActionsSheet
  {
    'hukdc2qx': {
      'en': 'Edit',
      'ar': 'تعديل',
      'fr': 'Modifier',
    },
    'kdapjokk': {
      'en': 'Delete',
      'ar': 'حذف',
      'fr': 'Supprimer',
    },
  },
  // DeleteReviewDialog
  {
    'iwa1ukt4': {
      'en': 'Delete your review?',
      'ar': 'حذف مراجعتك؟',
      'fr': 'Supprimer votre avis ?',
    },
    'byt8b6dk': {
      'en': 'Your rating and review for this title will be removed.',
      'ar': 'سيتم حذف تقييمك ومراجعتك لهذا العنوان.',
      'fr': 'Votre note et votre avis pour ce titre seront supprimés.',
    },
    'wkj7dj2k': {
      'en': 'Cancel',
      'ar': 'إلغاء',
      'fr': 'Annuler',
    },
    'fjsewucd': {
      'en': 'Delete',
      'ar': 'حذف',
      'fr': 'Supprimer',
    },
  },
  // Miscellaneous
  {
    '4zvjpk20': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'zgfaqijk': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'z1s97loq': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'dta4tz50': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'g7bny97l': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'iool717u': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    '4ta6i1js': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'c8j6ruds': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'wx76dder': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'v0onuiv6': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'd4fwb9em': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    '75r0fd55': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'sl1diviz': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    '6d29o5os': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'k1jf2jd4': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    '8vdx0sdb': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'djd1tbmi': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'dtwj79yg': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    '46r3785d': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'nsywt3ey': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'vaimmvz1': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'kyzatd3x': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'cxfil8y0': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'r8so5t7z': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    'tqmz0s5g': {
      'en': '',
      'ar': '',
      'fr': '',
    },
    '7ah87ab5': {
      'en': '',
      'ar': '',
      'fr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
