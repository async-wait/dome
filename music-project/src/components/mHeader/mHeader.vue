<template>
    <div class="m-header">
        <div class="icon"></div>
        <h1 class="text">Water music</h1>
        <router-link tag="div" class="mine" to="/user">
            <i class="icon-mine"></i>
        </router-link>
    </div>
</template>
<script>
    export default {
        name: 'mHeader'
    }
</script>
<style scoped lang="less">
    @import '../../common/less/variable.less';
    @import '../../common/less/mixin.less';
    .m-header{
        position: relative;
        .px2rem(height,88);
        text-align: center;
        font-size: 0;
        h1{
            color: #ffcd32;
        }
        .text{
            display: inline-block;
            vertical-align: top;
            .px2rem(line-height,88);
            .font-size(@font-size-large);
        }
        .icon{
            display: inline-block;
            vertical-align: top;
            .px2rem(margin-top,12);
            .px2rem(width,60);
            .px2rem(height,64);
            .px2rem(margin-right,18);
            .bg-image('logo');
            background-size: 100% 100%;
        }
        .mine{
            position: absolute;
            top: 0;
            right: 0;
            .icon-mine{
                display: block;
                .px2rem(padding,24);
                .font-size(40);
                color: @color-theme;
            }
        }
    }
</style>


