//
//  GeoManager.m
//  Yml
//
//  Created by ZhuSheng on 18/11/2016.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "GeoManager.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationManager.h>

static AMapLocationManager *_manager = nil;

@implementation GeoManager

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(configure:(NSDictionary *) configuration) {
  [AMapServices sharedServices].apiKey = configuration[@"apiKey"];
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _manager = [[AMapLocationManager alloc] init];
  });
  
  _manager.desiredAccuracy = kCLLocationAccuracyBest;
  _manager.locationTimeout = 10;
  _manager.reGeocodeTimeout = 5;
}

RCT_EXPORT_METHOD(requestLocation:(RCTResponseSenderBlock) callback) {
  [_manager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
    if (error) {
      if (callback)
        callback(@[@{@"message": [error description]}]);
      return;
    }
    
    if (callback) {
      callback(@[
                 [NSNull null],
                 @{
                   @"coordinate":@{
                       @"latitude":@(location.coordinate.latitude),
                       @"longitude":@(location.coordinate.longitude)
                       }
                   }
                 ]
               );
    }
  }];
}

RCT_EXPORT_METHOD(requestLocationWithReGeocode:(RCTResponseSenderBlock) callback) {
  [_manager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
    if (error) {
      if (callback)
        callback(@[@{@"message": [error description]}]);
      return;
    }
    
    if (callback) {
      callback(@[
                 [NSNull null],
                 @{
                   @"coordinate":@{
                       @"latitude":@(location.coordinate.latitude),
                       @"longitude":@(location.coordinate.longitude)
                   }
                  },
                 @{
                   @"formattedAddress": regeocode.formattedAddress ? regeocode.formattedAddress : @"",
                   @"country": regeocode.country ? regeocode.country : @"",
                   @"province": regeocode.province ? regeocode.province : @"",
                   @"city": regeocode.city ? regeocode.city : @"",
                   @"district": regeocode.district ? regeocode.district : @"",
                   @"citycode": regeocode.citycode ? regeocode.citycode : @"",
                   @"adcode": regeocode.adcode ? regeocode.adcode : @"",
                   @"street": regeocode.street ? regeocode.street : @"",
                   @"number": regeocode.number ? regeocode.number : @"",
                   @"POIName": regeocode.POIName ? regeocode.POIName : @"",
                   @"AOIName": regeocode.AOIName ? regeocode.AOIName : @""
                  }
                ]
               );
    }
    
    /*
     @interface AMapLocationReGeocode : NSObject<NSCopying,NSCoding>
     
     @property (nonatomic, copy) NSString *formattedAddress;//!< 格式化地址
     
     @property (nonatomic, copy) NSString *country;  //!< 国家
     @property (nonatomic, copy) NSString *province; //!< 省/直辖市
     @property (nonatomic, copy) NSString *city;     //!< 市
     @property (nonatomic, copy) NSString *district; //!< 区
     @property (nonatomic, copy) NSString *township __attribute((deprecated("该字段从v2.2.0版本起不再返回数据,建议您使用AMapSearchKit的逆地理功能获取."))); //!< 乡镇
     @property (nonatomic, copy) NSString *neighborhood __attribute((deprecated("该字段从v2.2.0版本起不再返回数据,建议您使用AMapSearchKit的逆地理功能获取."))); //!< 社区
     @property (nonatomic, copy) NSString *building __attribute((deprecated("该字段从v2.2.0版本起不再返回数据,建议您使用AMapSearchKit的逆地理功能获取."))); //!< 建筑
     @property (nonatomic, copy) NSString *citycode; //!< 城市编码
     @property (nonatomic, copy) NSString *adcode;   //!< 区域编码
     
     @property (nonatomic, copy) NSString *street;   //!< 街道名称
     @property (nonatomic, copy) NSString *number;   //!< 门牌号
     
     @property (nonatomic, copy) NSString *POIName;  //!< 兴趣点名称
     @property (nonatomic, copy) NSString *AOIName;  //!< 所属兴趣点名称
     
     @end
     */
  }];
}

@end
