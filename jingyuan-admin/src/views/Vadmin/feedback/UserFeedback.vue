<script setup lang="tsx">
import { reactive, ref, unref } from 'vue'
import {
  queryListApi,
  addApi,
  delApi,
  updateApi,
  getApi
} from '@/api/vadmin/feedback/user_feedback.ts'
import { useTable } from '@/hooks/web/useTable'
import { useI18n } from '@/hooks/web/useI18n'
import { Table, TableColumn } from '@/components/Table'
import { ElButton, ElSwitch } from 'element-plus'
import { Search } from '@/components/Search'
import { FormSchema } from '@/components/Form'
import { ContentWrap } from '@/components/ContentWrap'
import Write from './components/Write.vue'
import { Dialog } from '@/components/Dialog'
import {selectDictLabel} from "@/utils/dict";

defineOptions({
  name: 'UserFeedback'
})

const { t } = useI18n()

const { tableRegister, tableState, tableMethods } = useTable({
  fetchDataApi: async () => {
    const { pageSize, currentPage } = tableState
    const res = await queryListApi({
      page: unref(currentPage),
      limit: unref(pageSize),
      ...unref(searchParams)
    })
    return {
      list: res.data || [],
      total: res.count || 0
    }
  },
  fetchDelApi: async (value) => {
    const res = await delApi(value)
    return res.code === 200
  }
})

const { dataList, loading, total, pageSize, currentPage } = tableState
const { getList, delList } = tableMethods

const tableColumns = reactive<TableColumn[]>([

   {
    field: 'id',
    label: 'id',
    show: true,
  },

   {
    field: 'catalog',
    label: '分类',
    show: true,
  },

   {
    field: 'mark',
    label: '描述',
    show: true
  },

   {
    field: 'attachs',
    label: '附件图片地址',
    show: true,
     slots: {
       default: (data: any) => {
         const row = data.row
         console.log(row)
         if(!row.attachs||row.attachs==null){
           return <><div></div></>
         }
         //tsx语法中只能有表达式
         return (
             <>
               <div>
                 {
                   row.attachs.split(",").map(item=>{
                     return <span><a href={item} target="_blank">附件</a>|</span>
                  })
                 }
               </div>
             </>
         )
       }
     }
  },

   {
    field: 'user_id',
    label: '用户ID',
    show: true,
  },

   {
    field: 'concat',
    label: '联系方式',
    show: true,
  },

   {
    field: 'create_time',
    label: '反馈时间',
    show: true,
  },


])

const searchSchema = reactive<FormSchema[]>([

  {
    field: 'catalog',
    label: '分类',
    component: 'Input',
    componentProps: {
      clearable: false,
      style: {
        width: '214px'
      }
    }
  },
   
])

const searchParams = ref({})
const setSearchParams = (data: any) => {
  currentPage.value = 1
  searchParams.value = data
  getList()
}

const delLoading = ref(false)

const delData = async (row: any) => {
  delLoading.value = true
  await delList(true, [row.id]).finally(() => {
    delLoading.value = false
  })
}

const dialogVisible = ref(false)
const dialogTitle = ref('')

const currentRow = ref()
const actionType = ref('')

const writeRef = ref<ComponentRef<typeof Write>>()

const saveLoading = ref(false)

</script>

<template>
  <ContentWrap>
    <Search :schema="searchSchema" @reset="setSearchParams" @search="setSearchParams" />
    <Table
      v-model:current-page="currentPage"
      v-model:page-size="pageSize"
      showAction
      :columns="tableColumns"
      default-expand-all
      node-key="id"
      :data="dataList"
      :loading="loading"
      :pagination="{
        total
      }"
      @register="tableRegister"
      @refresh="getList"
    >
      <template #toolbar>
        
      </template>
    </Table>
  </ContentWrap>

  <Dialog v-model="dialogVisible" :title="dialogTitle" :height="650">
    <Write ref="writeRef" :current-row="currentRow" />

    <template #footer>
      <ElButton type="primary" :loading="saveLoading" @click="save">
        {{ t('exampleDemo.save') }} 
      </ElButton>
      <ElButton @click="dialogVisible = false">{{ t('dialogDemo.close') }} </ElButton>
    </template>
  </Dialog>
</template>