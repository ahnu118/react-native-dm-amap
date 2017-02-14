
import {
  NativeModules,
  Platform
} from 'react-native';

const GeoManager = NativeModules.GeoManager;

export default {
  /**
    使用前初始化
    GeoManager.configure({
      apiKey:'f1cb375456c3390742dc1e615b544f51'    //AMap iOS Key
    });
  */
  configure: Platform.OS == "ios"? GeoManager.configure : null ,

  /**
    请求当前位置
    GeoManager.requestLocationWithReGeocode((err, location) => {
      //handle callback
    });
  */
  requestLocation: Platform.OS == "ios"? GeoManager.requestLocation : null ,

  /**
    请求当前位置, 带逆地址信息
    GeoManager.requestLocationWithReGeocode((err, location, regeocode) => {
      //handle callback
    });
  */
  requestLocationWithReGeocode: Platform.OS == "ios"? GeoManager.requestLocationWithReGeocode : null 
};
