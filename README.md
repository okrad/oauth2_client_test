# oauth2_client_test

An example Flutter application for the [oauth2_client](https://pub.dev/packages/oauth2_client) library.

## Getting Started

Clone the repo, then register your application on the provider you are going to test on.
For the sake of simplicity you can use _mytestapp://oauth2redirect_ as the redirect uri in the application registration form. In this case you won't need to change anything.

If you want to use your own redirect uri instead, you *must* modify the _AndroidManifest.xml_ file changing the _android:scheme_ attribute to the custom scheme of your redirect url. Then you must change the _main.dart_ file, updating the two variables _redirectUri_ and _customUriScheme_ with the corresponding values.

For example, if your redirect url is "my.custom.app://redirect", the _android:scheme_ attribute and the _customUriScheme_ variable will be "my.custom.app", while the _redirectUri_ variable will be "my.custom.app://redirect".

Run the app on an emulator or an actual device.

Select the client type, then fill the TextFields with your application's client id, client secret and required scopes (as a comma separated list).

Finally press the "Authorize" button.
You should be redirected to the server authorization page.

Once you have granted authorization, you should be redirected back to the app and see the generated Access Token in the corresponding field.