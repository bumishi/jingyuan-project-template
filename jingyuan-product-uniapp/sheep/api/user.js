import request from '@/sheep/request';
import $platform from '@/sheep/platform';

export default {
  profile: () =>
    request({
      url: '/usercenter/profile',
      method: 'GET',
      custom: {
        showLoading: false,
        auth: true,
      },
    }),
  update: (data) =>
    request({
      url: '/usercenter/update/info',
      method: 'POST',
      custom: {
        showSuccess: true,
        auth: true,
      },
      data,
    }),
  // 账号登录
  accountLogin: (data) =>
    request({
      url: '/auth/login',
      method: 'POST',
      data,
      custom: {
        showSuccess: true,
        loadingMsg: '登录中',
      },
    }),
  // 短信登录
  smsLogin: (data) =>
    request({
      url: '/auth/login',
      method: 'POST',
      data,
      custom: {
        showSuccess: true,
        loadingMsg: '登录中',
      },
    }),
  // 短信注册
  smsRegister: (data) =>
    request({
      url: '/auth/register',
      method: 'POST',
      data,
      custom: {
        showSuccess: true,
        loadingMsg: '正在注册',
      },
    }),
  // 重置密码
  resetPassword: (data) =>
    request({
      url: '/usercenter/reset/password',
      method: 'POST',
      data,
      custom: {
        showSuccess: true,
        loadingMsg: '验证中',
      },
    }),

  // 修改密码
  changePassword: (data) =>
    request({
      url: '/usercenter/reset/password',
      method: 'POST',
      data,
      custom: {
        showSuccess: true,
        loadingMsg: '验证中',
      },
    }),

  // 绑定、更换手机号
  changeMobile: (data) =>
    request({
      url: '/usercenter/update/mobile',
      method: 'POST',
      data,
      custom: {
        showSuccess: true,
        loadingMsg: '验证中',
      },
    }),

  // 修改用户名
  changeUsername: (data) =>
    request({
      url: '/user/api/user/changeUsername',
      method: 'POST',
      data,
      custom: {
        showSuccess: true,
        loadingMsg: '验证中',
      },
    }),

  // 更新小程序信息
  updateMpUserInfo: (data) =>
    request({
      url: '/user/api/user/updateMpUserInfo',
      method: 'POST',
      data,
    }),

  // 第三方授权信息
  thirdOauthInfo: () =>
    request({
      url: '/user/api/user/thirdOauth',
      method: 'GET',
      params: {
        provider: $platform.provider,
        platform: $platform.platform,
      },
      custom: {
        showLoading: false,
      },
    }),

  // 添加分享记录
  addShareLog: (data) =>
    request({
      url: 'share/add',
      method: 'POST',
      data,
      custom: {
        showError: false,
      },
    }),
  share: {
    list: (params) =>
      request({
        url: 'share/list',
        method: 'GET',
        params,
      }),
  },
  // 账号登出
  logout: (data) =>
    request({
      url: '/usercenter/logout',
      method: 'POST',
      data,
    }),
  // 账号注销
  logoff: (data) =>
    request({
      url: '/usercenter/logoff',
      method: 'POST',
      data,
    }),
  account: {
    info: (params) =>
      request({
        url: 'user/account',
        method: 'GET',
        params,
        custom: {
          showError: false,
          auth: true,
        },
      }),
    save: (data) =>
      request({
        url: 'user/account',
        method: 'POST',
        data,
        custom: {
          showSuccess: true,
          auth: true,
        },
      }),
  },
  //数量接口
  data: () =>
    request({
      url: 'user/user/data',
      method: 'GET',
      custom: {
        showLoading: false,
        auth: true,
      },
    }),
};
