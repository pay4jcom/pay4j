package com.pay4j.common.core.service;

import com.pay4j.common.core.domain.dto.OssDTO;

import java.util.List;

/**
 * 通用 OSS服务
 *
 * @author Pay4j
 */
public interface OssService {

    /**
     * 通过ossId查询对应的url
     *
     * @param ossIds ossId串逗号分隔
     * @return url串逗号分隔
     */
    String selectUrlByIds(String ossIds);

    /**
     * 通过ossId查询列表
     *
     * @param ossIds ossId串逗号分隔
     * @return 列表
     */
    List<OssDTO> selectByIds(String ossIds);
}
