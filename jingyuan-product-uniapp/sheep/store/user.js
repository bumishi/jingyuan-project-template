import { defineStore } from 'pinia';
import userApi from '@/sheep/api/user';
import $share from '@/sheep/platform/share';
import { isEmpty, cloneDeep, clone } from 'lodash';
import app from './app';
import { showAuthModal } from '@/sheep/hooks/useModal';

// 默认用户信息
const defaultUserInfo = {
  avatar: '', // 头像
  nickname: '', // 昵称
  gender: 0, // 性别
  mobile: '', // 手机号
  verification: {}, // 认证字段
};


const user = defineStore({
  id: 'user',
  state: () => ({
    userInfo: clone(defaultUserInfo), // 用户信息
    isLogin: !!uni.getStorageSync('token'), // 登录状态
    lastUpdateTime: 0, // 上次更新时间
  }),

  actions: {
    // 获取个人信息
    async getInfo() {
      const { code, data } = await userApi.profile();
      if (code !== 200) return;
      this.userInfo = data;

      return Promise.resolve(data);
    },


    // 添加分享记录
    async addShareLog(params) {
      const { error } = await userApi.addShareLog(params);
      if (error === 0) uni.removeStorageSync('shareLog');
    },

    // 设置token
    setToken(token = '') {
      if (token === '') {
        this.isLogin = false;
        uni.removeStorageSync('token');
      } else {
        this.isLogin = true;
        uni.setStorageSync('token', token);
        this.loginAfter();
      }
      return this.isLogin;
    },

    // 更新用户相关信息 (手动限流 5秒之内不刷新)
    async updateUserData() {
      if (!this.isLogin) {
        this.resetUserData();
        return;
      }
      const nowTime = new Date().getTime();
      if (this.lastUpdateTime + 5000 > nowTime) return;
      await this.getInfo();
      this.lastUpdateTime = nowTime;
      return this.userInfo;
    },

    // 重置用户默认数据
    resetUserData() {
      this.setToken();
      this.userInfo = clone(defaultUserInfo);
    },

    // 登录后
    async loginAfter() {
      await this.updateUserData();
      // 登录后设置全局分享参数
      $share.getShareInfo();
      // 提醒绑定手机号
      if (app().platform.bind_mobile && !this.userInfo.verification?.mobile) {
        showAuthModal('changeMobile');
      }

      // 添加分享记录
      const shareLog = uni.getStorageSync('shareLog');
      if (!isEmpty(shareLog)) {
        this.addShareLog({
          ...shareLog,
        });
      }
    },

    // 登出
    async logout(force = false) {
      if (!force) {
          this.resetUserData();
      }
      if (force) {
        this.resetUserData();
      }

      return !this.isLogin;
    },
  },
  persist: {
    enabled: true,
    strategies: [
      {
        key: 'user-store',
      },
    ],
  },
});

export default user;
