import request from '@/sheep/request';

export default {
  area: () =>
    request({
      url: 'data/area',
      method: 'GET',
    }),
  faq: () =>
    request({
      url: '/vadmin/help/issue/categorys/platform/1',
      method: 'GET',
    }),
  richtext: (tab_id) => {

      let url='/system/settings/tabs/values?tab_id='+tab_id
      //关于我们
        //4隐私政策
      //5用户协议
      if(tab_id==4){
          url='/system/settings/privacy'
      }else if(tab_id==5){
          url='/system/settings/agreement'
      }else if(tab_id==3){
          url='/system/settings/about'
      }
      return request({
          url: url,
          method: 'GET',
      })
  }
};
