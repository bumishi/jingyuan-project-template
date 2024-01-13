<template>
  <s-layout class="set-wrap" :title="state.title">
    <view class="ss-p-30" style="color:#999"><mp-html class="richtext" :content="state.content"></mp-html></view>
  </s-layout>
</template>

<script setup>
  import { onLoad } from '@dcloudio/uni-app';
  import { reactive } from 'vue';
  import sheep from '@/sheep';

  const state = reactive({
    title: '',
    content: '',
  });

  async function getRichTextContent(id) {
    const { code, data } = await sheep.$api.data.richtext(id);
    if (code === 200) {
      state.content = data;
      if (state.title === '') {
        uni.setNavigationBarTitle({
          title: state.title,
        });
      }
    }
  }
  onLoad((options) => {
    if (options.title) {
      state.title = options.title;
      uni.setNavigationBarTitle({
        title: state.title,
      });
    }
    getRichTextContent(options.id);
  });
</script>

<style lang="scss" scoped>
  .set-title {
    margin: 0 30rpx;
  }

  .richtext {
  }
</style>
