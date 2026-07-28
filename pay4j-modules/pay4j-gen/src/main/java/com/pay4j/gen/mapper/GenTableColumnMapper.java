package com.pay4j.gen.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import com.pay4j.common.mybatis.core.mapper.BaseMapperPlus;
import com.pay4j.gen.domain.GenTableColumn;

/**
 * 业务字段 数据层
 *
 * @author Lion Li
 */
@InterceptorIgnore(dataPermission = "true", tenantLine = "true")
public interface GenTableColumnMapper extends BaseMapperPlus<GenTableColumn, GenTableColumn> {

}
