import request from '@/config/axios'

export const queryListApi = (params: any): Promise<IResponse> => {
  return request.post({ url: '/vadmin/system/feedback/query', data:params })
}

export const addApi = (data: any): Promise<IResponse> => {
  return request.post({ url: '/vadmin/system/feedback/add', data })
}

export const delApi = (data: any): Promise<IResponse> => {
  return request.post({ url: '/vadmin/system/feedback/del', data })
}

export const updateApi = (data: any): Promise<IResponse> => {
  return request.post({ url: `/vadmin/system/feedback/update/${data.id}`, data })
}

export const getApi = (dataId: number): Promise<IResponse> => {
  return request.get({ url: `/vadmin/system/feedback/get/${dataId}` })
}
