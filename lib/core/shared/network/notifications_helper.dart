import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class NotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "chat-c2e7f",
      "private_key_id": "f03a1922a64ab97abad2dafc0d5c234fda0c5f8b",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDc/9vGpGp4t9Lc\nOJ053kN3XAqFJHuOD5O2LBvNmaULgF6fPs+1Lyz9x9uREqh4Spcm7Vy41CwWSoii\nIzLWjuVFpIdyP/mMb9QzIXtigxbaRNVzS429+334sDGO1XfCuCmm7Ewxkkrn3hcg\nu2LuSAFjZDcdKjHoCULkXssK1IsP+CDBMjxsSJAXsGNM6RGgF9v98RMryfNAmQmc\nvNhrThp8qRh7Kxa/pUp3uxy8uEulW8t5S8FZO/xeWEYE45KS7rVFr3iErFNeqrYN\nJLjLHav7ApHP6bkvXbL0FIqIqaxmV27/Hv5tOOne3MXihngHzqOwAsSZ9LN07JUu\nSqLqS/svAgMBAAECggEAMdHkA5XRAsG94TNKDl+Sqfevz2/4AoB0dh7fbavzTvJz\nYkbQoDGwXM2PK9ce728xP+9Gdcwu3B+VSafRsBiqitaaSiEt6oDTP2uO2xheMHpP\n/BvOKkPllAh0Q5TP2K+XhC/ExXALPtYMNK7JkJne5j8TRZnbgkmEMONFtn1PlBua\nO1JgSl8XAbwJEgXGMKlg2dKUkBOu3IG5Y8vl1SxuqwljU+UvVbK6zJoBCiwpDzOU\n20TX7yAxj/jNwELdJ3VugAmFgIxGAeJRiGsFiJ19zd2XX2P6pK99Ds6O82J2tyL5\nos+MC0Kl88dDHZqw2aNXrekvwOL0gJ33aZ7HqhoREQKBgQD5JFn3dnYJNECyaiUw\nPW3tCX3Vx5iA6q5GdLUKo/RUF+lHHPFPtsJhrPYTzWCEGfvSJOhoc+XJrASi6Utv\nnkoi7u+1RMioGmcnt7XWOvyTiBnazNjxZ4JnDaw9862Otz4E0k3rWjfrp9tgPYO+\np/6TPgTaZuvqpXnEL5ATmK2HWwKBgQDjFTFXNfIb26fIwy3sJ9xmdfevtVodq0Np\nryoegeWCM2Yfh1F15BTFG8e+hs0aADjYzt2gJeXMZAic4tFlxAu1AOg2r42cHpZ2\nRSKtr17p4g9D1bZ3twvjTf/RLMBVYduKlOa4KK+rlrzMYg9C82g2ruazlMAfWjxN\nhPIxu9e3vQKBgQCHoqm0FnL2WdMrDqyGUbspw/QU0aAN9zW/t8PkMhRPP+FJTNF3\nA1lZ0c76QuJbqMW2x08bppUgMR0pD/d4oeVclVY9CmBvXEhykApXwi9Fpl/lBYbK\nDf8pWYE/DQ2c19fUyiWPjsNI8U52W6cAwfbPdIEx4bxoN4ROMVKvyHwYZwKBgCU8\n5XFytDgjRhljAFXYl4jp0Wsr5xI0coKTKeoEzRkTyqxi6VXWyB0mmBPDUUDxRmEv\nUyKe9FcXFF59x27TvkO5WVsWYLd4QJ42aiBnQL5DxtMN6bUp/DYTJV8s4oFd4b2Q\n+2C5s00FFALEFdKZzb4h4k0SmIrLplXj9j93mUFVAoGAM1tmpgDBcInSqwSsmeen\nOwgpfmSxE9VHbSHa4qpZUXxSXyV8vDHiLxaSyB67R1NikiAtzm24unCLBRbowNBe\nlAQlmD3krBCDZgAFKQsvgf8VCO2Jg+ZvxfbaMuBFsm0aJJnow5ErcaegsLl6PZr6\nF9TQ/LbuAxyYR6U1YIzq/Bw=\n-----END PRIVATE KEY-----\n",
      "client_email": "testing@chat-c2e7f.iam.gserviceaccount.com",
      "client_id": "118368256859113456276",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/testing%40chat-c2e7f.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    }

    ;
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);
    client.close();
    print("credentials.accessToken.data : done");

    print(credentials.accessToken.data);
    return credentials.accessToken.data;
  }

  static Future<void> sendNotification({required String deviceToken, required String title, required String body}) async {
    final String accessToken = await getAccessToken();
    String endpointFCM =
        'https://fcm.googleapis.com/v1/projects/chat-c2e7f/messages:send';
    final Map<String, dynamic> message = {
      "message": {
        "token": deviceToken,
        "notification": {"title": title, "body": body},
        "data": {
          "route": "serviceScreen",
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFCM),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print("credentials.accessToken.data : done");
      print('Notification sent successfully');
    } else {
      print('Failed to send notification');
    }
  }
}
