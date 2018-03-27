<template>
    <div class="recommend">
        <scroll class="recommend-content" :data="discList" ref="scrollContain">
            <div>
                <div v-if="recommend.length" class="slider-wrapper">
                    <slider>
                        <div v-for=" item in recommend">
                            <a :href="item.linkUrl">
                                <img :src="item.picUrl" alt="" @load="loadImage">
                            </a>
                        </div>
                    </slider>
                </div>
                <div class="recommend-list">
                    <h2 class="list-title">热门推荐歌单</h2>
                    <ul>
                        <li v-for="item in discList" class="item">
                            <div class="icon">
                                <img  alt="" v-lazy="item.imgurl">
                            </div>
                            <div class="text">
                                <h1 class="name" v-html="item.creator.name"></h1>
                                <p class="dasc" v-html="item.dissname"></p>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="loading-container" v-show="!discList.length">
                <loading></loading>
            </div>
        </scroll>
    </div>
</template>

<script>
    import Loading from 'base/loading/loading'
    import Scroll from 'base/scroll/scroll'
    import Slider from 'base/slider/slider'
    import { getRecommend, getDiscList } from "api/recommend"
    import { ERR_OK } from 'api/config';
    export default {
        data(){
            return {
                recommend: [],
                // 热门推荐的数据
                discList: []
            }
        },
        created(){
            this._getRecommend();
            this._getDiscList();
        },
        methods: {
            // 调用这个接口获取轮播图数据
            _getRecommend(){
                getRecommend().then((res) => {
                    if(res.code === ERR_OK){
                        this.recommend = res.data.slider;
                    }
                });
            },
            // 获取歌单数据
            _getDiscList(){
                getDiscList().then( res => {
                    if(res.code === ERR_OK){
                        this.discList = res.data.list;
                    }
                });
            },
            loadImage(){
                // 图片loading以后，better-scroll重新计算
                // 这里加判断为了防止refresh（），多次执行
                if(!this.checkLoad){
                    this.$refs.scrollContain.refresh();
                    this.checkLoad = true;
                }
            }
        },
        components: {
            Slider,
            Scroll,
            Loading
        }
    }
</script>

<style scoped lang="less">
    @import "../../common/less/variable.less";
    @import "../../common/less/mixin.less";

  .recommend{
        position: fixed;
        width: 100%;
        .px2rem(top, 176);
        bottom: 0;
        .recommend-content{
            height: 100%;
            overflow: hidden;
            .slider-wrapper{
                position: relative;
                width: 100%;
                overflow: hidden;
            }
            .recommend-list{
                .list-title{
                    .px2rem(height,130);
                    .px2rem(line-height,130);
                    text-align: center;
                    font-size: @font-size-medium;
                    color: @color-theme;
                }
                .item{
                    display: flex;
                    box-sizing: border-box;
                    align-items: center;
                    .padding(0, 40, 40, 40);
                    .icon{
                        flex-grow: 0;
                        flex-shrink: 0;
                        .px2rem(flex-basis,60);
                        .px2rem(width,120);
                        .px2rem(padding-right,40);
                        img{
                            .px2rem(width,120);
                            .px2rem(height,120);
                            display: inline-block;
                        }
                    }
                    .text{
                        display: flex;
                        flex-direction: column;
                        justify-content: center;
                        flex: 1;
                        .px2rem(line-height,40);
                        overflow: hidden;
                        font-size: @font-size-medium;
                        .name{
                            .px2rem(margin-bottom,20);
                            color: @color-text; 
                        }
                        .desc{
                            color: @color-text-d
                        }
                    }
                }
            }
            .loading-container{
                position: absolute;
                width: 100%;
                top: 50%;
            }
        }
  }
</style>

