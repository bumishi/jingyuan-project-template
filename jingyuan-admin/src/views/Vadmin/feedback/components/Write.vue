<script setup lang="tsx">
import {Form, FormSchema} from '@/components/Form'
import {useForm} from '@/hooks/web/useForm'
import {PropType, reactive, watch} from 'vue'
import {useValidator} from '@/hooks/web/useValidator'


const {required, isTelephone, isEmail} = useValidator()

const props = defineProps({
  currentRow: {
    type: Object as PropType<any>,
    default: () => null
  }
})

const formSchema = reactive<FormSchema[]>([
  {
    field: 'catalog',
    label: '分类',
    colProps: {
      span: 12
    },
    component: 'Input',
    componentProps: {
      style: {
        width: '100%'
      }
    }
  }, 
  {
    field: 'mark',
    label: '描述',
    colProps: {
      span: 12
    },
    component: 'Input',
    componentProps: {
      style: {
        width: '100%'
      },type:'textarea',rows:3
    }
  }, 
  {
    field: 'attachs',
    label: '附件图片地址',
    colProps: {
      span: 12
    },
    component: 'Input',
    componentProps: {
      style: {
        width: '100%'
      },type:'textarea',rows:3
    }
  }, 
  {
    field: 'user_id',
    label: '用户',
    colProps: {
      span: 12
    },
    component: 'InputNumber',
    componentProps: {
      style: {
        width: '100%'
      }
    }
  }, 
  {
    field: 'concat',
    label: '联系方式',
    colProps: {
      span: 12
    },
    component: 'InputNumber',
    componentProps: {
      style: {
        width: '100%'
      }
    }
  }, 
])

const rules = reactive({ 
  id: [required()],
  catalog: [required()],
})

const {formRegister, formMethods} = useForm()
const {setValues, getFormData, getElFormExpose} = formMethods

const submit = async () => {
  const elForm = await getElFormExpose()
  const valid = await elForm?.validate()
  if (valid) {
    const formData = await getFormData()
    return formData
  }
}

watch(
    () => props.currentRow,
    (currentRow) => {
      if (!currentRow) return
      setValues(currentRow)
    },
    {
      deep: true,
      immediate: true
    }
)

defineExpose({
  submit
})
</script>

<template>
  <Form :rules="rules" @register="formRegister" :schema="formSchema"/>
</template>