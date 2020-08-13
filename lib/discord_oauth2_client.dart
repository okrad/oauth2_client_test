import 'package:meta/meta.dart';
import 'package:oauth2_client/oauth2_client.dart';

class DiscordOAuth2Client extends OAuth2Client {
  DiscordOAuth2Client(
      {@required String redirectUri, @required String customUriScheme})
      : super(
            authorizeUrl: 'https://discord.com/api/oauth2/authorize',
            tokenUrl: 'https://discord.com/api/oauth2/token',
            // revo
            redirectUri: redirectUri,
            customUriScheme: customUriScheme) {
    // this.accessTokenRequestHeaders = {'Accept': 'application/json'};
  }
}
