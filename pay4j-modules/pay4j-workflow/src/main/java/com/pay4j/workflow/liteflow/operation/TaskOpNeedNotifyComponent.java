package com.pay4j.workflow.liteflow.operation;

import cn.hutool.core.collection.CollUtil;
import com.yomahub.liteflow.annotation.LiteflowComponent;
import com.yomahub.liteflow.core.NodeBooleanComponent;
import com.pay4j.workflow.common.ConditionalOnEnable;
import com.pay4j.workflow.domain.context.TaskOperationContext;

/**
 * 判断任务操作后是否进入消息通知分支。
 *
 * @author may
 */
@ConditionalOnEnable
@LiteflowComponent("taskOpNeedNotify")
public class TaskOpNeedNotifyComponent extends NodeBooleanComponent {

    @Override
    public boolean processBoolean() {
        TaskOperationContext context = getContextBean(TaskOperationContext.class);
        return context.isResult() && CollUtil.isNotEmpty(context.getTaskOperationBo().getMessageType());
    }

}
