<template>
    <div class="slider" ref="slider">
        <div class="slider-group" ref="sliderGroup">
            <slot>
            </slot>
        </div>
        <div class="dots">
            <span class="dot" v-for="(item, index) in dots" :class="{'active': currentPageIndex === index}"></span>
        </div>
    </div>
</template>

<script>
    import BScroll from 'better-scroll'
    import { addClass } from 'common/js/dom'
    export default {
        // 用来接收来自于父组件的传值
        props: {
            // 是否循环播放
            loop: {
                type: Boolean,
                default: true
            },
            // 是否自动播放
            autoPlay: {
                type: Boolean,
                default: false
            },
            // 播放下一张时间
            interval: {
                type: Number,
                default: 4000
            }
        },
        data(){
            return {
                dots: [],
                currentPageIndex: 0
            }
        },
        methods: {
            _setSliderWidth(resizeWidth){
                this.children = this.$refs.sliderGroup.children
                
                
                let width = 0   
                let sliderWidth = this.$refs.slider.clientWidth
                for(let i = 0; i < this.children.length; i++){
                    let child = this.children[i]
                    addClass(child, 'slider-item')

                    child.style.width = sliderWidth + "px"
                    width += sliderWidth
                }
                if(this.loop && !resizeWidth){
                    width += 2 * sliderWidth
                }
                this.$refs.sliderGroup.style.width = width + "px"
            },
            _initSlider(){
                this.slider = new BScroll(this.$refs.slider, {
                    scrollX: true,
                    scrollY: false,
                    momentum: false,
                    snap: {
                        loop: this.loop,
                        threshold: 0.3,
                        speed: 400
                    },
                });

                // 轮播图相对应的下角标
                this.slider.on("scrollEnd",() => {
                    let pageIndex = this.slider.getCurrentPage().pageX
                    this.currentPageIndex = pageIndex;

                    // 轮播图自动轮播
                    // 如果props中autoPlay设置为true，则自动轮播
                    if(this.autoPlay){
                        clearTimeout(this.timer)
                        this._play()
                    }
                });

            },
            _dots(){
                this.dots = new Array(this.children.length)
            },
            _play(){
                let pageIndex = this.currentPageIndex + 1;
                this.timer = setTimeout(() => {
                    this.slider.goToPage(pageIndex, 0, 400);
                },this.interval);
            }
        },
        mounted(){
            setTimeout(() => {
                this._setSliderWidth()
                this._dots()
                this._initSlider()

                // 监听屏幕尺寸的变化，然后调整dom的宽度
                window.addEventListener('resize', () => {
                    // 先判断轮播效果有没有，如果没有的话，则返回。如果有就重新改变宽度
                    if(!this.slider){
                        return
                    }

                    this._setSliderWidth(true);
                    this.slider.refresh();
                });

                 if(this.autoPlay){
                    this._play()
                }
            },20)
        },
        // 组件销毁时候调用，如果该组件中存在定时器，组件销毁时注意清除掉
        beforeDestroy(){
            clearTimeout(this.timer);
        },
        destroyed(){
            clearTimeout(this.timer);
        }
    }
</script>

<style scoped lang="less">
    @import "../../common/less/variable.less";
    @import "../../common/less/mixin.less";

  .slider{
    .px2rem(min-height,2);
    position: relative;
    .slider-group{
      position: relative;
      overflow: hidden;
      white-space: nowrap;
      .slider-item{
        float: left;
        box-sizing: border-box;
        overflow: hidden;
        text-align: center;
        a{
          display: block;
          width: 100%;
          overflow: hidden;
          text-decoration: none;
        }
        img{
          display: block;
          width: 100%;
        }
      }
    }
    .dots{
      position: absolute;
      right: 0;
      left: 0;
      .px2rem(bottom,24);
      text-align: center;
      font-size: 0;
      .dot{
        display: inline-block;
        margin: 0 4px;
        .px2rem(margin-top,0);
        .px2rem(margin-bottom,0);
        .px2rem(margin-left,8);
        .px2rem(margin-right,8);
        .px2rem(width,16);
        .px2rem(height,16);
        border-radius: 50%;
        background: @color-text-l;
        &.active{
          .px2rem(width,40);
          .px2rem(border-radius,10);
          background: @color-text-ll;
        }
      }
    }
  }
</style>

