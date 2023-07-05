// const SERVER_API_URL = 'http://192.168.0.107:3010/mock/11/'; // 本地开发api地址
const SERVER_API_URL = 'http://thermal.luci.ai:15070/api/'; // 测试地址
// const SERVER_API_URL = 'http://thermal.luci.ai:19003/api/'; // 测试地址
const SERVER_Update_URL = 'http://thermal.luci.ai:15080/app-version';
// 'http://178.128.226.70:19000/version.json';

// const SERVER_Notify_URL = 'http://192.168.0.12:3000/user/register';
const SERVER_Notify_URL = 'http://178.128.226.70:20000/';
const SERVER_Appstore_URL = 'https://apps.apple.com/us/app/id1529895602';
const SERVER_Googleplay_URL =
    'https://play.google.com/store/apps/details?id=com.ioticiti.luci_thermal_personal_app';

///**  缓存 **/
// 是否启用缓存
const CACHE_ENABLE = false;

// 缓存的最长时间，单位（秒）
const CACHE_MAXAGE = 1000;

// 最大缓存数
const CACHE_MAXCOUNT = 100;
