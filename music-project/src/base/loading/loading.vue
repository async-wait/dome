<template>
    <div class="loading">
        <img src="./loading.gif" alt="">
        <p class="dasc">{{title}}</p>
    </div>
</template>

<script>
    export default {
        props: {
            title: {
                type: String,
                default: "正在加载..."
            }
        }
    }    
</script>

<style lang="less" scoped> 
    @import "../../common/less/variable.less";
    @import "../../common/less/mixin.less";
    .loading{    
        width: 100%;
        text-align: center;
        img{
            .px2rem(width,48);
            .px2rem(height,48);
            display: inline-block;
            .px2rem(margin-bottom, 10);
        }
        .dasc{
            .px2rem(line-height,20);
            font-size: @font-size-small;
            color: @color-text-l;
        }
    } 
</style>

