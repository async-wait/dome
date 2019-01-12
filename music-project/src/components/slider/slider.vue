<template>
    <div class="swiper-container" ref="swiperContainer">
        <div class="swiper-wrapper">
            <slot :cont="data">
                <div class="swiper-slide">slider1</div>
                <div class="swiper-slide">slider2</div>
                <div class="swiper-slide">slider3</div>
            </slot>
        </div>
    </div>
</template>

<script>
import 'swiper/dist/css/swiper.css';
import Swiper from 'swiper';
export default {
    name: 'slider',
    props: {
        data: {
            default: null
        }
    },
    mounted () {
        this.$nextTick(() => {
            this._initSwiper();
        });
    },
    methods: {
        _initSwiper() {
            this.swiper = new Swiper(this.$refs.swiperContainer);
        }
    },
    components: {
        
    }
}
</script>


<style lang="less" scoped>

</style>
