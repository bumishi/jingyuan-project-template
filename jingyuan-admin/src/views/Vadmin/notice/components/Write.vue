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
    field: 'title',
    label: '标题',
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
    field: 'detail',
    label: '内容',
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
    field: 'begin_time',
    label: '开始时间',
    colProps: {
      span: 12
    },
    component: 'DatePicker',
    componentProps: {
      style: {
        width: '100%'
      },type:'datetime',format:"YYYY-MM-DD HH:mm:ss",valueFormat:"YYYY-MM-DD HH:mm:ss"
    }
  }, 
  {
    field: 'end_time',
    label: '结束时间',
    colProps: {
      span: 12
    },
    component: 'DatePicker',
    componentProps: {
      style: {
        width: '100%'
      },type:'datetime',format:"YYYY-MM-DD HH:mm:ss",valueFormat:"YYYY-MM-DD HH:mm:ss"
    }
  }, 
])

const rules = reactive({ 
  id: [required()],
  title: [required()],
  detail: [required()],
  begin_time: [required()],
  end_time: [required()],
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