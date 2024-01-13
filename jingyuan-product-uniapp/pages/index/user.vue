<template>
  <s-layout
    title="我的"
    tabbar="/pages/index/user"
    navbar="custom"
    :bgStyle="template.style?.background"
    :navbarStyle="template.style?.navbar"
    onShareAppMessage
    :showFloatButton="true"
  >
    <s-block v-for="(item, index) in template.data" :key="index" :styles="item.style">
      <s-block-item :type="item.type" :data="item.data" :styles="item.style" />
    </s-block>
  </s-layout>
</template>

<script setup>
  import { computed } from 'vue';
  import { onShow, onPageScroll, onPullDownRefresh } from '@dcloudio/uni-app';
  import sheep from '@/sheep';

  // 隐藏原生tabBar
  //uni.hideTabBar();

  const template = {
    "data": [
      {
        "type": "userCard",
        "style": {
          "marginLeft": 0,
          "marginRight": 0,
          "marginTop": 10,
          "marginBottom": 10,
          "borderRadiusTop": 0,
          "borderRadiusBottom": 0,
          "background": {
            "type": "color",
            "bgImage": "",
            "bgColor": ""
          }
        }
      },
      {
        "type": "menuGrid",
        "data": {
          "col": 4,
          "list": [
            {
              "src": "/static/feedback.png",
              "title": {
                "text": "意见反馈",
                "color": "#333"
              },
              "tip": {
                "text": "",
                "color": "#bbb"
              },
              "url": "\/pages\/public\/feedback",
              "badge": {
                "show": 0,
                "text": "",
                "color": "#FFFFFF",
                "bgColor": "#FF6000"
              }
            },
            {
              "src": "/static/help.png",
              "title": {
                "text": "常见问题",
                "color": "#333"
              },
              "tip": {
                "text": "",
                "color": "#bbb"
              },
              "url": "\/pages\/public\/faq",
              "badge": {
                "show": 0,
                "text": "",
                "color": "#FFFFFF",
                "bgColor": "#FF6000"
              }
            },
            {
              "src": "/static/about.png",
              "title": {
                "text": "关于我们",
                "color": "#333"
              },
              "tip": {
                "text": "",
                "color": "#bbb"
              },
              "url": "\/pages\/public\/richtext?id=3&title=关于我们",
              "badge": {
                "show": 0,
                "text": "",
                "color": "#FFFFFF",
                "bgColor": "#FF6000"
              }
            },
            {
              "src": "\/static\/agree.png",
              "title": {
                "text": "隐私协议",
                "color": "#333"
              },
              "tip": {
                "text": "",
                "color": "#bbb"
              },
              "url": "\/pages\/public\/richtext?id=4&title=隐私协议",
              "badge": {
                "show": 0,
                "text": "",
                "color": "#FFFFFF",
                "bgColor": "#FF6000"
              }
            },
          ]
        },
        "style": {
          "background": {
            "type": "color",
            "bgImage": "",
            "bgColor": "#FFFFFF"
          },
          "marginLeft": 10,
          "marginRight": 10,
          "marginTop": 0,
          "marginBottom": 10,
          "borderRadiusTop": 8,
          "borderRadiusBottom": 8,
          "padding": 0
        }
      }]
  };

  const isLogin = computed(() => sheep.$store('user').isLogin);

  onShow(() => {
    sheep.$store('user').updateUserData();
  });

  onPullDownRefresh(() => {
    sheep.$store('user').updateUserData();
    setTimeout(function () {
      uni.stopPullDownRefresh();
    }, 800);
  });

  onPageScroll(() => {});
</script>

<style></style>
