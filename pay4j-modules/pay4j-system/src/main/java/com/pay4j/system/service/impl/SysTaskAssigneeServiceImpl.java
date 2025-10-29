package com.pay4j.system.service.impl;

import cn.hutool.core.convert.Convert;
import lombok.RequiredArgsConstructor;
import com.pay4j.common.core.constant.SystemConstants;
import com.pay4j.common.core.domain.dto.TaskAssigneeDTO;
import com.pay4j.common.core.domain.model.TaskAssigneeBody;
import com.pay4j.common.core.service.TaskAssigneeService;
import com.pay4j.common.mybatis.core.page.PageQuery;
import com.pay4j.common.mybatis.core.page.TableDataInfo;
import com.pay4j.system.domain.bo.SysDeptBo;
import com.pay4j.system.domain.bo.SysPostBo;
import com.pay4j.system.domain.bo.SysRoleBo;
import com.pay4j.system.domain.bo.SysUserBo;
import com.pay4j.system.domain.vo.SysDeptVo;
import com.pay4j.system.domain.vo.SysPostVo;
import com.pay4j.system.domain.vo.SysRoleVo;
import com.pay4j.system.domain.vo.SysUserVo;
import com.pay4j.system.service.ISysDeptService;
import com.pay4j.system.service.ISysPostService;
import com.pay4j.system.service.ISysRoleService;
import com.pay4j.system.service.ISysUserService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 工作流设计器获取任务执行人
 *
 * @author Pay4j
 */
@RequiredArgsConstructor
@Service
public class SysTaskAssigneeServiceImpl implements TaskAssigneeService {

    // 上级Service注入下级Service 其他Service永远不可能注入当前类 避免循环注入
    private final ISysPostService postService;
    private final ISysDeptService deptService;
    private final ISysUserService userService;
    private final ISysRoleService roleService;

    /**
     * 查询角色并返回任务指派的列表，支持分页
     *
     * @param taskQuery 查询条件
     * @return 办理人
     */
    @Override
    public TaskAssigneeDTO selectRolesByTaskAssigneeList(TaskAssigneeBody taskQuery) {
        PageQuery pageQuery = new PageQuery(taskQuery.getPageSize(), taskQuery.getPageNum());
        SysRoleBo bo = new SysRoleBo();
        bo.setRoleKey(taskQuery.getHandlerCode());
        bo.setRoleName(taskQuery.getHandlerName());
        bo.setStatus(SystemConstants.NORMAL);
        Map<String, Object> params = bo.getParams();
        params.put("beginTime", taskQuery.getBeginTime());
        params.put("endTime", taskQuery.getEndTime());
        TableDataInfo<SysRoleVo> page = roleService.selectPageRoleList(bo, pageQuery);
        // 使用封装的字段映射方法进行转换
        List<TaskAssigneeDTO.TaskHandler> handlers = TaskAssigneeDTO.convertToHandlerList(page.getRows(),
            item -> Convert.toStr(item.getRoleId()), SysRoleVo::getRoleKey, SysRoleVo::getRoleName, item -> "", SysRoleVo::getCreateTime);
        return new TaskAssigneeDTO(page.getTotal(), handlers);
    }

    /**
     * 查询岗位并返回任务指派的列表，支持分页
     *
     * @param taskQuery 查询条件
     * @return 办理人
     */
    @Override
    public TaskAssigneeDTO selectPostsByTaskAssigneeList(TaskAssigneeBody taskQuery) {
        PageQuery pageQuery = new PageQuery(taskQuery.getPageSize(), taskQuery.getPageNum());
        SysPostBo bo = new SysPostBo();
        bo.setPostCategory(taskQuery.getHandlerCode());
        bo.setPostName(taskQuery.getHandlerName());
        bo.setStatus(SystemConstants.NORMAL);
        Map<String, Object> params = bo.getParams();
        params.put("beginTime", taskQuery.getBeginTime());
        params.put("endTime", taskQuery.getEndTime());
        bo.setBelongDeptId(Convert.toLong(taskQuery.getGroupId()));
        TableDataInfo<SysPostVo> page = postService.selectPagePostList(bo, pageQuery);
        // 使用封装的字段映射方法进行转换
        List<TaskAssigneeDTO.TaskHandler> handlers = TaskAssigneeDTO.convertToHandlerList(page.getRows(),
            item -> Convert.toStr(item.getPostId()), SysPostVo::getPostCategory, SysPostVo::getPostName, item -> Convert.toStr(item.getDeptId()), SysPostVo::getCreateTime);
        return new TaskAssigneeDTO(page.getTotal(), handlers);
    }

    /**
     * 查询部门并返回任务指派的列表，支持分页
     *
     * @param taskQuery 查询条件
     * @return 办理人
     */
    @Override
    public TaskAssigneeDTO selectDeptsByTaskAssigneeList(TaskAssigneeBody taskQuery) {
        PageQuery pageQuery = new PageQuery(taskQuery.getPageSize(), taskQuery.getPageNum());
        SysDeptBo bo = new SysDeptBo();
        bo.setDeptCategory(taskQuery.getHandlerCode());
        bo.setDeptName(taskQuery.getHandlerName());
        bo.setStatus(SystemConstants.NORMAL);
        Map<String, Object> params = bo.getParams();
        params.put("beginTime", taskQuery.getBeginTime());
        params.put("endTime", taskQuery.getEndTime());
        bo.setBelongDeptId(Convert.toLong(taskQuery.getGroupId()));
        TableDataInfo<SysDeptVo> page = deptService.selectPageDeptList(bo, pageQuery);
        // 使用封装的字段映射方法进行转换
        List<TaskAssigneeDTO.TaskHandler> handlers = TaskAssigneeDTO.convertToHandlerList(page.getRows(),
            item -> Convert.toStr(item.getDeptId()), SysDeptVo::getDeptCategory, SysDeptVo::getDeptName, item -> Convert.toStr(item.getParentId()), SysDeptVo::getCreateTime);
        return new TaskAssigneeDTO(page.getTotal(), handlers);
    }

    /**
     * 查询用户并返回任务指派的列表，支持分页
     *
     * @param taskQuery 查询条件
     * @return 办理人
     */
    @Override
    public TaskAssigneeDTO selectUsersByTaskAssigneeList(TaskAssigneeBody taskQuery) {
        PageQuery pageQuery = new PageQuery(taskQuery.getPageSize(), taskQuery.getPageNum());
        SysUserBo bo = new SysUserBo();
        bo.setUserName(taskQuery.getHandlerCode());
        bo.setNickName(taskQuery.getHandlerName());
        bo.setStatus(SystemConstants.NORMAL);
        Map<String, Object> params = bo.getParams();
        params.put("beginTime", taskQuery.getBeginTime());
        params.put("endTime", taskQuery.getEndTime());
        bo.setDeptId(Convert.toLong(taskQuery.getGroupId()));
        TableDataInfo<SysUserVo> page = userService.selectPageUserList(bo, pageQuery);
        // 使用封装的字段映射方法进行转换
        List<TaskAssigneeDTO.TaskHandler> handlers = TaskAssigneeDTO.convertToHandlerList(page.getRows(),
            item -> Convert.toStr(item.getUserId()), SysUserVo::getUserName, SysUserVo::getNickName, item -> Convert.toStr(item.getDeptId()), SysUserVo::getCreateTime);
        return new TaskAssigneeDTO(page.getTotal(), handlers);
    }

}
