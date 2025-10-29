package com.pay4j.generator.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import com.pay4j.common.mybatis.core.mapper.BaseMapperPlus;
import com.pay4j.generator.domain.GenTableColumn;

/**
 * 业务字段 数据层
 *
 * @author Pay4j
 */
@InterceptorIgnore(dataPermission = "true", tenantLine = "true")
public interface GenTableColumnMapper extends BaseMapperPlus<GenTableColumn, GenTableColumn> {

}
