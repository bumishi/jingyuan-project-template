<!-- 页面 -->
<template>
  <view class="ss-user-info-wrap ss-p-t-50">
    <view class="ss-flex ss-col-center ss-row-between ss-m-b-20">
      <view class="left-box ss-flex ss-col-center ss-m-l-50">
        <view class="avatar-box ss-m-r-50">
          <image
              class="avatar-img"
              :src="avatarUrl"
              mode="aspectFill"
              @tap="sheep.$router.go('/pages/user/info')"
          ></image>
        </view>
        <view @tap="sheep.$router.go('/pages/user/info')">
          <view class="nickname-box ss-flex ss-col-center">
            <view class="nick-name ss-m-r-20">{{ userInfo?.nickname || nickname }}</view>
          </view>
        </view>
      </view>
      <view class="right-box ss-m-r-52">
        <button class="ss-reset-button" @tap="sheep.$router.go('/pages/user/info')">
          <text class="sicon-qrcode"></text>
        </button>
      </view>
    </view>

    <view
        class="bind-mobile-box ss-flex ss-row-between ss-col-center"
        v-if="isLogin && !userInfo.telephone"
    >
      <view class="ss-flex">
        <text class="cicon-mobile-o"></text>
        <view class="mobile-title ss-m-l-20"> 点击绑定手机号确保账户安全</view>
      </view>
      <button class="ss-reset-button bind-btn" @tap="onBind">去绑定</button>
    </view>
  </view>
</template>

<script setup>
/**
 * 用户卡片
 *
 * @property {Number} leftSpace                  - 容器左间距
 * @property {Number} rightSpace                  - 容器右间距
 *
 * @property {String} avatar          - 头像
 * @property {String} nickname          - 昵称
 * @property {String} vip              - 等级
 * @property {String} collectNum        - 收藏数
 * @property {String} likeNum          - 点赞数
 *
 *
 */
import {computed, reactive} from 'vue';
import sheep from '@/sheep';
import {showShareModal, showAuthModal} from '@/sheep/hooks/useModal';
import {staticUrl} from "@/sheep/config";

// 用户信息
const userInfo = computed(() => sheep.$store('user').userInfo);

// 是否登录
const isLogin = computed(() => sheep.$store('user')?.isLogin);

//头像地址
const avatarUrl = computed(() => {
  let avatar = '/static/default_avatar.png';
  let user = sheep.$store('user');
  let logined = user?.isLogin;
  if (logined && user.userInfo.avatar) {
    avatar = staticUrl + user.userInfo.avatar;
  }
  //console.log(avatar)
  return avatar;
});

//const avatarUrl = computed(() =>(isLogin&&userInfo.avatar)?(staticUrl + userInfo.avatar):'/static/default_avatar.png');

// 接收参数
const props = defineProps({
  background: {
    type: String,
    default: '',
  },
  // 头像
  avatar: {
    type: String,
    default: '',
  },
  nickname: {
    type: String,
    default: '请先登录',
  },
  vip: {
    type: [String, Number],
    default: '1',
  },
  collectNum: {
    type: [String, Number],
    default: '1',
  },
  likeNum: {
    type: [String, Number],
    default: '1',
  },
});

function onBind() {
  showAuthModal('changeMobile');
}
</script>

<style lang="scss" scoped>
.ss-user-info-wrap {
  box-sizing: border-box;

  .avatar-box {
    width: 100rpx;
    height: 100rpx;
    border-radius: 50%;
    overflow: hidden;

    .avatar-img {
      width: 100%;
      height: 100%;
    }
  }

  .nick-name {
    font-size: 34 rpx;
    font-weight: 400;
    color: #333333;
    line-height: normal;
  }

  .vip-img {
    width: 30 rpx;
    height: 30 rpx;
  }

  .sicon-qrcode {
    font-size: 40 rpx;
  }
}

.bind-mobile-box {
  width: 100%;
  height: 84 rpx;
  padding: 0 34 rpx 0 44 rpx;
  box-sizing: border-box;
  background: #ffffff;
  box-shadow: 0px -8rpx 9 rpx 0px rgba(#e0e0e0, 0.3);

  .cicon-mobile-o {
    font-size: 30 rpx;
    color: #ff690d;
  }

  .mobile-title {
    font-size: 24 rpx;
    font-weight: 500;
    color: #ff690d;
  }

  .bind-btn {
    width: 100 rpx;
    height: 50 rpx;
    background: #ff6100;
    border-radius: 25 rpx;
    font-size: 24 rpx;
    font-weight: 500;
    color: #ffffff;
  }
}
</style>
