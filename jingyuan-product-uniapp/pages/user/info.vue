<template>
  <s-layout title="用户信息" class="set-userinfo-wrap">
    <uni-forms
        :model="state.model"
        :rules="state.rules"
        labelPosition="left"
        border
        class="form-box"
    >
      <view class="ss-flex ss-row-center ss-col-center ss-p-t-60 ss-p-b-0 bg-white">
        <view class="header-box-content">
          <su-image
              class="content-img"
              isPreview
              :current="0"
              :src="state.model.url"
              :height="160"
              :width="160"
              :radius="80"
              mode="scaleToFill"
          ></su-image>
          <view class="avatar-action">
            <!-- #ifdef MP -->
            <button
                class="ss-reset-button avatar-action-btn"
                open-type="chooseAvatar"
                @chooseavatar="onChooseAvatar"
            >修改
            </button
            >
            <!-- #endif -->
            <!-- #ifndef MP -->
            <button class="ss-reset-button avatar-action-btn" @tap="onChangeAvatar">修改</button>
            <!-- #endif -->
          </view>
        </view>
      </view>

      <view class="bg-white ss-p-x-30">

        <uni-forms-item name="nickname" label="昵称">
          <uni-easyinput
              v-model="state.model.nickname"
              type="nickname"
              placeholder="设置昵称"
              :inputBorder="false"
              :placeholderStyle="placeholderStyle"
          />
        </uni-forms-item>

        <uni-forms-item name="gender" label="性别">
          <view class="ss-flex ss-col-center ss-h-100">
            <radio-group @change="onChangeGender" class="ss-flex ss-col-center">
              <label class="radio" v-for="item in genderRadioMap" :key="item.value">
                <view class="ss-flex ss-col-center ss-m-r-32">
                  <radio
                      :value="item.value"
                      color="var(--ui-BG-Main)"
                      style="transform: scale(0.8)"
                      :checked="item.value == state.model.gender"
                  />
                  <view class="gender-name">{{ item.name }}</view>
                </view>
              </label>
            </radio-group>
          </view>
        </uni-forms-item>

        <uni-forms-item name="mobile" label="手机号" @tap="onChangeMobile">
          <uni-easyinput
              v-model="userInfo.telephone"
              placeholder="请绑定手机号"
              :inputBorder="false"
              disabled
              :styles="{ disableColor: '#fff' }"
              :placeholderStyle="placeholderStyle"
              :clearable="false"
          >
            <template v-slot:right>
              <view class="ss-flex ss-col-center">
                <su-radio v-if="userInfo.verification?.telephone" :modelValue="true"/>
                <button v-else class="ss-reset-button ss-flex ss-col-center ss-row-center">
                  <text class="_icon-forward" style="color: #bbbbbb; font-size: 26rpx"></text>
                </button>
              </view>
            </template>
          </uni-easyinput>
        </uni-forms-item>

        <uni-forms-item name="password" label="登录密码" @tap="onSetPassword">
          <uni-easyinput
              v-model="userInfo.password"
              placeholder="修改登录密码"
              :inputBorder="false"
              :styles="{ disableColor: '#fff' }"
              disabled
              placeholderStyle="color:#BBBBBB;font-size:28rpx;line-height:normal"
              :clearable="false"
          >
            <template v-slot:right>
              <view class="ss-flex ss-col-center">
                <su-radio
                    class="ss-flex"
                    v-if="userInfo.verification?.password"
                    :modelValue="true"
                />

                <button v-else class="ss-reset-button ss-flex ss-col-center ss-row-center">
                  <text class="_icon-forward" style="color: #bbbbbb; font-size: 26rpx"></text>
                </button>
              </view>
            </template>
          </uni-easyinput>
        </uni-forms-item>
      </view>

    </uni-forms>

<!--    <view v-if="sheep.$platform.name !== 'H5'">-->
<!--      <view class="title-box ss-p-l-30">第三方账号绑定</view>-->

<!--      <view class="account-list ss-flex ss-row-between">-->
<!--        <view v-if="'WechatOfficialAccount' === sheep.$platform.name" class="ss-flex ss-col-center">-->
<!--          <image-->
<!--              class="list-img"-->
<!--              :src="sheep.$url.static('/static/img/shop/platform/WechatOfficialAccount.png')"-->
<!--          />-->
<!--          <text class="list-name">微信公众号</text>-->
<!--        </view>-->
<!--        <view v-if="'WechatMiniProgram' === sheep.$platform.name" class="ss-flex ss-col-center">-->
<!--          <image-->
<!--              class="list-img"-->
<!--              :src="sheep.$url.static('/static/img/shop/platform/WechatMiniProgram.png')"-->
<!--          />-->
<!--          <text class="list-name">微信小程序</text>-->
<!--        </view>-->
<!--        <view v-if="'App' === sheep.$platform.name" class="ss-flex ss-col-center">-->
<!--          <image-->
<!--              class="list-img"-->
<!--              :src="sheep.$url.static('/static/img/shop/platform/wechat.png')"-->
<!--          />-->
<!--          <text class="list-name">微信开放平台</text>-->
<!--        </view>-->
<!--        <view class="ss-flex ss-col-center">-->
<!--          <view class="info ss-flex ss-col-center" v-if="state.thirdOauthInfo">-->
<!--            <image-->
<!--                class="avatar ss-m-r-20"-->
<!--                :src="sheep.$url.cdn(state.thirdOauthInfo.avatar)"-->
<!--            ></image>-->
<!--            <text class="name">{{ state.thirdOauthInfo.nickname }}</text>-->
<!--          </view>-->
<!--          <view class="bind-box ss-m-l-20">-->
<!--            <button-->
<!--                v-if="state.thirdOauthInfo"-->
<!--                class="ss-reset-button relieve-btn"-->
<!--                @tap="unBindThirdOauth"-->
<!--            >-->
<!--              解绑-->
<!--            </button>-->
<!--            <button v-else class="ss-reset-button bind-btn" @tap="bindThirdOauth">绑定</button>-->
<!--          </view>-->
<!--        </view>-->
<!--      </view>-->
<!--    </view>-->

    <su-fixed bottom placeholder bg="none">
      <view class="footer-box ss-p-20">
        <button class="ss-rest-button logout-btn ui-Shadow-Main" @tap="onSubmit">保存</button>
      </view>
      <view class="footer-box ss-p-20">
        <button
            class="ss-rest-button logout-btn ui-Shadow-Main"
            @tap="onLogout">
          退出登录
        </button>
      </view>
    </su-fixed>
  </s-layout>
</template>

<script setup>
import {computed, onBeforeMount, reactive} from 'vue';
import sheep from '@/sheep';
import {clone} from 'lodash';
import {showAuthModal} from '@/sheep/hooks/useModal';
import {staticUrl} from "@/sheep/config";

const state = reactive({
  model: {},
  rules: {},
  thirdOauthInfo: null,
});

const placeholderStyle = 'color:#BBBBBB;font-size:28rpx;line-height:normal';

const genderRadioMap = [
  {
    name: '男',
    value: '1',
  },
  {
    name: '女',
    value: '2',
  },
  // {
  //   name: '未知',
  //   value: '0',
  // },
];

const userInfo = computed(() => sheep.$store('user').userInfo);

// 选择性别
function onChangeGender(e) {
  state.model.gender = e.detail.value;
}


// 修改手机号
const onChangeMobile = () => {
  showAuthModal('changeMobile');
};

function onChooseAvatar(e) {
  const tempUrl = e.detail.avatarUrl || '';
  uploadAvatar(tempUrl);
}

//修改头像
function onChangeAvatar() {
  uni.chooseImage({
    success: async (chooseImageRes) => {
      const tempUrl = chooseImageRes.tempFilePaths[0];
      uploadAvatar(tempUrl);
    },
  });
}

async function uploadAvatar(tempUrl) {
  if (!tempUrl) return;
  let {url, path} = await sheep.$api.app.upload(tempUrl, 'avatar');
  state.model.avatar = path;
  state.model.url = url;
}

// 修改/设置密码
function onSetPassword() {
  showAuthModal('changePassword');
}

// 绑定第三方账号
async function bindThirdOauth() {
  let result = await sheep.$platform.useProvider('wechat').bind();
  if (result) {
    getUserInfo();
  }
}

// 解绑第三方账号
function unBindThirdOauth() {
  uni.showModal({
    title: '解绑提醒',
    content: '解绑后您将无法通过微信登录此账号',
    cancelText: '再想想',
    confirmText: '确定',
    success: async function (res) {
      if (res.confirm) {
        const result = await sheep.$platform.useProvider('wechat').unbind();
        if (result) {
          getUserInfo();
        }
      }
    },
  });
}

// 保存信息
async function onSubmit() {
  const {code, data} = await sheep.$api.user.update({
    avatar: state.model.avatar,
    nickname: state.model.nickname,
    gender: state.model.gender,
  });
  if (code === 200) {
    await getUserInfo();
    uni.navigateBack();
  }
}

function onLogout() {
  uni.showModal({
    title: '提示',
    content: '确认退出账号？',
    success: async function (res) {
      if (res.confirm) {
        const result = await sheep.$store('user').logout();
        if (result) {
          sheep.$router.go('/pages/index/user');
        }
      }
    },
  });
}

const getUserInfo = async () => {
  const userInfo = await sheep.$store('user').getInfo();
  state.model = clone(userInfo);
  if(userInfo.avatar) {
    state.model.url = staticUrl + userInfo.avatar;
  }else{
    state.model.url = '/static/default_avatar.png';
  }
  if (sheep.$platform.name !== 'H5') {
    // //let {data, code} = await sheep.$api.user.thirdOauthInfo();
    // if (code === 200) {
    //   state.thirdOauthInfo = data;
    // }
  }
};

onBeforeMount(async () => {
  getUserInfo();
});
</script>

<style lang="scss" scoped>
:deep() {
  .uni-file-picker {
    border-radius: 50%;
  }

  .uni-file-picker__container {
    margin: -14rpx -12rpx;
  }

  .file-picker__progress {
    height: 0 !important;
  }

  .uni-list-item__content-title {
    font-size: 28 rpx !important;
    color: #333333 !important;
    line-height: normal !important;
  }

  .uni-icons {
    font-size: 40 rpx !important;
  }

  .is-disabled {
    color: #333333;
  }
}

:deep(.disabled) {
  opacity: 1;
}

.gender-name {
  font-size: 28 rpx;
  font-weight: 500;
  line-height: normal;
  color: #333333;
}

.title-box {
  font-size: 28 rpx;
  font-weight: 500;
  color: #666666;
  line-height: 100 rpx;
}

.logout-btn {
  width: 710 rpx;
  height: 80 rpx;
  background: linear-gradient(90deg, var(--ui-BG-Main), var(--ui-BG-Main-gradient));
  border-radius: 40 rpx;
  font-size: 30 rpx;
  font-weight: 500;
  color: $white;
}

.radio-dark {
  filter: grayscale(100%);
  filter: gray;
  opacity: 0.4;
}

.content-img {
  border-radius: 50%;
}

.header-box-content {
  position: relative;
  width: 160 rpx;
  height: 160 rpx;
  overflow: hidden;
  border-radius: 50%;
}

.avatar-action {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
  bottom: 0;
  z-index: 1;
  width: 160 rpx;
  height: 46 rpx;
  background: rgba(#000000, 0.3);

  .avatar-action-btn {
    width: 160 rpx;
    height: 46 rpx;
    font-weight: 500;
    font-size: 24 rpx;
    color: #ffffff;
  }
}

// 绑定项
.account-list {
  background-color: $white;
  height: 100 rpx;
  padding: 0 20 rpx;

  .list-img {
    width: 40 rpx;
    height: 40 rpx;
    margin-right: 10 rpx;
  }

  .list-name {
    font-size: 28 rpx;
    color: #333333;
  }

  .info {
    .avatar {
      width: 38 rpx;
      height: 38 rpx;
      border-radius: 50%;
      overflow: hidden;
    }

    .name {
      font-size: 28 rpx;
      font-weight: 400;
      color: $dark-9;
    }
  }

  .bind-box {
    width: 100 rpx;
    height: 50 rpx;
    line-height: normal;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 24 rpx;

    .bind-btn {
      width: 100%;
      height: 100%;
      border-radius: 25 rpx;
      background: #f4f4f4;
      color: #999999;
    }

    .relieve-btn {
      width: 100%;
      height: 100%;
      border-radius: 25 rpx;
      background: var(--ui-BG-Main-opacity-1);
      color: var(--ui-BG-Main);
    }
  }
}

.list-border {
  font-size: 28 rpx;
  font-weight: 400;
  color: #333333;
  border-bottom: 2 rpx solid #eeeeee;
}

image {
  width: 100%;
  height: 100%;
}
</style>
