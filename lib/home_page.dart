import 'package:flutter/material.dart';
import 'news_list_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 450,
              height: 50,
              child: ClipRRect(
                child: Image.network(
                  'https://static.republika.co.id/files/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 150),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsListPage(kategori: 'terbaru'),
                              ),
                            );
                          },
                          child: Text('TERBARU'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsListPage(kategori: 'daerah'),
                              ),
                            );
                          },
                          child: Text('DAERAH'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsListPage(kategori: 'internasional'),
                              ),
                            );
                          },
                          child: Text('INTERNASIONAL'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsListPage(kategori: 'islam'),
                              ),
                            );
                          },
                          child: Text('ISLAM'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
