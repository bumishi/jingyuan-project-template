export let baseUrl;

if (process.env.NODE_ENV === 'development') {
    // #ifdef H5
    baseUrl = import.meta.env.SHOPRO_DEV_BASE_URL;
    // #endif

    // #ifndef H5
    baseUrl = import.meta.env.SHOPRO_DEV_CROOSS_BASE_URL;
    // #endif
} else {
    baseUrl = import.meta.env.SHOPRO_BASE_URL;
}


export const apiPath = import.meta.env.SHOPRO_API_PATH;

export const staticUrl = import.meta.env.SHOPRO_STATIC_URL;

export const appConf = {
    "app": {
        "name": "静远APP-starter",
        "logo": "\/static\/logo.png",
        "cdnurl": "https:\/\/cos.bumishi.cn",
        "version": "1.0",
        "user_protocol": {
            "title": "用户协议",
            "id": "5"
        },
        "privacy_protocol": {
            "title": "隐私协议",
            "id": "4"
        },
        "about_us": {
            "title": "关于我们",
            "id": "3"
        }
    },
    "platform": {
        "auto_login": 0,
        "bind_mobile": 0,
        "share": {
            "forwardInfo": {
                "title": "静远快速开发平台",
                "subtitle": "任何产品开发的脚手架，包含管理后台api+管理前端vue+uniapp基础功能。包括权限相关、登录注册相关、微信小程序登录绑定、系统公告。做任何产品都可以基于此开发，只需开发业务功能即可",
                "image": "/static/share.png"
            }
        }
    },
    "template": {
        "basic": {
            "theme": "orange",
            "floatMenu": {
                "show": 0,
                "mode": 1,
                "isText": 0,
                "list": []
            }
        },
        "home": {
            "style": {
                "background": {
                    "color": "#FF9237",
                    "src": ""
                }
            }
        },
    }
}

export default {
    baseUrl,
    apiPath,
    staticUrl,
};

