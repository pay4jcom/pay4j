<script setup lang="ts">
import type { ${BusinessName} } from '@/api/${moduleName}/${businessName}/model';
import type { VxeGridInstance, VxeGridListeners } from 'vxe-table';

import { nextTick, ref, useTemplateRef } from 'vue';

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

const expandedAll = ref(false);

const gridOptions = withDefaultVxeGridOptions<${BusinessName}>({
    columns,
    height: 'auto',
    keepSource: true,
    pagerConfig: {
        enabled: false,
    },
    proxyConfig: {
        showLoading: false,
        ajax: {
            query: async (_, formValues) => {
                const values = await resolveQueryFormValues(searchFormRef, formValues);
                tableLoading.value = true;
                try {
                    const resp = await ${businessName}List({
                        ...values,
                    });
                    return { rows: resp };
                } finally {
                    tableLoading.value = false;
                }
            },
            // 默认请求接口后展开全部 不需要可以删除这段
            querySuccess: () => {
                nextTick(() => {
                    setExpandOrCollapse(true);
                });
            },
        },
    },
    toolbarConfig: {
        slots: {
            buttons: 'toolbar-left',
            tools: 'toolbar-right',
        },
    },
    /**
     * 虚拟滚动  默认关闭
     */
    scrollY: {
        enabled: false,
        gt: 0,
    },
    rowConfig: {
        keyField: '${pkColumn.javaField}',
    },
    treeConfig: {
        parentField: '${treeParentCode}',
        rowField: '${treeCode}',
        transform: true,
        // showLine: true,
        // showRootLine: false,
    },
    id: '${moduleName}-${businessName}-index',
});

const gridEvents: VxeGridListeners = {
    cellDblclick: (e) => {
        const { row = {} } = e;
        if (!row?.children) {
            return;
        }
        const isExpanded = row?.expand;
        tableRef.value?.setTreeExpand(row, !isExpanded);
        row.expand = !isExpanded;
    },
    // 需要监听使用箭头展开的情况 否则展开/折叠的数据不一致
    toggleTreeExpand: (e) => {
        const { row = {}, expanded } = e;
        row.expand = expanded;
    },
};

const tableRef = useTemplateRef<VxeGridInstance<${BusinessName}>>('tableRef');
const { query, reload } = useTableQuery(searchFormRef, tableRef);

const [${BusinessName}${PopupComponent}, ${popupComponent}Api] = useVben${PopupComponent}({
    connectedComponent: ${businessName}${PopupComponent},
});

function handleAdd() {
    ${popupComponent}Api.setData({ update: false });
    ${popupComponent}Api.open();
}

function handleSubAdd(row: ${BusinessName}) {
    const { ${businessName}Id } = row;
    ${popupComponent}Api.setData({ id: ${businessName}Id, update: false });
    ${popupComponent}Api.open();
}

async function handleEdit(record: ${BusinessName}) {
    ${popupComponent}Api.setData({ id: record.${businessName}Id, update: true });
    ${popupComponent}Api.open();
}

async function handleDelete(row: ${BusinessName}) {
    await ${businessName}Remove(row.${businessName}Id);
    await query();
}

/**
 * 全部展开/折叠
 * @param expand 是否展开
 */
function setExpandOrCollapse(expand: boolean) {
    expandedAll.value = !expand;
    tableRef.value?.setAllTreeExpand(expand);
}

function handleSearchSubmit(data: Record<string, any>) {
    reload(data);
}

function handleSearchReset() {
    reload();
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
                    @submit="handleSearchSubmit"
                    @reset="handleSearchReset"
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
                            <div class="ml-2 text-[13px] text-[#999]">
                                双击展开/收起
                            </div>
                        </template>
                        <template #toolbar-right>
                            <Space>
                                <a-button @click="setExpandOrCollapse(expandedAll)">
                                    全部{{
                                    expandedAll
                                    ? $t('pages.common.expand')
                                    : $t('pages.common.collapse')
                                    }}
                                </a-button>
                                <a-button
                                    type="primary"
                                    v-access:code="['${moduleName}:${businessName}:add']"
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
                                <action-button
                                    variant="link"
                                    color="green"
                                    v-access:code="['${moduleName}:${businessName}:add']"
                                    @click="handleSubAdd(row)"
                                >
                                    {{ $t('pages.common.add') }}
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
