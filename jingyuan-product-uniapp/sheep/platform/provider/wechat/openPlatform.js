// 登录
import {isEmpty} from 'lodash';
import third from '@/sheep/api/third';

const load = async () => {
};

// 微信开放平台移动应用授权登陆
const login = () => {
    return new Promise(async (resolve, reject) => {
        const loginRes = await uni.login({
            provider: 'weixin',
            onlyAuthorize: true,
        });
        if (loginRes.errMsg == 'login:ok') {
            const res = await third.wechat.login({
                mobile: '',
                code: loginRes.code

            });

            if (res.code ===200) {
                resolve(true);
            }
        } else {
            uni.showToast({
                icon: 'none',
                title: loginRes.errMsg,
            });
        }
        resolve(false);
    });
};

export default {
    load,
    login,
};
