<template>
  <!-- 规格弹窗 -->
  <su-popup :show="authType !== ''" round="10" :showClose="true" @close="closeAuthModal">
    <view class="login-wrap">
      <!-- 1. 账号密码登录 accountLogin -->
      <account-login
          v-if="authType === 'accountLogin'"
          :agreeStatus="state.protocol"
          @onConfirm="onConfirm"
      />

      <!-- 2.短信登录  smsLogin -->
      <sms-login v-if="authType === 'smsLogin'" :agreeStatus="state.protocol" @onConfirm="onConfirm"/>

      <!-- 3.短信注册 smsRegister-->
      <sms-register
          v-if="authType === 'smsRegister'"
          :agreeStatus="state.protocol"
          @onConfirm="onConfirm"
      />


      <!-- 5.绑定手机号 changeMobile -->
      <change-mobile v-if="authType === 'changeMobile'"/>

      <!-- 6.修改密码 changePassword-->
      <change-passwrod v-if="authType === 'changePassword'"/>

      <!-- 8.微信小程序授权 changeUsername-->
      <mp-authorization v-if="authType === 'mpAuthorization'"/>

      <!-- 第三方登录+注册 -->
      <view
          v-if="['accountLogin', 'smsLogin'].includes(authType)"
          class="auto-login-box ss-flex ss-flex-col ss-row-center ss-col-center"
      >
        <!-- 立即注册&快捷登录 TextButton -->
        <view v-if="sheep.$platform.name === 'WechatMiniProgram'" class="ss-flex register-box">
          <view class="register-title">还没有账号?</view>
          <button class="ss-reset-button register-btn" @tap="showAuthModal('smsRegister')"
          >立即注册
          </button
          >
          <view class="or-title">或</view>
          <button class="ss-reset-button login-btn" @tap="thirdLogin('wechat')">快捷登录</button>
          <view class="circle"></view>
        </view>

        <view v-if="sheep.$platform.name !== 'WechatMiniProgram'" class="ss-flex register-box">
          <view class="register-title">还没有账号?</view>
          <button class="ss-reset-button register-btn" @tap="showAuthModal('smsRegister')"
          >立即注册
          </button>
        </view>

        <!-- 公众号|App微信登录 -->
        <button
            v-if="
            ['WechatOfficialAccount', 'App'].includes(sheep.$platform.name) &&
            sheep.$platform.isWechatInstalled
          "
            @tap="thirdLogin('wechat')"
            class="ss-reset-button auto-login-btn"
        >
          <image
              class="auto-login-img"
              :src="sheep.$url.static('/static/img/shop/platform/wechat.png')"
          ></image>
        </button>

        <!-- iOS登录 -->
        <button
            v-if="sheep.$platform.os === 'ios' && sheep.$platform.name === 'App'"
            @tap="thirdLogin('apple')"
            class="ss-reset-button auto-login-btn"
        >
          <image
              class="auto-login-img"
              :src="sheep.$url.static('/static/img/shop/platform/apple.png')"
          ></image>
        </button>
      </view>

      <view
          v-if="['accountLogin', 'smsLogin', 'smsRegister'].includes(authType)"
          class="agreement-box ss-flex ss-row-center"
          :class="{ shake: currentProtocol }"
      >
        <label class="radio ss-flex ss-col-center" @tap="onChange">
          <radio
              :checked="state.protocol"
              color="var(--ui-BG-Main)"
              style="transform: scale(0.8)"
              @tap.stop="onChange"
          />
          <view class="agreement-text ss-flex ss-col-center ss-m-l-8">
            我已阅读并遵守
            <view
                class="tcp-text"
                @tap.stop="onProtocol(5, '用户协议')"
            >
              《用户协议》
            </view>
            <view class="agreement-text">与</view>
            <view
                class="tcp-text"
                @tap.stop="onProtocol(4, '隐私政策')"
            >
              《隐私政策》
            </view>
          </view>
        </label>
      </view>
      <view class="safe-box"></view>
    </view>
  </su-popup>
</template>

<script setup>
import {computed, reactive, ref} from 'vue';
import sheep from '@/sheep';
import accountLogin from './components/account-login.vue';
import smsLogin from './components/sms-login.vue';
import smsRegister from './components/sms-register.vue';
import changeMobile from './components/change-mobile.vue';
import changePasswrod from './components/change-password.vue';
import mpAuthorization from './components/mp-authorization.vue';
import {closeAuthModal, showAuthModal} from '@/sheep/hooks/useModal';
import $store from "@/sheep/store";

const appInfo = computed(() => sheep.$store('app').info);

const modalStore = sheep.$store('modal');
// 授权弹窗类型
const authType = computed(() => modalStore.auth);

const state = reactive({
  protocol: false,
});

const currentProtocol = ref(false);

//勾选协议
function onChange() {
  state.protocol = !state.protocol;
}

// 查看协议
function onProtocol(id, title) {
  closeAuthModal();
  sheep.$router.go('/pages/public/richtext', {
    id,
    title,
  });
}

// 点击登录/注册事件
function onConfirm(e) {
  currentProtocol.value = e;
  setTimeout(() => {
    currentProtocol.value = false;
  }, 1000);
}

// 第三方授权登陆
const thirdLogin = async (provider) => {
  if (!state.protocol) {
    currentProtocol.value = true;
    setTimeout(() => {
      currentProtocol.value = false;
    }, 1000);
    sheep.$helper.toast('请勾选同意');
    return;
  }
  const loginRes = await sheep.$platform.useProvider(provider).login();
  if (loginRes.code === 200) {
    $store('user').setToken(loginRes.data.token_type + ' ' + loginRes.data.access_token);
    closeAuthModal();
    //const userInfo = await sheep.$store('user').getInfo();
    // 触发小程序授权信息弹框
    // #ifdef MP-WEIXIN
    // if (userInfo.third_oauth.length > 0) {
    //   const mpThirdOauthInfo = userInfo.third_oauth.find(
    //       (item) => item.platform === 'miniProgram',
    //   );
    //   if (mpThirdOauthInfo && !mpThirdOauthInfo.nickname) {
    //     showAuthModal('mpAuthorization');
    //   }
    // }
    // #endif
  }
};
</script>

<style lang="scss" scoped>
@import './index.scss';

.shake {
  animation: shake 0.05s linear 4 alternate;
}

@keyframes shake {
  from {
    transform: translateX(-10rpx);
  }
  to {
    transform: translateX(10 rpx);
  }
}

.register-box {
  position: relative;
  justify-content: center;

  .register-btn {
    color: #999999;
    font-size: 30 rpx;
    font-weight: 500;
  }

  .register-title {
    color: #999999;
    font-size: 30 rpx;
    font-weight: 400;
    margin-right: 24 rpx;
  }

  .or-title {
    margin: 0 16 rpx;
    color: #999999;
    font-size: 30 rpx;
    font-weight: 400;
  }

  .login-btn {
    color: var(--ui-BG-Main);
    font-size: 30 rpx;
    font-weight: 500;
  }

  .circle {
    position: absolute;
    right: 0 rpx;
    top: 18 rpx;
    width: 8 rpx;
    height: 8 rpx;
    border-radius: 8 rpx;
    background: var(--ui-BG-Main);
  }
}

.safe-box {
  height: calc(constant(safe-area-inset-bottom) / 5 * 3);
  height: calc(env(safe-area-inset-bottom) / 5 * 3);
}

.tcp-text {
  color: var(--ui-BG-Main);
}

.agreement-text {
  color: $dark-9;
}
</style>
