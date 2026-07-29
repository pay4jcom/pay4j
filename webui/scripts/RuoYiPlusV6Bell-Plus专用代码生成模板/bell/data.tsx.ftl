import type { VxeGridProps } from 'vxe-table';

<#if dicts?has_content>
import { getDictOptions } from '#/utils/dict';
import { renderDict } from '@/utils/render';
</#if>

export const columns: VxeGridProps['columns'] = [
<#if tplCategory != 'tree'>
    {
        align: 'center',
        type: 'checkbox',
        resizable: false,
        width: 45,
    },
</#if>
<#list columns as column>
    <#if column.list>
        <#assign dictType = column.dictType!'' />
        <#assign parentheseIndex = column.columnComment?index_of("（") />
        <#if parentheseIndex != -1>
            <#assign comment = column.columnComment?substring(0, parentheseIndex) />
        <#else>
            <#assign comment = column.columnComment />
        </#if>
    {
        <#if column.javaField?contains('Time')>
        title: '${comment}',
        field: '${column.javaField}',
        align: 'center',
        resizable: false,
        width: 160,
        <#elseif column.javaField?contains('Status')>
        title: '${comment}',
        field: '${column.javaField}',
        align: 'center',
        resizable: false,
        width: 80,
        <#else>
        title: '${comment}',
        field: '${column.javaField}',
        minWidth: 160,
        </#if>
        <#if column?counter == 1 && tplCategory == 'tree'>
        treeNode: true,
        </#if>
        <#if dictType?has_content>
        slots: {
            default: ({ row }) => {
            // 可选从DictEnum中获取 DictEnum.${dictType?upper_case} 便于维护
            return renderDict(row.${column.javaField}, '${dictType}');
            },
        },
        </#if>
        },
    </#if>
</#list>
    {
        field: 'action',
        fixed: 'right',
        slots: { default: 'action' },
        title: '操作',
        resizable: false,
        align: 'center',
        width: 'auto',
    },
];
