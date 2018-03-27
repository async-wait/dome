<template>
    <scroll class="listview" :data="data" ref="listview">
        <ul>
            <li class="list-group" v-for="group in data" ref="listGroup">
                <h2 class="list-group-title">{{group.title}}</h2>
                <ul>
                    <li class="list-group-item" v-for="item in group.items">
                        <img class="avatar" v-lazy="item.avatar" alt="">
                        <span class="name">{{item.name}}</span>
                    </li>
                </ul>
            </li>
        </ul>
        <div 
            class="list-shortcut"
            @touchstart="onTouchStart"
            @touchmove.stop.prevent="onTouchMove">
            <ul>
                <li 
                    class="item"
                    v-for="(item, index) in shortcutList"  
                    :data-index="index" 
                    ref="item">
                    {{item}}
                </li>
            </ul>
        </div>
    </scroll>
</template>

<script>
    import Scroll from 'base/scroll/scroll'
    import { getData } from 'common/js/dom'
    


    export default {
        created(){
            this.touch = {}
        },
        props: {
            data: {
                type: Array,
                default: []
            }
        },
        methods: {
            // 监听触摸开始事件touchstart
            onTouchStart(e){
                let touchStartIndex = getData(e.target, 'index');


                // 先记录刚开始触摸的时候的pageY的距离
                let firstTouch = e.touches[0]
                this.touch.y1 = firstTouch.pageY
                // 移动开始的时候，y轴刚开始下标索引
                // 这里的this.touch.touchMouveNum类型是字符串
                this.touch.touchMoveNum = touchStartIndex


                this._scrollTo(touchStartIndex);                
            },
            onTouchMove(e){
                let firstTouch = e.touches[0]
                this.touch.y2 = firstTouch.pageY
                // y轴上的偏移
                let delta = (this.touch.y2 - this.touch.y1)/this.$refs.item[0].offsetHeight | 0;

                // 结束时候的下标索引，这里需要把this.touch.touchMouveNum转换成数字类型
                let achorIndex = parseInt(this.touch.touchMoveNum) + delta;
                this._scrollTo(achorIndex); 
            },
            _scrollTo(index){
                this.$refs.listview.scrollToElement(this.$refs.listGroup[index],0);
            }

        },
        computed: {
            shortcutList(){
                return this.data.map((item) => item.title.substr(0,1))
            }
        },
        components: {
            Scroll
        }
    }
</script>

<style lang="less" scoped>
    @import "../../common/less/variable.less";
    @import "../../common/less/mixin.less";


    .listview{
        position: relative;
        width: 100%;
        height: 100%;
        overflow: hidden;
        background: @color-background;
        .list-group{
            .px2rem(padding-bottom,60);
            .list-group-title{
                .px2rem(height,60);
                .px2rem(line-height,60);
                .px2rem(padding-left,40);
                .font-size(@font-size-small);
                color: @color-text-l;
                background: @color-highlight-background;
            }
            .list-group-item{
                display: flex;
                align-items: center;
                .padding(40, 0, 0, 60);
                .avatar{
                    .px2rem(width,100);
                    .px2rem(height,100);
                    border-radius: 50%;
                    -webkit-border-radius: 50%;
                }
                .name{
                    .px2rem(margin-left, 40);
                    color: @color-text-l;
                    .font-size(@font-size-medium);
                }
            }
        }
        .list-shortcut{
            position: absolute;
            z-index: 30;
            right: 0;
            top: 50%;
            transform: translateY(-50%);
            .px2rem(width, 40);
            .padding(40, 0, 40, 0);
            .border-radius(20);
            text-align: center;
            background: @color-background-d;
            font-family: Helvetica;
            .item{
                .padding(6, 6, 6, 6);
                line-height: 1;
                color: @color-text-l;
                .font-size(@font-size-small);
                &.current{
                    color: @color-theme;
                }
            }
        }
        .list-fixed{
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            .fixed-title{
                .px2rem(height, 60);
                .px2rem(line-height, 60);
                .px2rem(padding-left, 40);
                .font-size(@font-size-small);
                color: @color-text-l;
                background: @color-highlight-background;
            }
        }
        .loading-container{
            position: absolute;
            width: 100%;
            top: 50%;
            transform: translateY(-50%);
        }
    }
</style>
