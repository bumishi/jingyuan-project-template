<template>
  <view
      class="page-app"
      :class="['theme-' + sys.mode, 'main-' + sys.theme, 'font-' + sys.fontSize]"
  >
    <view class="page-main">

      <view class="page-body" :style="[bgStyle]">
        <!-- 沉浸式头部bar -->
        <!--        <su-inner-navbar  :title="title" />-->
        <!-- 页面内容插槽 -->
        <slot/>

        <!-- 悬浮按钮 -->
        <s-float-menu v-if="showFloatButton"></s-float-menu>

        <!-- 底部导航 -->
<!--        <s-tabbar v-if="tabbar !== ''" :path="tabbar"/>-->
      </view>
    </view>

    <view class="page-modal">
      <!-- 全局授权弹窗 -->
      <s-auth-modal/>
      <!-- 全局分享弹窗 -->
      <!--      <s-share-modal :shareInfo="shareInfo" />-->
      <!-- 全局快捷入口 -->
      <s-menu-tools/>
    </view>
  </view>
</template>

<script setup>
/**
 * 模板组件 - 提供页面公共组件，属性，方法
 */
import {computed, reactive, ref} from 'vue';
import sheep from '@/sheep';
import {isEmpty} from 'lodash';
import {onShow} from '@dcloudio/uni-app';
// #ifdef MP-WEIXIN
import {onShareAppMessage} from '@dcloudio/uni-app';
// #endif

const props = defineProps({
  title: {
    type: String,
    default: '',
  },

  color: {
    type: String,
    default: '',
  },

  bgStyle: {
    type: Object,
    default: () => ({
      src: '',
      color: 'var(--ui-BG-1)',
    }),
  },
  tabbar: {
    type: [String, Boolean],
    default: '',
  },
  onShareAppMessage: {
    type: [Boolean, Object],
    default: true,
  },

  //展示悬浮按钮
  showFloatButton: {
    type: Boolean,
    default: false,
  }
});

const sysStore = sheep.$store('sys');
const userStore = sheep.$store('user');
const appStore = sheep.$store('app');
const modalStore = sheep.$store('modal');
const sys = computed(() => sysStore);


// 分享信息
const shareInfo = computed(() => {
  if (props.onShareAppMessage === true) {
    return sheep.$platform.share.getShareInfo();
  } else {
    if (!isEmpty(props.onShareAppMessage)) {
      sheep.$platform.share.updateShareInfo(props.onShareAppMessage);
      return props.onShareAppMessage;
    }
  }
  return {};
});

// #ifdef MP-WEIXIN
// 微信小程序分享
onShareAppMessage(() => {
  return {
    title: shareInfo.value.title,
    path: shareInfo.value.path,
    imageUrl: shareInfo.value.image,
  };
});
// #endif

onShow(() => {
  if (!isEmpty(shareInfo.value)) {
    sheep.$platform.share.updateShareInfo(shareInfo.value);
  }
});
</script>

<style lang="scss" scoped>
.page-app {
  //position: relative;
  color: var(--ui-TC);
  background-color: var(--ui-BG-1) !important;
  z-index: 2;
  display: flex;
  width: 100%;
  height: 100vh;

  .page-main {
    position: absolute;
    z-index: 1;
    width: 100%;
    min-height: 100%;
    display: flex;
    flex-direction: column;

    .page-body {
      width: 100%;
      position: relative;
      z-index: 1;
      flex: 1;
    }

    .page-img {
      width: 100vw;
      height: 100vh;
      position: absolute;
      top: 0;
      left: 0;
      z-index: 0;
    }
  }
}
</style>
