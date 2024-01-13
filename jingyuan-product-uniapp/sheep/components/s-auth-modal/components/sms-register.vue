<!-- 短信注册 - smsRegister  -->
<template>
  <view>
    <!-- 标题栏 -->
    <view class="head-box ss-m-b-60">
      <view class="head-title ss-m-b-20">注册</view>
      <view class="head-subtitle">请使用本人手机号完成注册</view>
    </view>

    <!-- 表单项 -->
    <uni-forms
      ref="smsRegisterRef"
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
          type="number"
          :inputBorder="false"
        >
          <template v-slot:right>
            <button
              class="ss-reset-button code-btn code-btn-start"
              :disabled="state.isMobileEnd"
              :class="{ 'code-btn-end': state.isMobileEnd }"
              @tap="getSmsCode('smsRegister', state.model.mobile)"
            >
              {{ getSmsTimer('smsRegister') }}
            </button>
          </template>
        </uni-easyinput>
      </uni-forms-item>

      <uni-forms-item name="code" label="验证码">
        <uni-easyinput
          placeholder="请输入验证码"
          v-model="state.model.code"
          :inputBorder="false"
          type="number"
          maxlength="6"
        >
          <template v-slot:right>
            <button class="ss-reset-button login-btn-start" @tap="smsRegisterSubmit"> 注册 </button>
          </template>
        </uni-easyinput>
      </uni-forms-item>

    </uni-forms>

    <button class="ss-reset-button type-btn" @tap="showAuthModal('accountLogin')">
      返回登录
    </button>
  </view>
</template>

<script setup>
  import { computed, ref, reactive, unref } from 'vue';
  import sheep from '@/sheep';
  import { code, mobile, password } from '@/sheep/validate/form';
  import { showAuthModal, closeAuthModal, getSmsCode, getSmsTimer } from '@/sheep/hooks/useModal';
  import $store from "@/sheep/store";

  const props = defineProps({
    agreeStatus: {
      type: Boolean,
      default: false,
    },
  });

  const smsRegisterRef = ref(null);
  
  const isLogin = computed(() => sheep.$store('user').isLogin);

  const emits = defineEmits(['onConfirm']);

  // 数据
  const state = reactive({
    isMobileEnd: false, // 手机号输入完毕
    model: {
      mobile: '', // 手机号
      code: '' // 验证码
    },
    rules: {
      code,
      mobile
    },
  });

  // 3.短信注册
  async function smsRegisterSubmit() {
    const validate = await unref(smsRegisterRef)
      .validate()
      .catch((error) => {
        console.log('error: ', error);
      });
    if (!validate) return;

    if (!props.agreeStatus) {
      emits('onConfirm',true);
      sheep.$helper.toast('请勾选同意');
      return;
    }

    const res = await sheep.$api.user.smsRegister({
      ...state.model
    });
    if (res.code === 200) {
      $store('user').setToken(res.data.token_type+' '+res.data.access_token);
      closeAuthModal();
    }
  }
</script>

<style lang="scss" scoped>
  @import '../index.scss';
</style>
