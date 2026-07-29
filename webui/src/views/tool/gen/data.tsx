import type { VxeGridProps } from 'vxe-table';

export const columns: VxeGridProps['columns'] = [
  {
    type: 'checkbox',
    width: 45,
    align: 'center',
    resizable: false,
  },
  {
    field: 'tableName',
    title: '表名称',
    minWidth: 180,
    showOverflow: true,
  },
  {
    field: 'className',
    title: '实体类',
    minWidth: 180,
    showOverflow: true,
  },
  {
    field: 'tableComment',
    title: '表描述',
    minWidth: 210,
    showOverflow: true,
  },
  {
    field: 'createTime',
    title: '创建时间',
    width: 150,
    align: 'center',
    resizable: false,
  },
  {
    field: 'updateTime',
    title: '更新时间',
    width: 150,
    align: 'center',
    resizable: false,
  },
  {
    field: 'action',
    fixed: 'right',
    slots: { default: 'action' },
    title: '操作',
    resizable: false,
    align: 'center',
    width: 'auto',
  },
];

export const iconMap = [
  {
    key: 'java',
    value: <span class="icon-[fluent--document-java-20-regular] size-5"></span>,
  },
  { key: 'xml', value: <span class="icon-[bi--filetype-xml] size-5"></span> },
  { key: 'sql', value: <span class="icon-[ph--file-sql] size-5"></span> },
  { key: 'ts', value: <span class="icon-[ph--file-ts] size-5"></span> },
  { key: 'vue', value: <span class="icon-[ph--file-vue] size-5"></span> },
  {
    key: 'folder',
    value: <span class="icon-[tdesign--folder-open-1] size-5"></span>,
  },
];

export const defaultFileIcon = (
  <span class="icon-[tdesign--file-code-1] size-5"></span>
);
export const defaultFolderIcon = (
  <span class="icon-[tdesign--folder-open-1] size-5"></span>
);
