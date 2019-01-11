<template>
    <div class="tab">
        <router-link tag="div" class="tab-item" to="/find-music">
            <span class="tab-link">发现音乐</span>
        </router-link>
        <router-link tag="div" class="tab-item" to="/my-music">
            <span class="tab-link">我的</span>
        </router-link>
        <router-link tag="div" class="tab-item" to="/friend">
            <span class="tab-link">朋友</span>
        </router-link>
        <router-link tag="div" class="tab-item" to="/personal">
            <span class="tab-link">账号</span>
        </router-link>
    </div>
</template>

<script>
    export default {}
</script>

<style scoped lang="less">
    @import '../common/less/variable.less';
    @import '../common/less/mixin.less';
    .tab{
        display: flex;
        .px2rem(height,88);
        .px2rem(line-height,88);
        .font-size(@font-size-medium);
        .tab-item{
            flex: 1;
            text-align: center;
            .tab-link{
                .px2rem(padding-bottom,5);
                color: @color-text-l;
            }
            &.router-link-active .tab-link{
                color: @color-theme;
                border-bottom: 2px solid @color-theme;
            }
        }
    }
</style>

