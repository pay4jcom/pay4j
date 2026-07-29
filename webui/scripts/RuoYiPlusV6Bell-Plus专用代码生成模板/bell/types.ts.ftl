export interface ${BusinessName} {
<#list columns as column>
    <#if column.list>
    /**
    * ${column.columnComment}
    */
    ${column.javaField}: ${column.tsType};
    </#if>
</#list>
<#if table.tree>
    /**
    * 子对象
    */
    children: ${BusinessName}[];
</#if>
}
