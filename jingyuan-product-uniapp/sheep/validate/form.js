/**
 * Validate v1.0.0 通用验证
 * @description 项目中用到的表单验证规则
 */
import test from '@/sheep/helper/test.js';

// 手机号
export const mobile = {
  rules: [
    {
      required: true,
      errorMessage: '请输入手机号',
    },
    {
      validateFunction: function (rule, value, data, callback) {
        if (!test.mobile(value)) {
          callback('手机号码格式不正确');
        }
        return true;
      },
    },
  ],
};

// 账户
export const account = {
  rules: [
    {
      required: true,
      errorMessage: '请输入账号',
    },
    {
      validateFunction: function (rule, value, data, callback) {
        if (value.length < 5) {
          callback('账号长度不能小于5位');
        }
        return true;
      },
    },
  ],
};

// 密码
export const password = {
  rules: [
    {
      required: true,
      errorMessage: '请输入密码',
    },
    // {
    //   validateFunction: function (rule, value, data, callback) {
    //     if (!/^([0-9]+$)([a-zA-Z]+$)[0-9A-Za-z]+\S{7,16}$/.test(value)) {
    //       callback('密码为字母和数字组合,长度在8-16之间');
    //     }
    //     return true;
    //   }
    // }
  ]
};

// 昵称
export const username = {
  rules: [
    {
      required: true,
      errorMessage: '请输入用户名',
    },
    {
      validateFunction: function (rule, value, data, callback) {
        if (value.length < 5) {
          callback('用户名长度不能小于5位');
        }
        return true;
      },
    },
  ],
};

// 短信验证码
export const code = {
  rules: [
    {
      required: true,
      errorMessage: '请输入验证码',
    },
  ],
};

// 真实姓名
export const realName = {
  rules: [
    {
      required: true,
      errorMessage: '请输入姓名',
    },
    {
      validateFunction: function (rule, value, data, callback) {
        if (!test.chinese(value)) {
          callback('请输入汉字');
        }
        return true;
      },
    },
  ],
};

export const taxName = {
  rules: [
    {
      required: true,
      errorMessage: '请输入发票抬头名称',
    },
    {
      validateFunction: function (rule, value, data, callback) {
        if (!test.chinese(value)) {
          callback('请输入汉字');
        }
        return true;
      },
    },
  ],
};

// 税号
export const taxNo = {
  rules: [
    {
      required: true,
      errorMessage: '请输入税号',
    },
  ],
};

// 开户行
export const bankName = {
  rules: [
    {
      required: true,
      errorMessage: '请输入开户行',
    },
    {
      validateFunction: function (rule, value, data, callback) {
        if (!test.chinese(value)) {
          callback('请输入汉字');
        }
        return true;
      },
    },
  ],
};
// 银行卡号
export const bankCode = {
  rules: [
    {
      required: true,
      errorMessage: '请输入银行卡号',
    },
    {
      validateFunction: function (rule, value, data, callback) {
        if (!test.number(value)) {
          callback('请输入正确账号');
        }
        return true;
      },
    },
  ],
};

// 支付宝账号
export const alipayAccount = {
  rules: [
    {
      required: true,
      errorMessage: '请输入支付宝账号',
    },
    {
      validateFunction: function (rule, value, data, callback) {
        let isEmail = test.email(value);
        let isMobile = test.mobile(value);

        if (!isEmail && !isMobile) {
          callback('请输入正确账号');
        }
        return true;
      },
    },
  ],
};

export const consignee = {
  rules: [
    {
      required: true,
      errorMessage: '请输入收货人姓名',
    },
  ],
};

export const region = {
  rules: [
    {
      required: true,
      errorMessage: '请选择您的位置',
    },
  ],
};
export const address = {
  rules: [
    {
      required: true,
      errorMessage: '请输入详细地址',
    },
  ],
};

export default {
  mobile,
  alipayAccount,
  bankCode,
  bankName,
  realName,
  password,
  code,
  account,
  consignee,
  address,
  region,
  taxNo,
  taxName,
};
