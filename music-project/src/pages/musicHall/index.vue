<template>
    <div class="music-hall">
        <tab></tab>
        <router-view></router-view>
    </div>
</template>

<script>
import Tab from './tab/tab';
export default {
    name: 'music-hall',
    components: {
        Tab
    }
}
</script>

<style lang="less" scoped>
    .music-hall {
        color: #000;
    }
</style>

