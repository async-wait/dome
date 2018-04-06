<template>
  <div id="app">
    <m-header></m-header>
    <tab></tab>
    <!-- keepAlive能让组件的信息得到缓存 -->
    <keep-alive>
      <router-view></router-view>
    </keep-alive>
    <player></player>
  </div>
</template>

<script>
// 导入各部分组件
import mHeader from '@/components/mHeader/mHeader'
import Tab from '@/components/tab/tab'
import Player from '@/components/player/player'


export default {
    components: {
      mHeader,
      Tab,
      Player
    }
}
</script>

<style>

</style>
