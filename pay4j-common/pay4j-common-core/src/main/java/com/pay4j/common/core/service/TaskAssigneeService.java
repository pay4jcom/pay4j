package com.pay4j.common.core.service;

import com.pay4j.common.core.domain.dto.TaskAssigneeDTO;
import com.pay4j.common.core.domain.model.TaskAssigneeBody;

/**
 * 工作流设计器获取任务执行人
 *
 * @author Pay4j
 */
public interface TaskAssigneeService {

    /**
     * 查询角色并返回任务指派的列表，支持分页
     *
     * @param taskQuery 查询条件
     * @return 办理人
     */
    TaskAssigneeDTO selectRolesByTaskAssigneeList(TaskAssigneeBody taskQuery);

    /**
     * 查询岗位并返回任务指派的列表，支持分页
     *
     * @param taskQuery 查询条件
     * @return 办理人
     */
    TaskAssigneeDTO selectPostsByTaskAssigneeList(TaskAssigneeBody taskQuery);

    /**
     * 查询部门并返回任务指派的列表，支持分页
     *
     * @param taskQuery 查询条件
     * @return 办理人
     */
    TaskAssigneeDTO selectDeptsByTaskAssigneeList(TaskAssigneeBody taskQuery);

    /**
     * 查询用户并返回任务指派的列表，支持分页
     *
     * @param taskQuery 查询条件
     * @return 办理人
     */
    TaskAssigneeDTO selectUsersByTaskAssigneeList(TaskAssigneeBody taskQuery);

}
