<h1 align="center">
HarperDB Hashnode Hackathon
</h1>
<h4 align="center">Create, Update, Read, and Delete all of your post scheduling on Hashnode and Social Media</h4>

This is a Flutter project made for the [Hashnode Hackathon](https://townhall.hashnode.com/announcing-harperdb-hackathon-on-hashnode) in collaboration with [HarperDB](https://harperdb.io/). You can find the full article here [Building a Post Scheduling App with HarperDB & Flutter](https://blog.albertobonacina.com/building-a-post-scheduling-app-with-harperdb-and-flutter).

The app is a Post Schedule app used to manage the release schedule of your blog post on Hashnode, when post them and when share posts on other platforms like Reddit, Twitter, Facebook, etc. The app is build with Flutter 2.2 and it's ready for Android, iOS and Web, the result looks like:

<img src="screens/mockup-phone.png">

## 🔥 Features

- ✔️ Read all the post schedule
- ✔️ Create new post schedule
- ✔️ Update a post schedule
- ✔️ Delete a post schedule

## 🧙‍♂️ Built With

- [Flutter](https://flutter.dev/): Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, desktop, and embedded devices from a single codebase
- [Harper DB](https://harperdb.io/): A flexible Data Store
- [datetime_picker_formfield](https://pub.dev/packages/datetime_picker_formfield): A TextFormField that emits DateTimes and helps show Material, Cupertino, and other style picker dialogs
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv): Easily configure any flutter application with global variables using a `.env` file
- [flutter_styled_toast](https://pub.dev/packages/flutter_styled_toast): A Styled Toast Flutter package. You can highly customize toast ever. Beautify toast with a series of animations and make toast more beautiful
- [google_fonts](https://pub.dev/packages/google_fonts): The `google_fonts` package for Flutter allows you to easily use any of the 977 fonts (and their variants) from [fonts.google.com](https://fonts.google.com/) in your Flutter app
- [http](https://pub.dev/packages/http): A composable, Future-based library for making HTTP requests
- [intl](https://pub.dev/packages/intl): Provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text
- [url_strategy](https://pub.dev/packages/url_strategy): Package for Flutter apps that allows setting the web URL strategy with a single line of code

## 🛠 Configuration

To make the project work you need to create a `.env` file in the project root, that was not added to version control with git, like this:

```
HARPER_DB_SECRET_KEY='your-secret-key'
HARPER_DB_URL='https://your-istance-name.harperdbcloud.com'
```

## 🛡️ License

Distributed under the MIT License. See [LICENSE](https://github.com/polilluminato/harperdb-hashnode-hackathon/blob/main/LICENSE.md) for more information.
