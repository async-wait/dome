<template>
    <div class="tab">
        <router-link tag="div" class="tab-item" to="/recommend">
            <span class="tab-link">推荐</span>
        </router-link>
        <router-link tag="div" class="tab-item" to="/singer">
            <span class="tab-link">歌手</span>
        </router-link>
        <router-link tag="div" class="tab-item" to="/rank">
            <span class="tab-link">排行</span>
        </router-link>
        <router-link tag="div" class="tab-item" to="/search">
            <span class="tab-link">搜索</span>
        </router-link>
    </div>
</template>

<script>
    export default {}
</script>

<style scoped lang="less">
    @import '../../common/less/variable.less';
    @import '../../common/less/mixin.less';
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

