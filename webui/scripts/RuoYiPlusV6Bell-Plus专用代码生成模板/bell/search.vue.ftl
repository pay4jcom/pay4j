<script setup lang="ts">
import type { FormInstance } from 'antdv-next';
import type { Dayjs } from 'dayjs';

import { ref } from 'vue';

import { FormInput, FormSelect } from '@/components/global/form';
import { SearchButtonGroup } from '@/components/table';
import { tableSeachClass } from '@/components/vxe-table';
import { getDictOptions } from '@/utils/dict';
import { Card, DateRangePicker, Form, FormItem } from 'antdv-next';

const emit = defineEmits<{
    reset: [];
    submit: [record: Record<string, any>];
}>();

interface SearchParams {
    <#list columns as column>
    <#if column.query>
    ${column.javaField}?: <#if column.queryType == 'BETWEEN'> [Dayjs, Dayjs]; <#else> string;</#if>
    </#if>
    </#list>
}

const model = ref<SearchParams>({
    <#list columns as column>
    <#if column.query>
    ${column.javaField}: undefined,
    </#if>
    </#list>
});

const formInstance = ref<FormInstance>();
const searchCollapsed = ref(false);

function buildSearchParams(values: SearchParams) {
    return { ...values };
}

async function getValues() {
    return buildSearchParams(model.value);
}

async function handleSubmit() {
    await formInstance.value?.validate();
    emit('submit', await getValues());
}

async function handleReset() {
    formInstance.value?.resetFields();
    emit('reset');
}

defineExpose({
    getValues,
    resetFields: () => formInstance.value?.resetFields(),
});
</script>

<template>
    <Card size="small">
        <Form
            @keydown.enter.prevent="handleSubmit"
            ref="formInstance"
            :model="model"
            :label-col="{ style: { width: '80px' } }"
        >
            <div :class="tableSeachClass">
                <template v-if="!searchCollapsed">
            <#list columns as column>
                <#if column.query>
                <#-- 提取字典类型和字段注释 -->
                    <#assign dictType = column.dictType!'' />
                    <#assign parentheseIndex = column.columnComment?index_of("（") />
                    <#if parentheseIndex != -1>
                        <#assign comment = column.columnComment?substring(0, parentheseIndex) />
                    <#else>
                        <#assign comment = column.columnComment />
                    </#if>
                <#-- 根据 htmlType 和 queryType 确定组件 -->
                    <#if column.htmlType == "input">
                        <#assign component = "FormInput" />
                    <#elseif column.htmlType == "textarea">
                        <#assign component = "FormTextArea" />
                    <#elseif column.htmlType == "select">
                        <#assign component = "FormSelect" />
                    <#elseif column.htmlType == "radio">
                        <#assign component = "RadioGroup" />
                    <#elseif column.htmlType == "datetime" && column.queryType == "BETWEEN">
                        <#assign component = "DateRangePicker" />
                    <#else>
                        <#assign component = "FormInput" />
                    </#if>
                    <FormItem label="${comment}" name="${column.javaField}">
                    <#if component == "FormSelect">
                        <FormSelect
                            allow-clear
                            v-model:value="model.${column.javaField}"
                            :options="getDictOptions(${dictType?has_content?then("'" + dictType + "'", "[]")})"
                        />
                    <#elseif component == "DateRangePicker">
                        <DateRangePicker
                            allow-clear
                            v-model:value="model.${column.javaField}"
                        />
                    <#elseif component == "RadioGroup">
                        <RadioGroup
                            button-style="solid"
                            option-type="button"
                            v-model:value="model.${column.javaField}"
                            :options="getDictOptions(${dictType?has_content?then("'" + dictType + "'", "[]")})"
                        />
                    <#else>
                        <${component} v-model:value="model.${column.javaField}" allow-clear />
                    </#if>
                    </FormItem>
                </#if>
            </#list>
                </template>
                <!-- [grid-column-end:-1] 始终定位到最后一列，justify-self-end 靠右对齐 -->
                <div class="[grid-column-end:-1] flex items-baseline justify-end gap-4">
                    <SearchButtonGroup
                        v-model:collapsed="searchCollapsed"
                        @reset="handleReset"
                        @submit="handleSubmit"
                    />
                </div>
            </div>
        </Form>
    </Card>
</template>
