<template>
    <div class="personalized" :class="bgClass">
        <div class="main">
            <div class="title">{{this.title}}</div>
            <div class="tab" v-if="tab.length">
                <li v-for="(item, index) in tab" :key="index" :class="{'active': index===0}">{{item}}</li>
            </div>
            <div class="content" :class="className">
                <slider :data="data">
                    <template slot-scope="{cont}">
                        <div class="swiper-slide"
                            v-for="(item, index) in cont" :key="index">
                            <div v-for="cont in item" :key="cont.id">
                                <div class="img">
                                    <img :src="cont.picUrl">
                                </div>
                                <div class="name">{{cont.name}}</div>
                                <div class="plary-num">播放量：{{cont.playCount}}</div>
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
        height: 532px;
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
                    img {
                        height: 224px;
                    }
                }
                .name {
                    .ellipsis();
                    margin-top: 8px;
                    margin-bottom: 4px;
                }
            }
        }
    }
}
</style>
