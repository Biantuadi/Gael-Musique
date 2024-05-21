// ignore_for_file: constant_identifier_names

class AppConfig {
   static const String APP_NAME = 'Gael Music';
   static const String APP_VERSION = '1.0';
   static const String API_KEY = "";
   static const String BASE_URL = "https://back-gael.vercel.app/";

   // URL
      /* AUTH */
   static const String loginUrl = "auth/login";
   static const String registerUrl = "/auth/register";

      /* USERS */
   static const String usersUrl = "users";
   static const String userMeUrl = "users/me?userId"; // PASSER SON ID
   static const String userUrl = "users/";
   static const String avatarUpdateUrl = "users/avatar?userID=";
   static const String passwordUpdate = "auth/updatePassword";

      /* GETS */
   static const String albumsUrl = "albums";
   static const String songsUrl = "songs";
   static const String podcastsUrl = "podcasts";
   static const String eventsUrl = "events";
   static const String radiosUrl = "radios";
   static const String userTicketsUrl = "tickets";
   static const String streamingsUrl = "streamings";

   // SHARED PREFERENCES

   static const String appTheme = "THEME";
   static const String isFirstTime = "IS-FIRST-TIME";
   static const String isOffLineMode = "IS-OFFLINE-MODE";

   /* auth */
   static const String sharedToken = "USER-TOKEN";
   static const String sharedUserName = "USER-NAME";
   static const String sharedFirstName = "USER-FIRST-NAME";
   static const String sharedEmail = "USER-EMAIL";
   static const String sharedProfileUrl = "USER-PROFILE-URL";
   static const String sharedPhone = "USER-PHONE";
   static const String sharedUserBio = "USER-BIO";
   static const String sharedUserID= "USER-ID";
   static const String sharedTokenDate= "TOKEN-DATE";
   static const String sharedUserCreatedAt= "USER-CREATED-DATE";

 }
