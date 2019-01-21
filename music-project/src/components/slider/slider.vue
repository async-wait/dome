<template>
    <div class="swiper-container" ref="swiperContainer">
        <div class="swiper-wrapper">
            <slot :cont="data" name="music-hall"></slot>
        </div>
        <div class="swiper-pagination"></div>
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
        },
        isPagination: {
            type: Object,
            default: function () {
                return {
                    el: '.swiper-pagination',
                    bulletElement : 'li',
                }
            }
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
                observer: true,
                pagination: this.isPagination
            });
        }
    },
    watch: {
        data() {
            this.$nextTick(() => {
                this.swiper.update();
            });
        }
    }
}
</script>


<style lang="less" scoped>

</style>
