<template>
    <div class="music-list">
        <div class="back">
            <i class="icon-back"></i>
        </div>
        <h1 class="title" v-html="title"></h1>
        <div class="bg-image" 
             :style="bgStyle" 
             ref="backgroundImage" 
             style="position:relative"
        >
            <div class="filter"></div>
        </div>
        <scroll :data="songs" class="list" ref="list">
            <div class="song-list-wrapper">
                <song-list :songs="songs"></song-list>
            </div>
        </scroll>
    </div>
</template>

<script>
    import Scroll from 'base/scroll/scroll'
    import SongList from 'base/song-list/song-list'
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
        mounted(){
            console.log(this.$refs.list);
            this.$refs.list.$el.style.top = `${this.$refs.backgroundImage.clientHeight}px`
        },
        computed: {
            bgStyle(){
                return `background-image:url(${this.bgImage})`
            }
        },
        components: {
            Scroll,
            SongList
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


