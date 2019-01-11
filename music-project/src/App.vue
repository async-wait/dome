<template>
  <div id="app">
    <m-header></m-header>
    <router-view></router-view>
  </div>
</template>

<script>
import mHeader from '@/pages/mHeader/mHeader';

export default {
    components: {
      mHeader
    }
}
</script>

<style>

</style>
