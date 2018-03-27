<template>
    <div ref="scrollWraper">
        <slot>
        </slot>
    </div>
</template>

<script>
import BScroll from 'better-scroll'
    export default {
        props: {
            probeType: {
                type: Number,
                default: 1
            },
            // 默认派发点击事件
            click: {
                type: Boolean,
                default: true
            },
            // 接收父组件传过来的数据
            data: {
                type: Array,
                default: null
            },
            listenScroll: {
                type: Boolean,
                default: false
            }
        },
        mounted(){
            setTimeout(() => {
                // 初始化scroll
                this._initScroll();
            },20);
        },
        methods: {
            _initScroll(){
                //  先判断dom存在不存在，如果不存在这返回
                if(!this.$refs.scrollWraper){
                    return;
                }
                 this.scroll = new BScroll(this.$refs.scrollWraper, {
                     probeType: this.probeType,
                     click: this.click
                 });

                if(this.listenScroll){
                    // 在this.scroll中this不指向vue实例对象
                    let self = this
                    this.scroll.on("scroll", (pos) => {
                        self.$emit("scroll", pos);
                    });
                }


            },
            enable(){
                this.scroll && this.scroll.enable()
            },
            disable(){
                this.scroll && this.scroll.disable()
            },
            refresh(){
                this.scroll && this.scroll.refresh()
            },
            scrollTo(){
                this.scroll && this.scroll.scrollTo.apply(this.scroll, arguments)
            },
            scrollToElement(){
                this.scroll && this.scroll.scrollToElement.apply(this.scroll, arguments)
            }
        },
        watch: {
            // 监听父级传过来的数据，如果变化，重新计算better-scroll
            data(){
                setTimeout(() => {
                    this.refresh();
                },20);
            }
        }
    }
</script>
