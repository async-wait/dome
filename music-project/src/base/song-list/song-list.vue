<template>
    <div class="song-list">
        <ul>
            <li v-for="item in songs" class="item">
                <div class="content">
                    <h2 class="name">{{item.name}}</h2>
                    <p class="dasc">{{item | getDasc}}</p>
                </div>
            </li>
        </ul>
    </div>
</template>

<script>
export default {
    props: {
        songs: {
            type: Array,
            default: []
        }
    },
    filters:{
        getDasc(item){
            return `${item.singer} - ${item.album}`
        }
    }
}
</script>

<style lang="less" scoped>
    @import "../../common/less/variable.less";
    @import "../../common/less/mixin.less";

    .song-list{
        .item{
            display: flex;
            align-items: center;
            box-sizing: border-box;
            .px2rem(height, 128);
            .font-size(@font-size-medium);
            .rank{
                .px2rem(flex-shrink, 0);
                .px2rem(flex-basis, 50);
                text-align: center;
                .px2rem(width, 50);
                .px2rem(margin-right, 60);
                .icon{
                    display: inline-block;
                    .px2rem(width, 50);
                    .px2rem(height, 48);
                    .background-size(50, 48);
                    &.icon0{
                        .bg-image('first')
                    }
                    &.icon1{
                        .bg-image('second')
                    }
                    &.icon2{
                        .bg-image('third')
                    }
                }
                .text{
                    color: @color-theme;
                    .font-size(@font-size-large);
                }
            }
            .content{
                flex: 1;
                .px2rem(line-height, 40);
                overflow: hidden;
                .name{
                    .ellipsis();
                    color: @color-text;
                }
                .desc{
                    .ellipsis();
                    .px2rem(margin-top, 8);
                    color: @color-text-d;
                }
            }   
        }
    }
</style>


