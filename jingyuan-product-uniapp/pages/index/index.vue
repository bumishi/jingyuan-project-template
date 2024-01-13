<template>
  <view>
    <s-layout
        title="首页"
        :bgStyle="template.style?.background"
        onShareAppMessage
    >
      <!-- 系统公告 -->
      <uni-notice-bar v-if="showNotice" show-icon="true" single="false" show-close="true"
                      :text="noticeContent"></uni-notice-bar>

      <view>首页</view>
      <!-- 广告模块 -->
      <s-popup-image/>
    </s-layout>
  </view>
</template>

<script setup>
import {computed, ref} from 'vue';
import {onLoad, onPageScroll, onPullDownRefresh} from '@dcloudio/uni-app';
import sheep from '@/sheep';
import $share from '@/sheep/platform/share';

// 隐藏原生tabBar
// uni.hideTabBar();
const notice = ref({})
const showNotice = ref(false)

const noticeContent = computed(() => '【' + notice.value.title + '】' + notice.value.detail)

const template = computed(() => sheep.$store('app').template?.home);

async function getNotice() {
  const {code, data} = await sheep.$api.app.getNotice()
  if (code === 200 && data.length > 0) {
    notice.value = data[0];
    showNotice.value = true;
  }
}

onLoad((options) => {

  getNotice();

  // 进入指定页面(完整页面路径)
  if (options.page) {
    sheep.$router.go(decodeURIComponent(options.page));
  }
});

// 下拉刷新
onPullDownRefresh(() => {

  setTimeout(function () {
    uni.stopPullDownRefresh();
  }, 800);
});


</script>

<style></style>
