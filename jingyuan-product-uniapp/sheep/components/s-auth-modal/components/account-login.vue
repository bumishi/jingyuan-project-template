<!-- 账号密码登录 accountLogin  -->
<template>
  <view>
    <!-- 标题栏 -->
    <view class="head-box ss-m-b-60 ss-flex-col">
      <view class="ss-flex ss-m-b-20">
        <view class="head-title ss-m-r-40 head-title-animation">账号登录</view>
        <view class="head-title-active head-title-line" @tap="showAuthModal('smsLogin')">
          短信登录
        </view>
      </view>
      <view class="head-subtitle">如果未设置过密码，请点击忘记密码</view>
    </view>

    <!-- 表单项 -->
    <uni-forms
      ref="accountLoginRef"
      v-model="state.model"
      :rules="state.rules"
      validateTrigger="bind"
      labelWidth="140"
      labelAlign="center"
    >
      <uni-forms-item name="account" label="账号">
        <uni-easyinput placeholder="请输入手机号" v-model="state.model.mobile"  type="number" :inputBorder="false">
          <template v-slot:right>
            <view class="ss-reset-button forgot-btn">
            </view>
          </template>
        </uni-easyinput>
      </uni-forms-item>

      <uni-forms-item name="password" label="密码">
        <uni-easyinput
          type="password"
          placeholder="请输入密码"
          v-model="state.model.password"
          :inputBorder="false"
        >
          <template v-slot:right>
            <button class="ss-reset-button login-btn-start" @tap="accountLoginSubmit">登录</button>
          </template>
        </uni-easyinput>
      </uni-forms-item>
    </uni-forms>
  </view>
</template>

<script setup>
  import { computed, watch, ref, reactive, unref } from 'vue';
  import sheep from '@/sheep';
  import {account, mobile, password} from '@/sheep/validate/form';
  import { showAuthModal, closeAuthModal } from '@/sheep/hooks/useModal';
  import $store from "@/sheep/store";

  const accountLoginRef = ref(null);

  const emits = defineEmits(['onConfirm']);

  const props = defineProps({
    agreeStatus: {
      type: Boolean,
      default: false,
    },
  });
  // 数据
  const state = reactive({
    model: {
      method:'0',
      platform:'1',
      mobile: '', // 账号
      password: '', // 密码
    },
    rules: {
      mobile,
      password,
    },
  });

  // 1.账号登录
  async function accountLoginSubmit() {
    // 表单验证
    const validate = await unref(accountLoginRef)
      .validate()
      .catch((error) => {
        console.log('error: ', error);
      });
    if (!validate) return;

    // 同意协议
    if (!props.agreeStatus) {
      emits('onConfirm', true)
      sheep.$helper.toast('请勾选同意');
      return;
    }

    // 提交数据
    sheep.$api.user.accountLogin(state.model).then((res) => {
      if (res.code === 200) {
        $store('user').setToken(res.data.token_type+' '+res.data.access_token);
         //sheep.$store('user').getInfo();
        closeAuthModal();
      }
    });
  }
</script>

<style lang="scss" scoped>
  @import '../index.scss';
</style>
