<template>
    <transition name="slider">
        <music-list :songs="songs"
                    :title="title"
                    :bg-image="bgImage"
        ></music-list>
    </transition>
</template>

<script>
    import { mapState } from 'vuex'
    import { getSingerDetail } from 'api/getSinger'
    import { ERR_OK } from 'api/config'
    import { createSong } from 'common/js/song'
    import musicList from 'components/music-list/music-list'
    export default {
        data(){
            return {
                songs: []
            }
        },
        computed: {
            title(){
                return this.singer.name
            },
            bgImage(){    
                return this.singer.avatar
            },
            ...mapState([
                'singer'
            ])
        },
        mounted(){
            // 一般情况下在this.$el虚拟dom替换真是dom以后请求后台收据
            this._getDetail();
        },
        methods: {
            // 获取详情页面的数据
            _getDetail(){
                // 这里需要判断，如果是web端，当用户在详情页面刷新以后，获取不到singer.id，就刷新页面，回退到歌手列表页面
                // 这里本来用的getters,由于getters在页面刷新以后，再次点击数据不更新，所以改用state
                if(!this.singer){
                    this.$router.push('/singer')
                    return ;
                }
                getSingerDetail(this.singer.id).then(res => {
                    if(res.code === ERR_OK){
                        this.songs = this._normalSongs(res.data.list);
                    }
                })
            },
            // 歌手数据初始化
            _normalSongs(list){
                let ret = [];
                list.forEach((item) => {
                    let { musicData } = item
                    if(musicData.songid && musicData.albummid){
                        ret.push(createSong(musicData));
                    }
                });
                return ret;
            }
        },
        components: {
            musicList
        }
    }
</script>

<style lang="less" scoped>
    @import "../../common/less/variable.less";
    @import "../../common/less/mixin.less";

    .slider-enter-active, .slider-leave-active{
        transition: all .5s
    }
    .slider-enter, .slider-leave-to{
        transform: translate3d(100%, 0, 0)
    }
</style>

