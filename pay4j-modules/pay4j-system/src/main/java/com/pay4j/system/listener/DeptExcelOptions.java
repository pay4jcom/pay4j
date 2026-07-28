package com.pay4j.system.listener;

import cn.hutool.core.lang.tree.Tree;
import lombok.RequiredArgsConstructor;
import com.pay4j.common.core.utils.SpringUtils;
import com.pay4j.common.core.utils.TreeBuildUtils;
import com.pay4j.common.excel.core.ExcelOptionsProvider;
import com.pay4j.system.domain.bo.SysDeptBo;
import com.pay4j.system.service.ISysDeptService;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Set;

/**
 * Excel 部门下拉选项数据源
 *
 * @author AprilWind
 */
@Component
@RequiredArgsConstructor
public class DeptExcelOptions implements ExcelOptionsProvider {

    /**
     * 获取下拉选项数据
     *
     * @return 下拉选项列表
     */
    @Override
    public Set<String> getOptions() {
        ISysDeptService deptService = SpringUtils.getBean(ISysDeptService.class);
        List<Tree<Long>> trees = deptService.selectDeptTreeList(new SysDeptBo());
        return TreeBuildUtils.buildTreeNodeMap(trees, "/", Tree::getName).keySet();
    }

}
