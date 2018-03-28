<template>
    <transition name="slider">
        <div class="singer-detail">

        </div>
    </transition>
</template>

<script>
    
</script>

<style lang="less" scoped>
    @import "../../common/less/variable.less";
    @import "../../common/less/mixin.less";
    .singer-detail{
        position: fixed;
        z-index: 100;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        background: @color-background;
    }
    .slider-enter-active, .slider-leave-active{
        transition: all .5s
    }
    .slider-enter, .slider-leave-to{
        transform: translate3d(100%, 0, 0)
    }
</style>

