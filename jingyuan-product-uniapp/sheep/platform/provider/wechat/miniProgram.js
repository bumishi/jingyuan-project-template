import {isEmpty} from 'lodash';
import third from '@/sheep/api/third';
import $store from '@/sheep/store';

let sessionId = uni.getStorageSync('sessionId');
let subscribeEventList = [];

// 加载微信小程序
function load() {

}

// 微信小程序静默授权登陆
const login = async () => {
    let codeStr = '';
    const loginResult = await uni.login();
    //console.log(loginResult)
    if (loginResult.errMsg === 'login:ok') {
        codeStr = loginResult.code;
    } else {
        return new Promise((resolve, reject) => {
            reject()
        })
    }
    return new Promise(async (resolve, reject) => {
        const res = await third.wechat.login({
            code: codeStr
        });
        resolve(res);
    });
};

// 微信小程序手机号授权登陆
const mobileLogin = async (e) => {
    return new Promise(async (resolve, reject) => {
        if (e.errMsg !== 'getPhoneNumber:ok') {
            resolve(false);
            return;
        }

        const res = await third.wechat.login({
            code: e.code,
            iv: e.iv,
            encryptedData: e.encryptedData,
        });

        if (res.code === 200) {
            resolve(true);
        }

        resolve(false);
    });
};

// 微信小程序绑定
const bind = () => {
    return new Promise(async (resolve, reject) => {
        const wxinfo = await uni.login();
        if (wxinfo.errMsg == 'login:ok') {
            const loginRes = await third.wechat.bind({
                code: wxinfo.code
            });

            if (loginRes.code === 200) {
                resolve(true);
            } else {
                reject(false);
            }
        } else {
            reject(false);
        }
    });
};

// 微信小程序解除绑定
const unbind = async () => {
    const {error} = await third.wechat.unbind({
        platform: 'miniProgram',
    });
    return !error;
};

// 获取最新sessionId
const getSessionId = async (auto_login = null) => {
    // 获取code
    let codeStr = '';
    const loginResult = await uni.login();
    if (loginResult.errMsg === 'login:ok') {
        codeStr = loginResult.code;
    } else {
        getSessionId(auto_login);
        return false;
    }
    if (auto_login === null) {
        auto_login = !!($store('app').platform.auto_login && !$store('user').isLogin);
    }

    const {error, data} = await third.wechat.getSessionId({
        platform: 'miniProgram',
        payload: encodeURIComponent(
            JSON.stringify({
                code: codeStr,
                auto_login,
            }),
        ),
    });
    if (error === 0) {
        uni.setStorageSync('sessionId', data.session_id);
        return true;
    }
    return false;
};

// 检查sessionId是否可用
const checkSession = () => {
    return new Promise((resolve, reject) => {
        if (!sessionId) {
            return resolve(false);
        }
        uni.checkSession({
            success() {
                return resolve(true);
            },
            fail() {
                uni.removeStorageSync('sessionId');
                return resolve(false);
            },
        });
    });
};

// 小程序更新
const checkUpdate = async (silence = true) => {
    if (uni.canIUse('getUpdateManager')) {
        const updateManager = uni.getUpdateManager();
        updateManager.onCheckForUpdate(function (res) {
            // 请求完新版本信息的回调
            if (res.hasUpdate) {
                updateManager.onUpdateReady(function () {
                    uni.showModal({
                        title: '更新提示',
                        content: '新版本已经准备好，是否重启应用？',
                        success: function (res) {
                            if (res.confirm) {
                                // 新的版本已经下载好，调用 applyUpdate 应用新版本并重启
                                updateManager.applyUpdate();
                            }
                        },
                    });
                });
                updateManager.onUpdateFailed(function () {
                    // 新的版本下载失败
                    // uni.showModal({
                    //   title: '已经有新版本了哟~',
                    //   content: '新版本已经上线啦，请您删除当前小程序，重新搜索打开~',
                    // });
                });
            } else {
                if (!silence) {
                    uni.showModal({
                        title: '当前为最新版本',
                        showCancel: false,
                    });
                }
            }
        });
    }
};

// 绑定用户手机号
const bindUserPhoneNumber = (e) => {
    return new Promise(async (resolve, reject) => {
        const {code} = await third.wechat.bindUserPhoneNumber({
            code: e.code
        });
        if (code === 200) {
            resolve(true);
        }
        resolve(false);
    });
};

// 获取订阅消息模板
async function getSubscribeTemplate() {
    const {error, data} = await third.wechat.subscribeTemplate();
    if (error === 0) {
        subscribeEventList = data;
    }
}

// 订阅消息
function subscribeMessage(event) {
    let tmplIds = [];
    if (typeof event === 'string') {
        tmplIds.push(subscribeEventList[event]);
    }
    if (typeof event === 'object') {
        event.forEach((item) => {
            if (typeof subscribeEventList[item] !== 'undefined') tmplIds.push(subscribeEventList[item]);
        });
    }
    if (tmplIds.length === 0) return;

    uni.requestSubscribeMessage({
        tmplIds,
        fail: (err) => {
            console.log(err);
        },
    });
}

export default {
    load,
    login,
    bind,
    unbind,
    checkUpdate,
    bindUserPhoneNumber,
    subscribeMessage,
};
