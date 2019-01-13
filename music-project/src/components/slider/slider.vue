<template>
    <div class="swiper-container" ref="swiperContainer">
        <div class="swiper-wrapper">
            <slot :cont="data" name="music-hall"></slot>
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
            this.swiper = new Swiper(this.$refs.swiperContainer, {
                slidesPerView: 'auto',
                observer: true
            });
        }
    },
    watch: {
        data() {
            this.swiper.update();
        }
    }
}
</script>


<style lang="less" scoped>

</style>
