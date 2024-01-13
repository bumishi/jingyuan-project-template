<template>
  <view class="ss-flex ss-col-center notice-wrap">
<!--    <image class="icon-img" :src="sheep.$url.cdn(data.src)" mode="heightFix"></image>-->
    <su-notice-bar
      style="flex: 1"
      :showIcon="true"
      scrollable
      single
      :text="data.title"
      :speed="50"
      color="red"
      @tap="sheep.$router.go(data.url)"
    ></su-notice-bar>
  </view>
</template>

<script setup>
  /**
   * 装修组件  - 通知栏
   *
   */
  import sheep from '@/sheep';
  const props = defineProps({
    data: {
      type: Object,
      default() {},
    },
  });
</script>

<style lang="scss" scoped>
  .notice-wrap {
    .icon-img {
      height: 60rpx;
    }
  }
</style>
