import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('tests, hopefully do something', (){
    FlutterDriver driver;

    setUpAll(() async{
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async{
      if(driver != null){
        driver.close();
      }
    });

    test('the user logs in', () async{
      expect(await driver.getText(_email), "");
    });

  });
}