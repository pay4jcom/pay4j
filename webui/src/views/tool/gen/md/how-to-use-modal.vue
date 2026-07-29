<script setup lang="ts">
import { useVbenModal } from '@/components';

import gen1 from './gen-1.png';
import gen2 from './gen-2.png';

const [Modal] = useVbenModal({
  title: '如何使用代码生成模板',
  fullscreenButton: false,
  footer: false,
});
</script>

<template>
  <Modal :width="700">
    <div class="p-4">
      <div class="mb-4 text-lg font-bold text-red-500">
        后端RuoYi-Vue-Plus V6，BELL代码生成模板专用，与以往版本不兼容
      </div>
      <div class="mb-4 text-lg font-bold text-blue-500">
        脚本位于 /scripts/RuoYiPlusV6Bell-Plus专用代码生成模板,请自行复制
      </div>
      <div class="flex flex-wrap items-center">
        <div>
          <div class="mb-4 text-lg font-bold">1.复制模板文件</div>
          <img :src="gen1" alt="示例图片" class="mb-4 h-72" />
        </div>
        <div class="pl-5">
          <div class="mb-4 text-lg font-bold">
            2.替换java文件/自行比对修改代码
          </div>
          <img :src="gen2" alt="示例图片" class="mb-4 h-72" />
        </div>
      </div>
      <div class="mb-4 text-lg font-bold">3.重启后端</div>
      <div class="mb-4 text-lg font-bold">4.预览/生成</div>
    </div>
  </Modal>
</template>
