<template>
    <div class="player" v-show="playlist.length > 0">
        <transition name="normal"
                    @enter = "enter"
                    @after-enter = "afterEnter"

        >
            <div class="normal-player" v-show="fullScreen">
                <div class="background">
                    <img width='100%' height='100%' :src="currentSong.image" ref="normalCD">
                </div>
                <div class="top">
                    <!-- 返回按钮 -->
                    <div class="back" @click="back">
                        <i class="icon-back"></i>
                    </div>
                    <h1 class="title" v-html="currentSong.name"></h1>
                    <h2 class="subtitle" v-html="currentSong.singer"></h2>
                </div>
                <!-- 旋转的cd -->
                <div class="middle" ref="middle">
                    <div class="middle-l">
                        <div class="cd-wrapper" ref="cdWrapper">
                            <div class="cd">
                                <img class="image" :src="currentSong.image">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bottom">
                    <div class="operators">
                        <div class="icon i-left">
                            <i class="icon-sequence"></i>
                        </div>
                        <div class="icon i-left">
                            <i class="icon-prev"></i>
                        </div>
                        <div class="icon i-center">
                            <i class="icon-play"></i>
                        </div>
                        <div class="icon i-right">
                            <i class="icon-next"></i>
                        </div>
                        <div class="icon i-right">
                            <i class="icon icon-not-favorite"></i>
                        </div>
                    </div>
                </div>
            </div>
        </transition>
        <!-- 
            迷你控制
         -->
         <transition name="mini">
            <div class="mini-player" 
                 v-show="!fullScreen" 
                 @click="open"
                 ref="miniPlayer"
            >
                <div class="icon">
                    <img :src="currentSong.image" ref="miniCD">
                </div>
                <div class="text">
                    <h2 class="name" v-html="currentSong.name"></h2>
                    <p class="desc" v-html="currentSong.singer"></p>
                </div>
                <div class="control">
                    <i class="icon-play-mini"></i>
                </div>
                <!-- 打开歌曲列表的按钮 -->
                <div class="control">
                    <i class="icon-playlist"></i>
                </div>
            </div>
         </transition>
    </div>
</template>

<script>
import { mapGetters, mapMutations } from  'vuex'
import animations from 'create-keyframe-animation'
import { prefixStyle } from 'common/js/dom'

const transform = prefixStyle('transfrom');

export default {
    computed: {
        ...mapGetters([
            'fullScreen',
            'playlist',
            'currentSong'
        ])
    },
    methods: {
        // 点击全屏或者变成迷你控制
        open(){
            this.setFullScreen(true);      
        },
        back(){
            this.setFullScreen(false);
            console.log(this.fullScreen);
        },
        enter(el, done) {
            const {x, y, scale} = this._getPosAndScale();
            
            let animation = {
                0: {
                    transform: `translate3d(${x}px, ${y}px, 0) scale(${scale})`
                },
                60: {
                    transform: `translate3d(0, 0px, 0) scale(1.1)`
                },
                100: {
                    transform: `translate3d(0, 0px, 0) scale(1)`
                }
            }
            animations.registerAnimation({
               name: 'move',
               animation,
               presets: {
                   duration: 400,
                   easing: 'linear'
               } 
            });

            animations.runAnimation(this.$refs.cdWrapper, 'move', done)
        },
        afterEnter(el) {
            animations.unregisterAnimation('move')
            this.$refs.cdWrapper.style.animation = ''
        },
        leave(el, done) {
            this.$refs.cdWrapper.style.transition = 'all 0.4s'
            const {x, y, scale} = this._getPosAndScale()
            this.$refs.cdWrapper.style[transform] = `translate3d(${x}px, ${y}px, 0) scale(${scale})`
            // 监听transitionend,完成以后调用afterLeave方法
            this.$refs.cdWrapper.addEventListener('transitionend', done);
            
        },
        afterLeave(el){
            this.$refs.cdWrapper.style.transition = ''
            this.$refs.cdWrapper.style[transform] = ''
        },
        _getPosAndScale() {
            // 先获取迷你cd的width
            const miniCDWidth = this.$refs.miniCD.clientWidth;
            const paddingLeft = this.$refs.miniCD.offsetLeft;
            const paddingBottom = this.$refs.miniPlayer.clientHeight / 2;
            // 获取normal情况下的cd的宽度
            const width = window.innerWidth * 0.8;
            // normal情况下cd的y轴偏移量
            const paddingTop = this.$refs.middle.offsetTop;

            // scale的放大缩小比例
            const scale = miniCDWidth / width;

            // 获取cd从mini状态变为normal状态的偏移量
            const x = -(window.innerWidth/2 - paddingLeft - miniCDWidth / 2);
            const y = window.innerHeight - paddingTop - paddingBottom - width/2 - miniCDWidth / 2;

            return {
                x,
                y,
                scale
            }
        },
        ...mapMutations({
            setFullScreen: 'SET_FULL_SCREEN'
        })
    }
}
</script>

<style lang="less" scoped>
    @import "../../common/less/variable.less";
    @import "../../common/less/mixin.less";

    .player{
        .normal-player{
            position: fixed;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
            z-index: 150;
            background: @color-background;
            .background{
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
                opacity: 0.6;
                filter: blur(20px);
            }
            .top{
                position: relative;
                .px2rem(margin-bottom, 50);
                .back{
                    position: absolute;
                    top: 0;
                    .px2rem(left, 12);
                    z-index: 50;
                    .icon-back{
                        display: block;
                        .padding(9,9,9,9);
                        .font-size(@font-size-large-x);
                        color: @color-theme;
                        transform: rotate(-90deg);
                    }
                }
                .title{
                    .ellipsis();
                    width: 70%;
                    margin: 0 auto;
                    .px2rem(line-height, 80);
                    text-align: center;
                    .font-size(@font-size-large);
                    color: @color-text;
                    text-align: center;
                }
                .subtitle{
                    .px2rem(line-height, 40);
                    text-align: center;
                    .font-size(@font-size-medium);
                    color: @color-text;
                }
            }
            .middle{
                position: fixed;
                width: 100%;
                .px2rem(top, 160);
                .px2rem(bottom, 340);
                white-space: nowrap;
                font-size: 0;
                .middle-l{
                    display: inline-block;
                    vertical-align: top;
                    position: relative;
                    width: 100%;
                    height: 0;
                    padding-top: 80%;
                    .cd-wrapper{
                        position: absolute;
                        left: 10%;
                        top: 0;
                        width: 80%;
                        height: 100%;
                        .cd{
                            width: 100%;
                            height: 100%;
                            box-sizing: border-box;
                            border: 10px solid rgba(255, 255, 255, 0.1);
                            border-radius: 50%;
                            &.play{
                                animation: rotate 20s linear infinite
                            }
                            &.pause{
                                animation-play-state: paused
                            }
                            .image{
                                position: absolute;
                                left: 0;
                                top: 0;
                                width: 100%;
                                height: 100%;
                                border-radius: 50%;
                            }
                        }
                    }
                    .playing-lyric-wrapper{
                        width: 80%;
                        margin: 0px auto 0 auto;
                        .px2rem(margin-top, 60);
                        overflow: hidden;
                        text-align: center;
                        .playing-lyric{
                            .px2rem(height, 40);
                            .px2rem(line-height, 40);
                            .font-size(@font-size-medium);
                            color: @color-text-l;
                        }
                    }
                }
                .middle-r{
                    display: inline-block;
                    vertical-align: top;
                    width: 100%;
                    height: 100%;
                    overflow: hidden;
                    .lyric-wrapper{
                        width: 80%;
                        margin: 0 auto;
                        overflow: hidden;
                        text-align: center;
                        .text{
                            .px2rem(line-height, 54);
                            color: @color-text-l;
                            .font-size(@font-size-medium);
                            &.current{
                                color: @color-text
                            }
                        }
                    }
                }
            }
            .bottom{
                position: absolute;
                .px2rem(bottom, 100);
                width: 100%;
                .dot-wrapper{
                    text-align: center;
                    font-size: 0;
                    .dot{
                        display: inline-block;
                        vertical-align: middle;
                        .margin(0, 8, 0, 8);
                        .px2rem(width, 16);
                        .px2rem(height, 16);
                        border-radius: 50%;
                        background: @color-text-l;
                        &.active{
                            .px2rem(width, 40);
                            .border-radius(10);
                            background: @color-text-ll;
                        }
                    }
                }
                .progress-wrapper{
                    display: flex;
                    align-items: center;
                    width: 80%;
                    margin: 0px auto;
                    .padding(10, 0, 10, 0);
                    .time{
                        color: @color-text;
                        .font-size(@font-size-small);
                        .px2rem(flex-shrink, 0);
                        .px2rem(flex-basis, 60);
                        .px2rem(width, 60);
                        .px2rem(line-height, 60);
                        &.time-l{
                            text-align: left
                        }
                        &.time-r{
                            text-align: right
                        }
                    }
                    .progress-bar-wrapper{
                        flex: 1;
                    }
                }
                .operators{
                    display: flex;
                    align-items: center;
                    .icon{
                        flex: 1;
                        color: @color-theme;
                        &.disable{
                            color: @color-theme-d;
                        }
                        i{
                            .font-size(60);
                        }
                    }
                    .i-left{
                        text-align: right;
                    }
                    .i-center{
                        text-align: center;
                        .padding(0, 20, 0, 20);
                        i{
                            .font-size(80);
                        }
                    }
                    .i-right{
                        text-align: left
                    }
                    .icon-favorite{
                        color: @color-sub-theme;
                    }
                }
            }
            &.normal-enter-active, &.normal-leave-active{
                transition: all 0.4s;
                .top, .bottom {
                    transition: all 0.4s cubic-bezier(0.86, 0.18, 0.82, 1.32);
                }
            }
            &.normal-enter, &.normal-leave-to{
                opacity: 0;
                .top{
                    transform: translate3d(0, -100px, 0);
                }
                .bottom{
                    transform: translate3d(0, 100px, 0);
                }
            }
        }
        .mini-player{
            display: flex;
            align-items: center;
            position: fixed;
            left: 0;
            bottom: 0;
            z-index: 180;
            width: 100%;
            .px2rem(height, 120);
            background: @color-highlight-background;
            &.mini-enter-active, &.mini-leave-active{
                transition: all 0.4s;
            }
            &.mini-enter, &.mini-leave-to{
                opacity: 0
            }
            .icon{
                .px2rem(flex-shrink, 0);
                .px2rem(flex-basis, 80);
                .px2rem(width, 80);
                .padding(0, 10, 0, 20);
                img{
                    border-radius: 50%;
                    .px2rem(width, 80);
                    .px2rem(height, 80);
                    &.play{
                        animation: rotate 10s linear infinite;
                    }
                    &.pause{
                        animation-play-state: paused;
                    }
                }
            }
            .text{
                display: flex;
                flex-direction: column;
                justify-content: center;
                flex: 1;
                .px2rem(line-height, 40);
                overflow: hidden;
                .name{
                    .px2rem(margin-bottom, 4);
                    .ellipsis();
                    .font-size(@font-size-medium);
                    color: @color-text
                }
                .desc{
                    .ellipsis();
                    .font-size(@font-size-small);
                    color: @color-text-d;
                }
            }
            .control{
                .px2rem(flex-shrink, 0);
                .px2rem(flex-basis, 60);
                .px2rem(width, 60);
                .padding(0, 30, 0, 30);
                .icon-play-mini, .icon-pause-mini, .icon-playlist{
                    color: @color-theme-d;
                    .font-size(60);
                }
                .icon-mini{
                    .font-size(64);
                    position: absolute;
                    left: 0;
                    top: 0;
                }
            }
        }
    }
    @keyframes rotate{
        0%{
            transform: rotate(0)
        }
        100%{
            transform: rotate(360deg)
        }
    }
</style>


