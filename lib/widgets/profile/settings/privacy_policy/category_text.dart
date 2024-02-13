import 'package:flutter/material.dart';

// Define a new widget for displaying category text
class CategoryTextWidget extends StatelessWidget {
  final String category;

  const CategoryTextWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String categoryText = _getTextForCategory(category);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
      child: Text(
              categoryText,
              style: TextStyle(
              color: Colors.grey.shade50,
              fontSize: 15.0,)),
    );
  }

  String _getTextForCategory(String category) {
    switch (category) {
      case 'Privacy Policy':
        return
          'This Privacy Policy describes Our policies and procedures '
          'on the collection, use and disclosure of Your information '
          'when You use the Service and tells You about Your privacy rights '
          'and how the law protects You.\n\n'
          'We use Your Personal data to provide and improve the Service. '
          'By using the Service, You agree to the collection and use of information '
          'in accordance with this Privacy Policy.';

      case 'Definitions':
        return '''
For the purposes of this Privacy Policy:

- Account means a unique account created for You to access our Service or parts of our Service.

- Application refers to MenuCraft, the software program provided by the Company.

- Company (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to MenuCraft.

- Country refers to: Macedonia

- Device means any device that can access the Service such as a computer, a cellphone or a digital tablet.

- Personal Data is any information that relates to an identified or identifiable individual.

- Service refers to the Application.

- Service Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.

- Third-party Social Media Service refers to any website or any social network website through which a User can log in or create an account to use the Service.

- Usage Data refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).

- You means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.''';

      case 'Personal Data':
        return '''
While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:

  - Email address

  - First name and last name

  - Address

  - Usage Data''';

      case 'Usage Data':
        return
          'Usage Data is collected automatically when using the Service.\n\n'
          'When You access the Service by or through a mobile device, '
          'We may collect certain information automatically, including, '
          'but not limited to, the type of mobile device You use, Your mobile device '
          'unique ID, the IP address of Your mobile device, Your mobile operating system, '
          'unique device identifiers and other diagnostic data';

      case 'Information from Third-Party Social Media Services':
        return '''
The Company allows You to create an account and log in to use the Service through the following Third-party Social Media Services:

  - Google
  - Facebook
  - Instagram
  - Twitter
  - LinkedIn
  
If You decide to register through or otherwise grant us access to a Third-Party Social Media Service, We may collect Personal data that is already associated with Your Third-Party Social Media Service's account, such as Your name, Your email address, Your activities or Your contact list associated with that account.

You may also have the option of sharing additional information with the Company through Your Third-Party Social Media Service's account. If You choose to provide such information and Personal Data, during registration or otherwise, You are giving the Company permission to use, share, and store it in a manner consistent with this Privacy Policy.''';

      case 'Information Collected while Using the Application':
        return '''
While using Our Application, in order to provide features of Our Application, We may collect, with Your prior permission:

Information regarding your location

Pictures and other information from your Device's camera and photo library

We use this information to provide features of Our Service, to improve and customize Our Service. The information may be uploaded to the Company's servers and/or a Service Provider's server or it may be simply stored on Your device.

You can enable or disable access to this information at any time, through Your Device settings.''';

      case 'Use of Your Personal Data':
        return '''
The Company may use Personal Data for the following purposes:

  - To provide and maintain our Service, including to monitor the usage of our Service.

  - To manage Your Account: to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.

  - For the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.

  - To contact You: To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application's push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.

  - To provide You with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.

  - To manage Your requests: To attend and manage Your requests to Us.

  - For business transfers: We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.

  - For other purposes: We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.''';

      case 'Retention of Your Personal Data':
        return '''
The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.

The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.''';

      case 'Delete Your Personal Data':
        return '''
You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You.

Our Service may give You the ability to delete certain information about You from within the Service.

You may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any personal information that You have provided to Us.

Please note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so.''';

      case 'Security of Your Personal Data':
        return '''
The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.''';

      case 'Changes to this Privacy Policy':
        return '''
We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.

We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.

You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.''';

      case 'About Us':
        return
          '''
MenuCraft is a revolutionary app designed to simplify the process of creating and saving menus. Our user-friendly platform allows individuals and businesses to effortlessly craft menus for various occasions, from everyday meals to special events. With MenuCraft, you can explore a vast array of recipes, customize menus to suit your preferences, and save them for future reference. We believe that everyone should have access to a convenient tool that enhances their culinary experience.''';

      case 'Core values':
        return
          '''
1. Simplicity: We believe in creating a user-friendly platform that simplifies the menu planning process, ensuring that anyone can use MenuCraft with ease.

2. Creativity: We encourage our users to unleash their culinary creativity by offering a wide range of recipes and customization options.

3. Convenience: We value convenience and aim to provide a seamless experience for our users, allowing them to save time and effort in menu planning.

4. Inspiration: We strive to inspire our users with exciting and innovative menu ideas, helping them discover new flavors and cuisines.

5. Community: We foster a sense of community among our users, encouraging them to share their menu creations, exchange ideas, and support each other's culinary journeys.''';

      case 'Contact':
        return
          '''
If you have any questions or feedback, You can contact us:

  - By email: info@menucraft.com''';

      default:
        return '';
    }
  }
}