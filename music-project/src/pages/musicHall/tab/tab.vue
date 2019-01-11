<template>
    <div class="tab-wp">
        <div class="tab">
            <router-link tag="div" class="tab-item" to="index">
                <span class="tab-link">首页</span>
            </router-link>
            <router-link tag="div" class="tab-item" to="singer">
                <span class="tab-link">歌手</span>
            </router-link>
            <router-link tag="div" class="tab-item" to="album">
                <span class="tab-link">专辑</span>
            </router-link>
            <router-link tag="div" class="tab-item" to="ranking">
                <span class="tab-link">排行榜</span>
            </router-link>
            <router-link tag="div" class="tab-item" to="category">
                <span class="tab-link">分类歌单</span>
            </router-link>
            <router-link tag="div" class="tab-item" to="radio">
                <span class="tab-link">电台</span>
            </router-link>
            <router-link tag="div" class="tab-item" to="mv">
                <span class="tab-link">MV</span>
            </router-link>
            <router-link tag="div" class="tab-item" to="album-num">
                <span class="tab-link">数字专辑</span>
            </router-link>
        </div>
    </div>
</template>

<script>
export default {
    name: 'tab'
}
</script>

<style lang="less" scoped>
.tab-wp {
    width: 100%;
    text-align: center;
    .tab {
        width: 1200px;
        display: flex;
        margin: 0 auto;
        .tab-item {
            width: 80px;
            height: 52px;
            line-height: 52px;
            font-size: 15px;
            color: rgba(80, 80, 80, 1);
            cursor: pointer;
            &:nth-of-type(1) {
                margin-left: 200px;
            }
            &.router-link-active {
                color: rgba(58, 193, 126, 1);
            }
        }
    }
}
</style>
