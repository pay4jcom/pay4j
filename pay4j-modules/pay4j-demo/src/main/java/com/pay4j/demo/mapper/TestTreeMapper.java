package com.pay4j.demo.mapper;

import com.pay4j.common.mybatis.annotation.DataColumn;
import com.pay4j.common.mybatis.annotation.DataPermission;
import com.pay4j.common.mybatis.core.mapper.BaseMapperPlus;
import com.pay4j.demo.domain.TestTree;
import com.pay4j.demo.domain.vo.TestTreeVo;

/**
 * 测试树表Mapper接口
 *
 * @author Pay4j
 * @date 2021-07-26
 */
@DataPermission({
    @DataColumn(key = "deptName", value = "dept_id"),
    @DataColumn(key = "userName", value = "user_id")
})
public interface TestTreeMapper extends BaseMapperPlus<TestTree, TestTreeVo> {

}
