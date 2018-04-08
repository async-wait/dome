<template>
    <div class="music-list">
        <div class="back" @click="back">
            <i class="icon-back"></i>
        </div>
        <h1 class="title" v-html="title" ref="titleHeight"></h1>
        <div class="bg-image" 
             :style="bgStyle" 
             ref="backgroundImage" 
             style="position:relative"
        >
            <div class="play-wrapper" v-show="songs.length > 0" ref="playWrapper">
                <div class="play">
                    <i class="icon-play"></i>
                    <span class="text">随机播放</span>
                </div>
            </div>
            <div class="filter" ref="filter"></div>
        </div>
        <div class="bg-layer" ref="bgLayer"></div>
        <scroll :data="songs" 
                class="list" 
                ref="list"
                :probe-type="probeType"
                :listen-scroll="listenScroll"
                @scroll="scroll"
        >
            <div class="song-list-wrapper">
                <song-list :songs="songs" @select="selectItem"></song-list>
            </div>

            <!-- 
                loading组件
             -->
             <div class="loading-container" v-show="!songs.length">
                 <loading></loading>
             </div>
        </scroll>
    </div>
</template>

<script>
    import Scroll from 'base/scroll/scroll'
    import SongList from 'base/song-list/song-list'
    import { prefixStyle }  from 'common/js/dom'
    import Loading from 'base/loading/loading'
    import { mapActions, mapGetters } from 'vuex'

    const transform = prefixStyle('transform')
    const backdropFilter = prefixStyle('backdrop-filter')

    export default {
        props: {
            bgImage: {
                type: String,
                default: ''
            },
            title: {
                type: String,
                default: ''
            },
            songs: {
                type: Array,
                default: ''
            }
        },
        data(){
            return {
                scrollY: 0
            }
        },
        created(){
            this.probeType = 3
            this.listenScroll = true
        },
        mounted(){
            // 该组件加载完以后，获取标题的高度
            this.reservedHeight = this.$refs.titleHeight.clientHeight

            // ref在子组件上，this.$refs.el则获取子组件信息。通过this.$refs.el.$el获取子组件dom node
            // ref如果在dom元素上，this.$refs.el直接获取的就是 dom node
            this.imageHeight = this.$refs.backgroundImage.clientHeight
            // 详情页面bg-layer向上滚动的高度
            this.minTranslateY = -this.imageHeight + this.reservedHeight
            this.$refs.list.$el.style.top = `${this.imageHeight}px` 
        },
        methods: {
            scroll(pos){
                this.scrollY = pos.y
            },
            // 返回按钮
            back(){
                this.$router.back();
            },
            selectItem(item, index){
                this.selectPlay({
                    list: this.songs,
                    index
                });
                console.log(this.currentSong);
            },
            ...mapActions([
                'selectPlay'
            ])
        },
        computed: {
            bgStyle(){
                return `background-image:url(${this.bgImage})`
            },
            ...mapGetters([
                'fullScreen',
                'playlist',
                'currentSong'
            ])
        },
        watch: {
            scrollY(newY){
                let translateY = Math.max(this.minTranslateY, newY)
                let zIndex = 0
                let scale = 1
                let blur = 0
                const percent = Math.abs(newY / this.imageHeight)

                if(newY > 0){
                    scale = percent + 1
                    zIndex = 10
                }else{
                    // 向上滚动添加高斯模糊，向上滚动，Y值变小
                    blur = Math.min(20 * percent, 20)
                }
                // 给歌手的遮罩做一个高斯模糊
                this.$refs.filter.style[backdropFilter] = `blur(${blur}px)`

                this.$refs.bgLayer.style[transform] = `translate3d(0, ${ translateY }px, 0)`
                if(newY < this.minTranslateY){
                    zIndex = 10
                    this.$refs.backgroundImage.style.height = this.reservedHeight + 'px'
                    this.$refs.backgroundImage.style.paddingTop = 0
                    this.$refs.playWrapper.style.display = 'none'
                }else{
                    this.$refs.backgroundImage.style.height = 0
                    this.$refs.backgroundImage.style.paddingTop = '70%'
                    this.$refs.playWrapper.style.display = ''
                }
                this.$refs.backgroundImage.style.zIndex = zIndex
                this.$refs.backgroundImage.style[transform] = `scale(${scale})`
            }
        },
        components: {
            Scroll,
            SongList,
            Loading
        }
    }
</script>

<style scoped lang="less">
    @import "../../common/less/variable.less";
    @import "../../common/less/mixin.less";

    .music-list{
        position: fixed;
        z-index: 100;
        top: 0;
        left: 0;
        bottom: 0;
        right: 0;
        background: @color-background;
        .back{
            position: absolute;
            top: 0;
            .px2rem(left, 12);
            z-index: 50;
            .icon-back{
                display: block;
                .padding(20, 20, 20, 20);
                font-size: @font-size-large-x;
                color: @color-theme;
            }
        }
        .title{
            position: absolute;
            top: 0;
            left: 10%;
            z-index: 40;
            width: 80%;
            .ellipsis(80%);
            text-align: center;
            line-height: 80px;
            font-size: @font-size-large;
            color: @color-text;
        }
        .bg-image{
            position: relative;
            width: 100%;
            height: 0;
            padding-top: 70%;
            transform-origin: top;
            background-size: cover;
            .play-wrapper{
                position: absolute;
                .px2rem(bottom, 40);
                z-index: 50;
                width: 100%;
                 .play{
                    box-sizing: border-box;
                    .px2rem(width, 270);
                    .padding(7, 0, 7, 0);
                    margin: 0 auto;
                    text-align: center;
                    .border(1px, @color-theme);
                    color: @color-theme;
                    .border-radius(200);
                    font-size: 0;
                    .icon-play{
                        display: inline-block;
                        vertical-align: middle;
                        .px2rem(margin-right, 12);
                        .font-size(@font-size-medium-x);
                    }
                    .text{
                        display: inline-block;
                        vertical-align: middle;
                        .font-size(@font-size-small);
                    }
                 }
            }
            .filter{
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(7, 17, 27, 0.4);
            }
        }
        .bg-layer{
            position: relative;
            height: 100%;
            background: @color-background;
        }
        .list{
            position: fixed;
            top: 0;
            bottom: 0;
            width: 100%;
            background: @color-background;
            .song-list-wrapper{
                .padding(20, 30, 20, 30);
            }
            .loading-container{
                position: absolute;
                width: 100%;
                top: 50%;
                transform: translateY(-50%);
            }
        }
    }
</style>


