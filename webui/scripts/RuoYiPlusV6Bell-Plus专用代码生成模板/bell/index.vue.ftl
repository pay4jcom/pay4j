<script setup lang="ts">
import type { ${BusinessName} } from '@/api/${moduleName}/${businessName}/model';
import type { VxeGridInstance, VxeGridListeners } from 'vxe-table';

import { ref, useTemplateRef } from 'vue';

import { ${businessName}List, ${businessName}Remove } from '@/api/${moduleName}/${businessName}';
import { Page, useVben${PopupComponent} } from '@/components';
import {
    resolveQueryFormValues,
    useTableQuery,
    withDefaultVxeGridOptions,
} from '@/components/vxe-table';

import { Popconfirm, Space, Spin } from 'antdv-next';
import { VxeGrid } from 'vxe-table';

import { columns } from './data';
import ${businessName}${PopupComponent} from './${businessName}-${popupComponent}.vue';
import ${BusinessName}SearchForm from './${businessName}-search.vue';

const searchFormRef = ref<InstanceType<typeof ${BusinessName}SearchForm>>();

const tableLoading = ref(false);

const gridOptions = withDefaultVxeGridOptions<${BusinessName}>({
    checkboxConfig: {
        // 高亮
        highlight: true,
        // 翻页时保留选中状态
        reserve: true,
        // 点击行选中
        // trigger: 'row',
    },
    columns,
    height: 'auto',
    keepSource: true,
    pagerConfig: {},
    proxyConfig: {
        showLoading: false,
        ajax: {
            query: async ({ page }, formValues) => {
                const values = await resolveQueryFormValues(searchFormRef, formValues);
                tableLoading.value = true;
                try {
                    return await ${businessName}List({
                        pageNum: page.currentPage,
                        pageSize: page.pageSize,
                        ...values,
                    });
                } finally {
                    tableLoading.value = false;
                }
            },
        },
    },
    rowConfig: {
        keyField: '${pkColumn.javaField}',
    },
    toolbarConfig: {
        slots: {
            buttons: 'toolbar-left',
            tools: 'toolbar-right',
        },
    },
    id: '${moduleName}-${businessName}-index',
});

const tableRef = useTemplateRef<VxeGridInstance<${BusinessName}>>('tableRef');
const { query, reload } = useTableQuery(
    searchFormRef,
    tableRef,
    syncCheckedRows,
);
const checkedRows = ref<${BusinessName}[]>([]);

const gridEvents: VxeGridListeners = {
    checkboxAll: syncCheckedRows,
    checkboxChange: syncCheckedRows,
};

const [${BusinessName}${PopupComponent}, ${popupComponent}Api] = useVben${PopupComponent}({
    connectedComponent: ${businessName}${PopupComponent},
});

function handleAdd() {
    ${popupComponent}Api.setData({});
    ${popupComponent}Api.open();
}

async function handleEdit(record: ${BusinessName}) {
    ${popupComponent}Api.setData({ id: record.${pkColumn.javaField} });
    ${popupComponent}Api.open();
}

async function handleDelete(row: ${BusinessName}) {
    await ${businessName}Remove([row.${pkColumn.javaField}]);
    // 取消该行选中状态，避免 reserve 记录残留
    tableRef.value?.setCheckboxRow(row, false);
    await query();
}

function handleMultiDelete() {
    const rows = getCheckedRows();
    const ids = rows.map((row: ${BusinessName}) => row.${pkColumn.javaField});
    window.modal.confirm({
        title: '提示',
        okType: 'danger',
        content: `确认删除选中的${r'${ids.length}'}条记录吗？`,
        onOk: async () => {
            await ${businessName}Remove(ids);
            // 清除所有选中状态，避免 reserve 记录残留
            tableRef.value?.clearCheckboxRow();
            tableRef.value?.clearCheckboxReserve();
            await query();
        },
    });
}

function handleSearchSubmit(data: Record<string, any>) {
    reload(data);
}

function handleSearchReset() {
    reload();
}

function getCheckedRows() {
    const table = tableRef.value;
    if (!table) {
        return [];
    }
    return [
        ...table.getCheckboxRecords(),
        ...table.getCheckboxReserveRecords(),
    ] as ${BusinessName}[];
}

function syncCheckedRows() {
    checkedRows.value = getCheckedRows();
}
</script>

<template>
    <Page :auto-content-height="true">
        <Spin
            :styles="{ root: { height: '100%' }, container: { height: '100%' } }"
            :spinning="tableLoading"
            size="large"
            :delay="300"
        >
            <div class="flex h-full flex-col gap-2">
                <${BusinessName}SearchForm
                    ref="searchFormRef"
                    @reset="handleSearchReset"
                    @submit="handleSearchSubmit"
                />
                <div class="bg-card flex-1 overflow-hidden rounded-lg">
                    <VxeGrid
                        ref="tableRef"
                        class="p-2 pt-0"
                        v-bind="gridOptions"
                        v-on="gridEvents"
                    >
                        <template #toolbar-left>
                            <div class="text-[16px] font-medium">${functionName}</div>
                        </template>
                        <template #toolbar-right>
                            <Space>
                                <a-button
                                    :disabled="checkedRows.length === 0"
                                    danger
                                    type="primary"
                                    v-access:code="['system:${businessName}:remove']"
                                    @click="handleMultiDelete"
                                >
                                    {{ $t('pages.common.delete') }}
                                </a-button>
                                <a-button
                                    type="primary"
                                    v-access:code="['system:${businessName}:add']"
                                    @click="handleAdd"
                                >
                                    {{ $t('pages.common.add') }}
                                </a-button>
                            </Space>
                        </template>
                        <template #action="{ row }">
                            <Space>
                                <action-button
                                    v-access:code="['${moduleName}:${businessName}:edit']"
                                    @click="handleEdit(row)"
                                >
                                    {{ $t('pages.common.edit') }}
                                </action-button>
                                <Popconfirm
                                    placement="left"
                                    title="确认删除？"
                                    @confirm="handleDelete(row)"
                                >
                                    <action-button
                                        danger
                                        v-access:code="['${moduleName}:${businessName}:remove']"
                                        @click.stop=""
                                    >
                                        {{ $t('pages.common.delete') }}
                                    </action-button>
                                </Popconfirm>
                            </Space>
                        </template>
                        <template #loading>
                            <Spin :spinning="true" size="large" />
                        </template>
                    </VxeGrid>
                </div>
            </div>
        </Spin>
        <${BusinessName}${PopupComponent} @reload="() => query()" />
    </Page>
</template>
