<template>
  <view>
    <s-image-block v-if="type === 'imageBlock'" :data="data" :styles="styles" />
    <s-image-banner v-if="type === 'imageBanner'" :data="data" :styles="styles" />
    <s-video-block v-if="type === 'videoPlayer'" :data="data" :styles="styles" />
    <s-image-cube v-if="type === 'imageCube'" :data="data" :styles="styles" />

    <s-notice-block v-if="type === 'noticeBlock'" :data="data" />
    <s-title-block v-if="type === 'titleBlock'" :data="data" :styles="styles" />
    <s-line-block v-if="type === 'lineBlock'" :data="data" />

    <s-menu-button v-if="type === 'menuButton'" :data="data" :styles="styles" />
    <s-menu-list v-if="type === 'menuList'" :data="data" />
    <s-menu-grid v-if="type === 'menuGrid'" :data="data" />

    <s-user-card v-if="type === 'userCard'" />
    <s-order-card v-if="type === 'orderCard'" :data="data" />
    <s-richtext-block v-if="type === 'richtext'" :data="data" :styles="styles"></s-richtext-block>

  </view>
</template>

<script setup>
  /**
   * 装修组件 - 组件集
   */
  const props = defineProps({
    type: {
      type: String,
      default: '',
    },
    data: {
      type: Object,
      default() {},
    },
    styles: {
      type: Object,
      default() {},
    },
  });
  function onSearch() {}
</script>

<style></style>
