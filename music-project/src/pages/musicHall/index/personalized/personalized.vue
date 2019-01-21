<template>
    <div class="personalized" :class="bgClass">
        <div class="main">
            <div class="title">{{this.title}}</div>
            <div class="tab" v-if="tab.length">
                <li v-for="(item, index) in tab" :key="index" :class="{'active': index===0}">{{item}}</li>
            </div>
            <div class="content" :class="className">
                <slider :data="data">
                    <template slot-scope="{cont}" slot="music-hall">
                        <div class="swiper-slide"
                            v-for="(item, index) in cont" :key="index">
                            <div v-for="cont in item" :key="cont.id">
                                <div class="img">
                                    <img :src="cont.picUrl">
                                    <div class="play-wp">
                                        <div class="iconfont icon-material"></div>
                                    </div>
                                </div>
                                <div class="name">{{cont.name}}</div>
                                <div class="play-num">播放量：{{playCount(cont.playCount)}}万</div>
                            </div>
                        </div>
                    </template>
                </slider>
            </div>
        </div>
    </div>
</template>

<script>
import Slider from '@/components/slider/slider';
export default {
    name: 'personalized',
    props: {
        bgcolor: {
            type: String,
            default: ''
        },
        title: {
            type: String,
            default: '歌单推荐'
        },
        tab: {
            type: Array,
            default: function () {
                return []
            }
        },
        data: {
            default: null
        },
        className: {
            type: String,
            default: ''
        }
    },
    methods: {
        playCount(num) {
            num = num / 10000;
            return num.toFixed(2);
        }
    },
    computed: {
        bgClass() {  // 修改背景颜色
            return this.bgcolor === 'gray' ? 'gray' : 'default';
        }
    },
    components: {
        Slider
    }
}
</script>

<style lang="less" scoped>
@import url('../../../../common/less/mixin.less');
.personalized {
    text-align: center;
    &.gray {
        background: #f5f5f5;
    }
    &.default {
        background: #fff;
    }
    .main {
        padding-bottom: 15px;
        .title {
            color: #383838;
            font-size: 30px;
            font-weight: 700;
            padding-top: 50px;
        }
        .tab {
            display: flex;
            justify-content: center;
            margin-top: 24px;
            li {
                width: 50px;
                height: 22px;
                line-height: 22px;
                cursor: pointer;
                margin-right: 32px;
                &:nth-last-of-type(1) {
                    margin-right: 0px;
                }
                &.active {
                    color: #3ac17e;
                }
            }
        }
        .recommend {
            .swiper-slide {
                display: flex;
                justify-content: center;
                margin-top: 28px;
                &>div {
                    margin-right: 20px;
                    width: 224px;
                    overflow: hidden;
                    text-align: left;
                    font-size: 14px;
                    color: #505050;
                    &:nth-last-of-type(1) {
                        margin-right: 0px;
                    }
                }
                .img {
                    height: 224px;
                    cursor: pointer;
                    overflow: hidden;
                    position: relative;
                    img {
                        height: 224px;
                        transition: all 0.75s;
                    }
                    &:hover {
                       img, .play-wp {
                            transform: scale(1.07);
                       }
                       .play-wp {
                          opacity: 1;
                       }
                    }
                    .play-wp {
                        position: absolute;
                        left: 0px;
                        right: 0px;
                        top: 0px;
                        bottom: 0px;
                        background-color: rgba(0, 0, 0, 0.2);
                        transition: all 0.75s ease;
                        opacity: 0;
                        .icon-material {
                            position: absolute;
                            top: 50%;
                            left: 50%;
                            color: #fff;
                            transform: translate3d(-50%, -50%, 0);
                            font-size: 60px;
                        }
                    }
                }
                .name {
                    .ellipsis();
                    margin-top: 8px;
                    line-height: 22px;
                    cursor: pointer;
                    &:hover {
                        color: #3ac17e;
                    }
                }
                .play-num {
                    color: #999;
                    line-height: 22px;
                }
            }
        }
    }
}
</style>
