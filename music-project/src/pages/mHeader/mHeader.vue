<template>
    <div class="m-header">
       <div class="main">
           <div class="logo"></div>
           <div class="tab">
                <router-link tag="div" class="tab-item" to="/music-hall">
                    <span class="tab-link">音乐馆</span>
                </router-link>
                <router-link tag="div" class="tab-item" to="/my-music">
                   <span class="tab-link">我的音乐</span>
                </router-link>
                <router-link tag="div" class="tab-item" to="/music-num">
                    <span class="tab-link">音乐号</span>
                </router-link>
           </div>
           <div class="search">
               <input type="text" placeholder="搜索音乐、MV、歌单、用户">
           </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'm-header',
    data() {
        return {}
    }
}
</script>

<style lang="less" scoped>
@import '../../common/less/mixin.less';
.m-header {
    width: 100%;
    color: #333;
    text-align: center;
    .main {
        width: 1200px;
        height: 90px;
        line-height: 90px;
        margin: 0 auto;
        display: flex;
        align-items: center;
        .logo {
            width: 170px;
            height: 46px;
            background: url('./logo.png');
            background-size: cover;
        }
        .tab {
            display: flex;
            margin-left: 28px;
            margin-right: 42px;
            color: rgba(80, 80, 80, 1);
            cursor: pointer;
            .tab-item {
                width: 94px;
            }
            .router-link-active {
                background-color: rgba(58, 193, 126, 1);
                color: #fff;
            }
        }
        .search {
            input {
                .placeholder(#808080);
                width: 218px;
                height: 36px;
                border: 1px solid rgba(201, 201, 201, 1);
                border-radius: 2px;
                text-indent: 12px;
                outline: none;
            }
        }
    }
}
</style>
