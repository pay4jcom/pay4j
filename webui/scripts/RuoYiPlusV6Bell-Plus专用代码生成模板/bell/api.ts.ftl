import type { ID, IDS, PageQuery, PageResult } from '@/api/common';

import type { ${BusinessName} } from './model';

import { commonExport } from '@/api/helper';
import { alovaInstance } from '@/utils/http';

enum Api {
    ${businessName}Export = '/${moduleName}/${businessName}/export',
    ${businessName}List = '/${moduleName}/${businessName}/list',
    root = '/${moduleName}/${businessName}',
}

/**
* 查询${functionName}列表
* @param params 请求参数
* @returns 列表
*/
export function ${businessName}List(params?: PageQuery) {
    return alovaInstance.get<PageResult<${BusinessName}>>(Api.${businessName}List, { params });
}

/**
* 导出${functionName}excel
* @param data 请求参数
*/
export function ${businessName}Export(data: Partial<${BusinessName}>) {
    return commonExport(Api.${businessName}Export, data);
}

/**
* ${functionName}详情
* @param id id
* @returns 详情
*/
export function ${businessName}Info(id: ID) {
    return alovaInstance.get<${BusinessName}>(<#noparse>`${Api.root}/${id}`</#noparse>);
}

/**
* ${functionName}新增
* @param data 参数
*/
export function ${businessName}Add(data: Partial<${BusinessName}>) {
    return alovaInstance.postWithMsg<void>(Api.root, data);
}

/**
* ${functionName}修改
* @param data 参数
*/
export function ${businessName}Update(data: Partial<${BusinessName}>) {
    return alovaInstance.putWithMsg<void>(Api.root, data);
}

/**
* ${functionName}删除
* @param ids id集合
*/
export function ${businessName}Remove(ids: IDS) {
    return alovaInstance.deleteWithMsg<void>(<#noparse>`${Api.root}/${ids}`</#noparse>);
}
