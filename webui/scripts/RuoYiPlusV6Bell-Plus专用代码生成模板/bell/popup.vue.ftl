<script setup lang="ts">
import type { ${BusinessName} } from '@/api/${moduleName}/${businessName}/model';
import type { AntdFormRules } from '@/types/form';
import type { FormInstance } from 'antdv-next';

import { computed, ref } from 'vue';

import { ${businessName}Add, ${businessName}Info, ${businessName}Update } from '@/api/${moduleName}/${businessName}';
import { useVben${PopupComponent} } from '@/components';
import {
    FormInput as Input,
    FormInputNumber as InputNumber,
    FormSelect as Select,
    FormTextArea as Textarea,
} from '@/components/global/form';
<#assign hasImageUpload = false, hasFileUpload = false, hasEditor = false />
<#list columns as column>
<#if column.insert || column.edit>
<#if column.htmlType == "imageUpload"><#assign hasImageUpload = true /></#if>
<#if column.htmlType == "fileUpload"><#assign hasFileUpload = true /></#if>
<#if column.htmlType == "editor"><#assign hasEditor = true /></#if>
</#if>
</#list>
<#if hasImageUpload>
import { ImageUpload } from '@/components/upload';
</#if>
<#if hasFileUpload>
import { FileUpload } from '@/components/upload';
</#if>
<#if hasEditor>
import { Tinymce } from '@/components/tinymce';
</#if>
import { $t } from '@/locales';
import { cloneDeep, getPopupContainer } from '@/utils';
<#if dicts?has_content>
import { getDictOptions } from '@/utils/dict';

</#if>
import { useBeforeCloseDiff } from '@/utils/popup';
import { DatePicker, Form, FormItem, RadioGroup, SpaceAddon, SpaceCompact } from 'antdv-next';

const emit = defineEmits < {reload: []} > ();

const isUpdate = ref(false);
const title = computed(() => {
    return isUpdate.value ? $t('pages.common.edit') : $t('pages.common.add');
});

type FormData = Partial<${BusinessName}>;

function getDefaultValues(): FormData {
    return {
        <#list columns as column>
        <#if column.insert || column.edit>
        <#if column.htmlType == "checkbox">
        ${column.javaField}: [],
        <#elseif column.javaType == "String">
        ${column.javaField}: '',
        <#elseif column.htmlType == "datetime">
        ${column.javaField}: undefined,
        <#else>
        ${column.javaField}: undefined,
        </#if>
        </#if>
        </#list>
    };
}

const formData = ref<FormData>(getDefaultValues());
const formInstance = ref<FormInstance>();

const formRules = ref <AntdFormRules<FormData>> ({
    <#list columns as column>
    <#if column.insert || column.edit>
    <#if column.required && !column.pk>
    <#if column.htmlType == "select" || column.htmlType == "checkbox" || column.htmlType == "radio">
    ${column.javaField}: [{ required: true, message: $t('ui.formRules.selectRequired') }],
    <#else>
    ${column.javaField}: [{ required: true, message: $t('ui.formRules.required') }],
    </#if>
    </#if>
    </#if>
    </#list>
});

function customFormValueGetter() {
    return JSON.stringify(formData.value);
}

const {onBeforeClose, markInitialized, resetInitialized} = useBeforeCloseDiff(
    {
        initializedGetter: customFormValueGetter,
        currentGetter: customFormValueGetter,
    },
);

const [Basic${PopupComponent}, ${popupComponent}Api] = useVben${PopupComponent}({
    onBeforeClose,
    onClosed: handleClosed,
    onConfirm: handleConfirm,
    async onOpenChange(isOpen) {
        if (!isOpen) {
            return null;
        }
        ${popupComponent}Api.${popupComponent}Loading(true);

        const { id } = ${popupComponent}Api.getData() as { id?: number | string };
        isUpdate.value = !!id;

        if (isUpdate.value && id) {
            const record = await ${businessName}Info(id);
            formData.value = {
                ...getDefaultValues(),
                ...record,
            };
        }
        await markInitialized();

        ${popupComponent}Api.${popupComponent}Loading(false);
    },
});

async function handleConfirm() {
    try {
        ${popupComponent}Api.lock(true);
        await formInstance.value?.validate();
        const data = cloneDeep(formData.value);
        await (isUpdate.value ? ${businessName}Update(data) : ${businessName}Add(data));
        resetInitialized();
        emit('reload');
        await ${popupComponent}Api.close();
    } catch (error) {
        console.error(error);
    } finally {
        ${popupComponent}Api.lock(false);
    }
}

async function handleClosed() {
    formData.value = getDefaultValues();
    formInstance.value?.resetFields();
    resetInitialized();
}
</script>

<template>
    <Basic${PopupComponent} :title="title" :size="550">
        <Form
            ref="formInstance"
            :model="formData"
            :label-col="{ style: { width: '80px' } }"
        >
<#-- 遍历所有列，生成表单项 -->
<#list columns as column>
    <#assign field = column.javaField />
    <#if (column.insert || column.edit) && !column.pk>
        <#assign parentheseIndex = column.columnComment?index_of("（") />
        <#if parentheseIndex != -1>
            <#assign comment = column.columnComment?substring(0, parentheseIndex) />
        <#else>
            <#assign comment = column.columnComment />
        </#if>
        <#assign dictType = column.dictType!'' />
        <#assign required = column.required && !column.pk />
    <#-- 根据 htmlType 选择组件和额外属性 -->
        <#if column.htmlType == "input">
        <#-- 普通输入框 -->
            <FormItem label="${comment}" name="${field}" :rules="formRules.${field}">
                <Input
                    allow-clear
                    class="w-full"
                    v-model:value="formData.${field}"
                />
            </FormItem>
        <#elseif column.htmlType == "textarea">
            <FormItem label="${comment}" name="${field}" :rules="formRules.${field}">
                <Textarea
                    class="w-full"
                    :rows="4"
                    v-model:value="formData.${field}"
                />
            </FormItem>
        <#elseif column.htmlType == "select">
            <#if dictType?has_content>
            <FormItem label="${comment}" name="${field}" :rules="formRules.${field}">
                <Select
                    class="w-full"
                    :allow-clear="false"
                    :get-popup-container="getPopupContainer"
                    :options="getDictOptions('${dictType}')"
                    v-model:value="formData.${field}"
                />
            </FormItem>
            <#else>
            <FormItem label="${comment}" name="${field}" :rules="formRules.${field}">
                <Select
                    class="w-full"
                    :allow-clear="false"
                    :get-popup-container="getPopupContainer"
                    :options="[]"
                    v-model:value="formData.${field}"
                />
            </FormItem>
            </#if>
        <#elseif column.htmlType == "radio">
            <#if dictType?has_content>
            <FormItem label="${comment}" name="${field}" :rules="formRules.${field}">
                <RadioGroup
                    button-style="solid"
                    option-type="button"
                    :options="getDictOptions('${dictType}')"
                    v-model:value="formData.${field}"
                />
            </FormItem>
            <#else>
            <FormItem label="${comment}" name="${field}" :rules="formRules.${field}">
                <RadioGroup
                    button-style="solid"
                    option-type="button"
                    :options="[]"
                    v-model:value="formData.${field}"
                />
            </FormItem>
            </#if>
        <#elseif column.htmlType == "checkbox">
            <#if dictType?has_content>
            <FormItem label="${comment}" name="${field}" :rules="formRules.${field}">
                <CheckboxGroup
                    :options="getDictOptions('${dictType}')"
                    v-model:value="formData.${field}"
                />
            </FormItem>
            <#else>
            <FormItem label="${comment}" name="${field}" :rules="formRules.${field}">
                <CheckboxGroup
                    :options="[]"
                    v-model:value="formData.${field}"
                />
            </FormItem>
            </#if>
        <#elseif column.htmlType == "datetime">
            <FormItem label="${comment}" name="${field}" :rules="formRules.${field}">
                <DatePicker
                    class="w-full"
                    format="YYYY-MM-DD HH:mm:ss"
                    value-format="YYYY-MM-DD HH:mm:ss"
                    v-model:value="formData.${field}"
                />
            </FormItem>
        <#elseif column.htmlType == "imageUpload">
            <FormItem label="${comment}" name="${field}" :rules="formRules.${field}">
                <ImageUpload
                    :max-count="1"
                    v-model:value="formData.${field}"
                />
            </FormItem>
        <#elseif column.htmlType == "fileUpload">
            <FormItem label="${comment}" name="${field}" :rules="formRules.${field}">
                <FileUpload
                    :max-count="1"
                    v-model:value="formData.${field}"
                />
            </FormItem>
        <#elseif column.htmlType == "editor">
            <FormItem label="${comment}" name="${field}" :rules="formRules.${field}">
                <Tinymce
                    :disabled="false"
                    v-model="formData.${field}"
                />
            </FormItem>
        </#if>
    </#if>
</#list>
        </Form>
    </Basic${PopupComponent}>
</template>
