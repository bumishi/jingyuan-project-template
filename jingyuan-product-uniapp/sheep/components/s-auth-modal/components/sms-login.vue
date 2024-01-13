<!-- 短信登录 - smsLogin  -->
<template>
  <view>
    <!-- 标题栏 -->
    <view class="head-box ss-m-b-60">
      <view class="ss-flex ss-m-b-20">
        <view class="head-title-active ss-m-r-40" @tap="showAuthModal('accountLogin')"
          >账号登录</view
        >
        <view class="head-title head-title-line head-title-animation">短信登录</view>
      </view>
      <view class="head-subtitle">未注册手机号请先点击下方立即注册</view>
    </view>

    <!-- 表单项 -->
    <uni-forms
      ref="smsLoginRef"
      v-model="state.model"
      :rules="state.rules"
      validateTrigger="bind"
      labelWidth="140"
      labelAlign="center"
    >
      <uni-forms-item name="mobile" label="手机号">
        <uni-easyinput
          placeholder="请输入手机号"
          v-model="state.model.mobile"
          :inputBorder="false"
          type="number"
        >
          <template v-slot:right>
            <button
              class="ss-reset-button code-btn code-btn-start"
              :disabled="state.isMobileEnd"
              :class="{ 'code-btn-end': state.isMobileEnd }"
              @tap="getSmsCode('login', state.model.mobile)"
            >
              {{ getSmsTimer('login') }}
            </button>
          </template>
        </uni-easyinput>
      </uni-forms-item>

      <uni-forms-item name="code" label="验证码">
        <uni-easyinput
          placeholder="请输入验证码"
          v-model="state.model.password"
          :inputBorder="false"
          type="number"
          maxlength="6"
        >
          <template v-slot:right>
            <button class="ss-reset-button login-btn-start" @tap="smsLoginSubmit"> 登录 </button>
          </template>
        </uni-easyinput>
      </uni-forms-item>
    </uni-forms>
  </view>
</template>

<script setup>
  import { computed, watch, ref, reactive, unref } from 'vue';
  import sheep from '@/sheep';
  import { code, mobile } from '@/sheep/validate/form';
  import { showAuthModal, closeAuthModal, getSmsCode, getSmsTimer } from '@/sheep/hooks/useModal';
  import $store from "@/sheep/store";

  const smsLoginRef = ref(null);

  const emits = defineEmits(['onConfirm']);

  const props = defineProps({
    agreeStatus: {
      type: Boolean,
      default: false,
    },
  });

  // 数据
  const state = reactive({
    isMobileEnd: false, // 手机号输入完毕
    codeText: '获取验证码',
    model: {
      method:'1',
      platform:'1',
      mobile: '', // 手机号
      password: '', // 验证码
    },
    rules: {
      code,
      mobile,
    },
  });

  // 2.短信登录
  async function smsLoginSubmit() {
    const validate = await unref(smsLoginRef)
      .validate()
      .catch((error) => {
        console.log('error: ', error);
      });
    if (!validate) return;

    if (!props.agreeStatus) {
      emits('onConfirm', true)
      sheep.$helper.toast('请勾选同意');
      return;
    }
    const res = await sheep.$api.user.smsLogin(state.model);
    if (res.code === 200) {
      $store('user').setToken(res.data.token_type+' '+res.data.access_token);
      //sheep.$store('user').getInfo();
      closeAuthModal();
    }
  }
</script>

<style lang="scss" scoped>
  @import '../index.scss';
</style>
