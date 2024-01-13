import request from '@/sheep/request';
import {apiPath, baseUrl} from '@/sheep/config';

export default {
    getNotice: () =>
        request({
            url: '/system/notice/query',
            method: 'GET',
        }),
    // 系统初始化
    // 发送短信
    sendSms: (data) =>
        request({
            url: '/system/sms/send',
            method: 'POST',
            params:data,
            custom: {
                showSuccess: true,
                loadingMsg: '发送中',
            },
        }),
    //意见反馈
    feedback: (data) =>
        request({
            url: '/system/feedback/add',
            method: 'POST',
            data,
        }),
    // 自定义页面
    page: (id) =>
        request({
            url: 'page/' + id,
            method: 'GET',
        }),

    //上传
    upload: (file, group = 'avatar', callback) => {
        const token = uni.getStorageSync('token');
        uni.showLoading({
            title: '上传中',
        });
        return new Promise((resolve, reject) => {
            uni.uploadFile({
                url: baseUrl+apiPath + '/system/upload/img',
                filePath: file,
                name: file.name,
                formData: {
                    path:group
                },
                header: {
                    Accept: 'text/json',
                    Authorization: token,
                },
                success: (uploadFileRes) => {
                    let result = JSON.parse(uploadFileRes.data);
                    if (result.code != 200) {
                        uni.showToast({
                            icon: 'none',
                            title: result.msg,
                        });
                    } else {
                        return resolve(result.data);
                    }
                },
                fail: (error) => {
                    console.log('上传失败：', error);
                    return resolve(false);
                },
                complete: () => {
                    uni.hideLoading();
                },
            });
        });
    },
};
